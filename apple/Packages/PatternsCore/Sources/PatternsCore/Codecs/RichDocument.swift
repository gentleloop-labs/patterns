import Foundation

/// A journal body as lines of styled segments: the shape an editor works
/// with, converted losslessly to and from Quill Delta ops.
///
/// Attributes stay as stored JSON. The editor only understands bold, italic
/// and bulleted lists, but anything else Quill wrote (links, headers,
/// colours, embeds) rides along on its segment or line and is written back
/// unchanged on save.
public struct RichDocument: Equatable, Sendable {
    public enum Content: Equatable, Sendable {
        case text(String)
        /// A non-text embed, kept verbatim.
        case embed(JSONValue)
    }

    public struct Segment: Equatable, Sendable {
        public var content: Content
        /// The op's attributes (inline styles). Nil when unstyled.
        public var attributes: JSONValue?

        public init(_ content: Content, attributes: JSONValue? = nil) {
            self.content = content
            self.attributes = attributes
        }

        public init(text: String, attributes: JSONValue? = nil) {
            self.init(.text(text), attributes: attributes)
        }
    }

    public struct Line: Equatable, Sendable {
        public var segments: [Segment]
        /// Attributes of the line's closing newline (block styles, such as
        /// `{"list":"bullet"}`). Nil when unstyled.
        public var attributes: JSONValue?

        public init(segments: [Segment] = [], attributes: JSONValue? = nil) {
            self.segments = segments
            self.attributes = attributes
        }

        public var isBullet: Bool { attributes?["list"] == .string("bullet") }
    }

    /// Never empty: a Quill document always has at least one line.
    public var lines: [Line]

    public init(lines: [Line]) {
        self.lines = lines.isEmpty ? [Line()] : lines
    }

    public init(_ content: JournalContent) {
        var lines: [Line] = []
        var current: [Segment] = []
        for op in JournalContent.compacted(content.normalizedOps) {
            switch op.insert {
            case let .embed(value):
                current.append(Segment(.embed(value), attributes: op.attributes))
            case let .text(text):
                let parts = text.components(separatedBy: "\n")
                for (index, part) in parts.enumerated() {
                    if !part.isEmpty { current.append(Segment(text: part, attributes: op.attributes)) }
                    if index < parts.count - 1 {
                        lines.append(Line(segments: current, attributes: op.attributes))
                        current = []
                    }
                }
            }
        }
        // `normalizedOps` always ends with a newline, so nothing is left over.
        if !current.isEmpty { lines.append(Line(segments: current)) }
        self.init(lines: lines)
    }

    public init(stored: String) {
        self.init(JournalContent(stored: stored))
    }

    /// The Delta ops in Quill's canonical (compacted) form.
    public var ops: [DeltaOp] {
        var ops: [DeltaOp] = []
        for line in lines {
            for segment in line.segments {
                switch segment.content {
                case let .text(text): ops.append(DeltaOp(insert: .text(text), attributes: segment.attributes))
                case let .embed(value): ops.append(DeltaOp(insert: .embed(value), attributes: segment.attributes))
                }
            }
            ops.append(DeltaOp(insert: .text("\n"), attributes: line.attributes))
        }
        return JournalContent.compacted(ops)
    }

    public var content: JournalContent { .delta(ops) }

    /// The string saved to `journal.content`.
    public var stored: String { content.stored }

    /// Trimmed plain text, the same rule Flutter uses for "nothing to save".
    public var plainText: String { content.plainText }
}

extension JSONValue {
    /// The object's pairs with `key` set to `value` (appended when new, kept
    /// in place when present) or removed when `value` is nil. Returns nil for
    /// an object left empty.
    public func settingAttribute(_ key: String, to value: JSONValue?) -> JSONValue? {
        var pairs: [(String, JSONValue)] = []
        if case let .object(existing) = self { pairs = existing }
        if let index = pairs.firstIndex(where: { $0.0 == key }) {
            if let value { pairs[index].1 = value } else { pairs.remove(at: index) }
        } else if let value {
            pairs.append((key, value))
        }
        return pairs.isEmpty ? nil : .object(pairs)
    }
}

extension Optional where Wrapped == JSONValue {
    public func settingAttribute(_ key: String, to value: JSONValue?) -> JSONValue? {
        (self ?? .object([])).settingAttribute(key, to: value)
    }
}
