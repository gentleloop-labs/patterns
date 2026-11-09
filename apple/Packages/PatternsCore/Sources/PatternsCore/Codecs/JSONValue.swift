import Foundation

/// A JSON value that keeps object key order and distinguishes integers from
/// doubles, the way Dart's `jsonDecode`/`jsonEncode` do.
///
/// The Flutter backup validator rejects `1.0` where it expects an int, so the
/// native importer has to see the same distinction instead of `NSNumber`.
public indirect enum JSONValue: Equatable, Sendable {
    case null
    case bool(Bool)
    case int(Int64)
    case double(Double)
    case string(String)
    case array([JSONValue])
    case object([(String, JSONValue)])

    public static func == (lhs: JSONValue, rhs: JSONValue) -> Bool {
        switch (lhs, rhs) {
        case (.null, .null): return true
        case let (.bool(a), .bool(b)): return a == b
        case let (.int(a), .int(b)): return a == b
        case let (.double(a), .double(b)): return a == b
        case let (.string(a), .string(b)): return a == b
        case let (.array(a), .array(b)): return a == b
        case let (.object(a), .object(b)):
            // Key order is cosmetic; equality is by content.
            guard a.count == b.count else { return false }
            let bDict = Dictionary(b, uniquingKeysWith: { first, _ in first })
            return a.allSatisfy { key, value in bDict[key] == value }
        default: return false
        }
    }

    public subscript(key: String) -> JSONValue? {
        guard case let .object(pairs) = self else { return nil }
        return pairs.first(where: { $0.0 == key })?.1
    }

    public var stringValue: String? {
        if case let .string(s) = self { return s }
        return nil
    }

    public var intValue: Int64? {
        if case let .int(i) = self { return i }
        return nil
    }

    public var arrayValue: [JSONValue]? {
        if case let .array(a) = self { return a }
        return nil
    }

    public var isNull: Bool {
        if case .null = self { return true }
        return false
    }
}

// MARK: - Decoding

public struct JSONParseError: Error, CustomStringConvertible {
    public let description: String
}

extension JSONValue {
    /// Parses JSON text. Numbers without a fraction or exponent become
    /// `.int`, matching Dart's `jsonDecode`.
    public static func parse(_ data: Data) throws -> JSONValue {
        var parser = Parser(bytes: Array(data))
        parser.skipWhitespace()
        let value = try parser.parseValue()
        parser.skipWhitespace()
        guard parser.index == parser.bytes.count else {
            throw JSONParseError(description: "Unexpected trailing characters")
        }
        return value
    }

    public static func parse(_ string: String) throws -> JSONValue {
        try parse(Data(string.utf8))
    }

    private struct Parser {
        let bytes: [UInt8]
        var index = 0
        var depth = 0

        init(bytes: [UInt8]) {
            // Tolerate a UTF-8 byte order mark.
            if bytes.starts(with: [0xEF, 0xBB, 0xBF]) {
                self.bytes = Array(bytes.dropFirst(3))
            } else {
                self.bytes = bytes
            }
        }

        mutating func skipWhitespace() {
            while index < bytes.count, [0x20, 0x09, 0x0A, 0x0D].contains(bytes[index]) { index += 1 }
        }

        func fail(_ message: String) -> JSONParseError {
            JSONParseError(description: "\(message) at offset \(index)")
        }

        mutating func parseValue() throws -> JSONValue {
            guard index < bytes.count else { throw fail("Unexpected end of input") }
            switch bytes[index] {
            case UInt8(ascii: "{"): return try parseObject()
            case UInt8(ascii: "["): return try parseArray()
            case UInt8(ascii: "\""): return .string(try parseString())
            case UInt8(ascii: "t"): try expect("true"); return .bool(true)
            case UInt8(ascii: "f"): try expect("false"); return .bool(false)
            case UInt8(ascii: "n"): try expect("null"); return .null
            default: return try parseNumber()
            }
        }

        mutating func expect(_ literal: String) throws {
            let lit = Array(literal.utf8)
            guard index + lit.count <= bytes.count, Array(bytes[index..<index + lit.count]) == lit else {
                throw fail("Invalid literal")
            }
            index += lit.count
        }

        mutating func parseObject() throws -> JSONValue {
            depth += 1
            guard depth < 512 else { throw fail("Nesting too deep") }
            defer { depth -= 1 }
            index += 1
            var pairs: [(String, JSONValue)] = []
            skipWhitespace()
            if index < bytes.count, bytes[index] == UInt8(ascii: "}") { index += 1; return .object(pairs) }
            while true {
                skipWhitespace()
                guard index < bytes.count, bytes[index] == UInt8(ascii: "\"") else { throw fail("Expected key") }
                let key = try parseString()
                skipWhitespace()
                guard index < bytes.count, bytes[index] == UInt8(ascii: ":") else { throw fail("Expected ':'") }
                index += 1
                skipWhitespace()
                let value = try parseValue()
                // Dart keeps the last value for a duplicate key.
                if let existing = pairs.firstIndex(where: { $0.0 == key }) {
                    pairs[existing].1 = value
                } else {
                    pairs.append((key, value))
                }
                skipWhitespace()
                guard index < bytes.count else { throw fail("Unterminated object") }
                if bytes[index] == UInt8(ascii: ",") { index += 1; continue }
                if bytes[index] == UInt8(ascii: "}") { index += 1; return .object(pairs) }
                throw fail("Expected ',' or '}'")
            }
        }

        mutating func parseArray() throws -> JSONValue {
            depth += 1
            guard depth < 512 else { throw fail("Nesting too deep") }
            defer { depth -= 1 }
            index += 1
            var items: [JSONValue] = []
            skipWhitespace()
            if index < bytes.count, bytes[index] == UInt8(ascii: "]") { index += 1; return .array(items) }
            while true {
                skipWhitespace()
                items.append(try parseValue())
                skipWhitespace()
                guard index < bytes.count else { throw fail("Unterminated array") }
                if bytes[index] == UInt8(ascii: ",") { index += 1; continue }
                if bytes[index] == UInt8(ascii: "]") { index += 1; return .array(items) }
                throw fail("Expected ',' or ']'")
            }
        }

        mutating func parseString() throws -> String {
            index += 1
            var scalars = String.UnicodeScalarView()
            var raw: [UInt8] = []
            func flushRaw() throws {
                guard !raw.isEmpty else { return }
                guard let s = String(bytes: raw, encoding: .utf8) else { throw fail("Invalid UTF-8") }
                scalars.append(contentsOf: s.unicodeScalars)
                raw.removeAll(keepingCapacity: true)
            }
            while true {
                guard index < bytes.count else { throw fail("Unterminated string") }
                let byte = bytes[index]
                if byte == UInt8(ascii: "\"") {
                    index += 1
                    try flushRaw()
                    return String(scalars)
                }
                if byte < 0x20 { throw fail("Control character in string") }
                if byte != UInt8(ascii: "\\") {
                    raw.append(byte)
                    index += 1
                    continue
                }
                try flushRaw()
                index += 1
                guard index < bytes.count else { throw fail("Bad escape") }
                let escape = bytes[index]
                index += 1
                switch escape {
                case UInt8(ascii: "\""): scalars.append("\"")
                case UInt8(ascii: "\\"): scalars.append("\\")
                case UInt8(ascii: "/"): scalars.append("/")
                case UInt8(ascii: "b"): scalars.append("\u{08}")
                case UInt8(ascii: "f"): scalars.append("\u{0C}")
                case UInt8(ascii: "n"): scalars.append("\n")
                case UInt8(ascii: "r"): scalars.append("\r")
                case UInt8(ascii: "t"): scalars.append("\t")
                case UInt8(ascii: "u"):
                    var code = try parseHex4()
                    if (0xD800...0xDBFF).contains(code),
                       index + 1 < bytes.count, bytes[index] == UInt8(ascii: "\\"), bytes[index + 1] == UInt8(ascii: "u") {
                        let save = index
                        index += 2
                        let low = try parseHex4()
                        if (0xDC00...0xDFFF).contains(low) {
                            code = 0x10000 + ((code - 0xD800) << 10) + (low - 0xDC00)
                        } else {
                            index = save
                        }
                    }
                    // Lone surrogates become U+FFFD rather than failing.
                    scalars.append(Unicode.Scalar(code) ?? "\u{FFFD}")
                default: throw fail("Bad escape")
                }
            }
        }

        mutating func parseHex4() throws -> UInt32 {
            guard index + 4 <= bytes.count,
                  let s = String(bytes: bytes[index..<index + 4], encoding: .ascii),
                  let value = UInt32(s, radix: 16) else { throw fail("Bad unicode escape") }
            index += 4
            return value
        }

        mutating func parseNumber() throws -> JSONValue {
            let start = index
            var isInteger = true
            if index < bytes.count, bytes[index] == UInt8(ascii: "-") { index += 1 }
            while index < bytes.count {
                let b = bytes[index]
                if (UInt8(ascii: "0")...UInt8(ascii: "9")).contains(b) {
                    index += 1
                } else if b == UInt8(ascii: ".") || b == UInt8(ascii: "e") || b == UInt8(ascii: "E")
                            || b == UInt8(ascii: "+") || (b == UInt8(ascii: "-") && index > start) {
                    isInteger = false
                    index += 1
                } else {
                    break
                }
            }
            guard index > start, let text = String(bytes: bytes[start..<index], encoding: .ascii) else {
                throw fail("Invalid value")
            }
            if isInteger, let int = Int64(text) { return .int(int) }
            guard let double = Double(text) else { throw fail("Invalid number") }
            return .double(double)
        }
    }
}

// MARK: - Encoding

extension JSONValue {
    /// Serialises like Dart's `jsonEncode`: compact, keys in order, only
    /// quotes, backslashes and control characters escaped.
    public func encoded() -> String {
        var out = ""
        write(into: &out)
        return out
    }

    private func write(into out: inout String) {
        switch self {
        case .null: out += "null"
        case let .bool(b): out += b ? "true" : "false"
        case let .int(i): out += String(i)
        case let .double(d):
            if d.isFinite, d == d.rounded(), abs(d) < 1e21 {
                out += String(format: "%.1f", d)
            } else {
                out += "\(d)"
            }
        case let .string(s): JSONValue.writeString(s, into: &out)
        case let .array(items):
            out += "["
            for (i, item) in items.enumerated() {
                if i > 0 { out += "," }
                item.write(into: &out)
            }
            out += "]"
        case let .object(pairs):
            out += "{"
            for (i, pair) in pairs.enumerated() {
                if i > 0 { out += "," }
                JSONValue.writeString(pair.0, into: &out)
                out += ":"
                pair.1.write(into: &out)
            }
            out += "}"
        }
    }

    private static func writeString(_ s: String, into out: inout String) {
        out += "\""
        for scalar in s.unicodeScalars {
            switch scalar {
            case "\"": out += "\\\""
            case "\\": out += "\\\\"
            case "\u{08}": out += "\\b"
            case "\u{0C}": out += "\\f"
            case "\n": out += "\\n"
            case "\r": out += "\\r"
            case "\t": out += "\\t"
            default:
                if scalar.value < 0x20 {
                    out += String(format: "\\u%04x", scalar.value)
                } else {
                    out.unicodeScalars.append(scalar)
                }
            }
        }
        out += "\""
    }
}
