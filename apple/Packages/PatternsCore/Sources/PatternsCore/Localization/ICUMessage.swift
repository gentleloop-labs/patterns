import Foundation

/// A value substituted into a message placeholder.
public enum MessageArgument: Sendable, Equatable, ExpressibleByStringLiteral, ExpressibleByIntegerLiteral {
    case string(String)
    case int(Int)

    public init(stringLiteral value: String) { self = .string(value) }
    public init(integerLiteral value: Int) { self = .int(value) }

    /// Dart interpolates both with `toString()` (gen_l10n with no `format`).
    var text: String {
        switch self {
        case let .string(s): return s
        case let .int(i): return String(i)
        }
    }
}

/// The ICU MessageFormat subset Flutter's gen_l10n supports, evaluated the
/// way `intl` does: `{name}`, `{n, plural, =0{} one{} other{}}` and
/// `{x, select, a{} other{}}`, nested to any depth. No apostrophe escaping
/// (gen_l10n's default `use-escaping: false`).
public indirect enum ICUMessage: Equatable, Sendable {
    case text(String)
    case argument(String)
    /// Cases keyed as gen_l10n passes them to `Intl.pluralLogic`: `=0`, `=1`
    /// and `=2` are folded into `zero`, `one` and `two`.
    case plural(String, categories: [String: [ICUMessage]])
    case select(String, cases: [String: [ICUMessage]])

    public struct ParseError: Error, CustomStringConvertible {
        public let description: String
    }

    // MARK: Parsing

    public static func parse(_ source: String) throws -> [ICUMessage] {
        var parser = Parser(chars: Array(source))
        let parts = try parser.parseSequence(terminator: nil)
        guard parser.index == parser.chars.count else { throw ParseError(description: "Unbalanced '}' in \(source)") }
        return parts
    }

    private struct Parser {
        let chars: [Character]
        var index = 0

        mutating func parseSequence(terminator: Character?) throws -> [ICUMessage] {
            var parts: [ICUMessage] = []
            var buffer = ""
            func flush() {
                if !buffer.isEmpty { parts.append(.text(buffer)); buffer = "" }
            }
            while index < chars.count {
                let c = chars[index]
                if c == "}" {
                    if terminator == "}" { flush(); return parts }
                    // A stray brace is literal text in intl.
                    buffer.append(c); index += 1; continue
                }
                if c == "{", let placeholder = try parsePlaceholder() {
                    flush()
                    parts.append(placeholder)
                    continue
                }
                buffer.append(c)
                index += 1
            }
            if terminator != nil { throw ParseError(description: "Unterminated '{'") }
            flush()
            return parts
        }

        /// At a `{`. Returns nil (consuming nothing) if this is not a
        /// placeholder, in which case the brace is literal text.
        mutating func parsePlaceholder() throws -> ICUMessage? {
            let start = index
            index += 1
            skipSpaces()
            let name = readIdentifier()
            guard !name.isEmpty else { index = start; return nil }
            skipSpaces()
            guard index < chars.count else { index = start; return nil }
            if chars[index] == "}" {
                index += 1
                return .argument(name)
            }
            guard chars[index] == "," else { index = start; return nil }
            index += 1
            skipSpaces()
            let kind = readIdentifier()
            skipSpaces()
            guard index < chars.count, chars[index] == "," else { index = start; return nil }
            index += 1
            switch kind {
            case "plural":
                var categories: [String: [ICUMessage]] = [:]
                try parseCases { key, body in
                    let slot: String
                    switch key {
                    case "=0": slot = "zero"
                    case "=1": slot = "one"
                    case "=2": slot = "two"
                    default: slot = key
                    }
                    // gen_l10n keeps the first case written for a slot.
                    if categories[slot] == nil { categories[slot] = body }
                }
                return .plural(name, categories: categories)
            case "select":
                var cases: [String: [ICUMessage]] = [:]
                try parseCases { key, body in cases[key] = body }
                return .select(name, cases: cases)
            default:
                index = start
                return nil
            }
        }

        mutating func parseCases(_ add: (String, [ICUMessage]) -> Void) throws {
            while true {
                skipWhitespace()
                guard index < chars.count else { throw ParseError(description: "Unterminated plural/select") }
                if chars[index] == "}" { index += 1; return }
                var key = ""
                while index < chars.count, chars[index] != "{", !chars[index].isWhitespace {
                    key.append(chars[index]); index += 1
                }
                skipWhitespace()
                guard index < chars.count, chars[index] == "{", !key.isEmpty else {
                    throw ParseError(description: "Expected '{' after case \(key)")
                }
                index += 1
                let body = try parseSequence(terminator: "}")
                guard index < chars.count, chars[index] == "}" else { throw ParseError(description: "Unterminated case") }
                index += 1
                add(key, body)
            }
        }

        mutating func readIdentifier() -> String {
            var out = ""
            while index < chars.count, chars[index].isLetter || chars[index].isNumber || chars[index] == "_" {
                out.append(chars[index]); index += 1
            }
            return out
        }

        mutating func skipSpaces() {
            while index < chars.count, chars[index] == " " { index += 1 }
        }

        mutating func skipWhitespace() {
            while index < chars.count, chars[index].isWhitespace { index += 1 }
        }
    }

    // MARK: Formatting

    public static func format(_ parts: [ICUMessage], locale: String, arguments: [String: MessageArgument]) -> String {
        var out = ""
        for part in parts {
            switch part {
            case let .text(s):
                out += s
            case let .argument(name):
                out += arguments[name]?.text ?? ""
            case let .plural(name, categories):
                let n: Int
                switch arguments[name] {
                case let .int(i)?: n = i
                case let .string(s)?: n = Int(s) ?? 0
                case nil: n = 0
                }
                // Intl.pluralLogic: explicit zero/one/two for 0/1/2 first,
                // then the locale's CLDR category, falling back to "other".
                let body = (n == 0 ? categories["zero"] : nil)
                    ?? (n == 1 ? categories["one"] : nil)
                    ?? (n == 2 ? categories["two"] : nil)
                    ?? categories[PluralRules.category(for: n, locale: locale)]
                    ?? categories["other"]
                    ?? []
                out += format(body, locale: locale, arguments: arguments)
            case let .select(name, cases):
                let key = arguments[name]?.text ?? "other"
                let body = cases[key] ?? cases["other"] ?? []
                out += format(body, locale: locale, arguments: arguments)
            }
        }
        return out
    }
}

/// CLDR cardinal plural rules for the app's languages, for integer counts,
/// as implemented by Dart's `intl` package.
public enum PluralRules {
    public static func category(for n: Int, locale: String) -> String {
        let language = locale.split(whereSeparator: { $0 == "-" || $0 == "_" }).first.map(String.init) ?? locale
        let i = abs(n)
        switch language {
        case "ja":
            return "other"
        case "fr":
            if i == 0 || i == 1 { return "one" }
            if i != 0 && i % 1_000_000 == 0 { return "many" }
            return "other"
        case "pt":
            // pt and pt-BR: i = 0..1 is "one".
            if i == 0 || i == 1 { return "one" }
            if i != 0 && i % 1_000_000 == 0 { return "many" }
            return "other"
        case "es":
            if i == 1 { return "one" }
            if i != 0 && i % 1_000_000 == 0 { return "many" }
            return "other"
        default: // en, de
            return i == 1 ? "one" : "other"
        }
    }
}
