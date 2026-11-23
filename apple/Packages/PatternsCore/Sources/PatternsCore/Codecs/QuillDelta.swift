import Foundation

/// One Quill Delta insert operation, as stored in the `journal.content`
/// column by the Flutter app (`lib/widgets/rich_journal.dart`).
///
/// Everything is kept as JSON so attributes the native editor does not know
/// (headers, colours, links...) survive an edit untouched.
public struct DeltaOp: Equatable, Sendable {
    public enum Insert: Equatable, Sendable {
        case text(String)
        /// A non-text embed (image, divider...). Rendered as U+FFFC in plain text.
        case embed(JSONValue)
    }

    public var insert: Insert
    /// The op's `attributes` object, in stored order. Nil when absent.
    public var attributes: JSONValue?

    public init(insert: Insert, attributes: JSONValue? = nil) {
        self.insert = insert
        self.attributes = attributes
    }

    public init(text: String, attributes: [(String, JSONValue)] = []) {
        self.insert = .text(text)
        self.attributes = attributes.isEmpty ? nil : .object(attributes)
    }

    public func attribute(_ name: String) -> JSONValue? { attributes?[name] }

    var json: JSONValue {
        var pairs: [(String, JSONValue)] = []
        switch insert {
        case let .text(s): pairs.append(("insert", .string(s)))
        case let .embed(value): pairs.append(("insert", value))
        }
        if let attributes { pairs.append(("attributes", attributes)) }
        return .object(pairs)
    }
}

/// A styled run of text for read-only rendering (previews, PDF export).
/// Mirrors `RichRun` in `lib/widgets/rich_journal.dart`.
public struct RichRun: Equatable, Sendable {
    public let text: String
    public let bold: Bool
    public let italic: Bool

    public init(_ text: String, bold: Bool = false, italic: Bool = false) {
        self.text = text
        self.bold = bold
        self.italic = italic
    }
}

/// The body of a journal entry: either Quill Delta ops or legacy plain text
/// written before rich text existed.
public enum JournalContent: Equatable, Sendable {
    case delta([DeltaOp])
    case plain(String)

    /// Decodes stored content with the same fallbacks as the Flutter app:
    /// anything that is not a valid, non-empty list of insert ops is treated
    /// as plain text, exactly as `documentFromStored` does.
    public init(stored: String) {
        self = JournalContent.decodeDelta(stored).map(JournalContent.delta) ?? .plain(stored)
    }

    static func decodeDelta(_ content: String) -> [DeltaOp]? {
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let json = try? JSONValue.parse(content),
              case let .array(items) = json,
              !items.isEmpty else { return nil }
        var ops: [DeltaOp] = []
        ops.reserveCapacity(items.count)
        for item in items {
            guard case let .object(pairs) = item else { return nil }
            // Only insert ops are valid in a stored document.
            guard pairs.allSatisfy({ ["insert", "attributes"].contains($0.0) }) else { return nil }
            let insert: DeltaOp.Insert
            switch item["insert"] {
            case let .string(s)?: insert = .text(s)
            case let .object(o)?: insert = .embed(.object(o))
            default: return nil
            }
            var attributes: JSONValue?
            if let attrs = item["attributes"] {
                switch attrs {
                case .object: attributes = attrs
                case .null: attributes = nil
                default: return nil
                }
            }
            ops.append(DeltaOp(insert: insert, attributes: attributes))
        }
        return ops
    }

    /// Merges adjacent text inserts with equal attributes, as Quill's
    /// `Delta.push` does. Empty attribute objects count as no attributes.
    static func compacted(_ ops: [DeltaOp]) -> [DeltaOp] {
        func normalized(_ attributes: JSONValue?) -> JSONValue? {
            if case let .object(pairs)? = attributes, pairs.isEmpty { return nil }
            return attributes
        }
        var result: [DeltaOp] = []
        for op in ops {
            var op = op
            op.attributes = normalized(op.attributes)
            if case let .text(text) = op.insert, text.isEmpty { continue }
            if let last = result.last,
               case let .text(previous) = last.insert,
               case let .text(current) = op.insert,
               last.attributes == op.attributes {
                result[result.count - 1].insert = .text(previous + current)
            } else {
                result.append(op)
            }
        }
        return result
    }

    /// Serialises back to the stored string. Plain content is upgraded to a
    /// Delta on save, as the Flutter editor does.
    public var stored: String {
        JSONValue.array(normalizedOps.map(\.json)).encoded()
    }

    /// Ops guaranteed to end with a newline, as Quill requires.
    public var normalizedOps: [DeltaOp] {
        var ops: [DeltaOp]
        switch self {
        case let .delta(existing): ops = existing
        case let .plain(text): ops = text.isEmpty ? [] : [DeltaOp(text: text)]
        }
        if case let .text(last)? = ops.last?.insert {
            if last.hasSuffix("\n") { return ops }
            // Quill merges the closing newline into an unstyled last op.
            if ops[ops.count - 1].attributes == nil {
                ops[ops.count - 1].insert = .text(last + "\n")
                return ops
            }
        }
        ops.append(DeltaOp(text: "\n"))
        return ops
    }

    /// Trimmed plain text, for search, previews and empty checks.
    /// Mirrors `plainTextFromStored`.
    public var plainText: String {
        switch self {
        case let .plain(text):
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        case let .delta(ops):
            var out = ""
            for op in ops {
                switch op.insert {
                case let .text(s): out += s
                case .embed: out += "\u{FFFC}"
                }
            }
            return out.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    /// Styled runs with bullet lines prefixed, for read-only rendering.
    /// Mirrors `richRunsFromStored`.
    public var richRuns: [RichRun] {
        let ops: [DeltaOp]
        switch self {
        case let .plain(text):
            let plain = text.trimmingCharacters(in: .whitespacesAndNewlines)
            return plain.isEmpty ? [] : [RichRun(plain)]
        case let .delta(existing):
            // Flutter builds runs from `Document.toDelta()`, which has merged
            // neighbouring ops. That merge decides whether a newline op is a
            // lone "\n" (bullet line) or part of a longer insert, so it must
            // happen here too.
            ops = JournalContent.compacted(existing)
        }

        var lines: [(runs: [RichRun], bullet: Bool)] = []
        var current: [RichRun] = []
        func endLine(_ bullet: Bool) {
            lines.append((current, bullet))
            current = []
        }

        for op in ops {
            guard case let .text(insert) = op.insert else { continue }
            if insert == "\n" {
                endLine(op.attribute("list") == .string("bullet"))
                continue
            }
            let bold = op.attribute("bold") == .bool(true)
            let italic = op.attribute("italic") == .bool(true)
            let parts = insert.components(separatedBy: "\n")
            for (i, part) in parts.enumerated() {
                if !part.isEmpty { current.append(RichRun(part, bold: bold, italic: italic)) }
                if i < parts.count - 1 { endLine(false) }
            }
        }
        if !current.isEmpty { endLine(false) }

        // Drop the empty trailing line produced by the document's final newline.
        while let last = lines.last, last.runs.isEmpty, !last.bullet { lines.removeLast() }

        var runs: [RichRun] = []
        for (index, line) in lines.enumerated() {
            if line.bullet { runs.append(RichRun("\u{2022}  ")) }
            runs.append(contentsOf: line.runs)
            if index < lines.count - 1 { runs.append(RichRun("\n")) }
        }
        return runs
    }
}
