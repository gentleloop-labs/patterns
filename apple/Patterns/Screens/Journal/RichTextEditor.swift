import Observation
import PatternsCore
import SwiftUI
import UIKit

/// The journal editor: a `UITextView` that edits a ``RichDocument``.
///
/// Every character carries the stored Quill attributes as JSON, so formats
/// the native editor has no buttons for (links, headers, colours, embeds)
/// are written back exactly as they were. The visible styling (Manrope 19,
/// bold, synthesized italic like Flutter, bullet lists) is derived from that
/// JSON.
///
/// - `patterns.inline`: the run's inline attributes, including bold/italic.
/// - `patterns.block`: the attributes of the paragraph's closing newline,
///   set on every character of the paragraph so typing and splitting a line
///   keep its list style, as Quill does.
/// - `patterns.embed`: an embed's JSON, on its U+FFFC placeholder.
@MainActor
@Observable
final class RichEditorController {
    private(set) var isBold = false
    private(set) var isItalic = false
    private(set) var isBullet = false
    /// The stored form of the current text. Updated on every edit.
    private(set) var stored = ""
    private(set) var isEmpty = true

    @ObservationIgnored weak var textView: UITextView?
    /// Block attributes of the final line, whose closing newline is kept out
    /// of the text view (Quill hides it too).
    @ObservationIgnored private var trailingBlock: JSONValue?
    @ObservationIgnored private var pendingDocument: RichDocument?
    @ObservationIgnored var onChange: (() -> Void)?

    static let inlineKey = NSAttributedString.Key("patterns.inline")
    static let blockKey = NSAttributedString.Key("patterns.block")
    static let embedKey = NSAttributedString.Key("patterns.embed")

    // MARK: Loading and reading

    func load(_ document: RichDocument) {
        guard let textView else {
            pendingDocument = document
            stored = document.stored
            isEmpty = document.plainText.isEmpty
            return
        }
        let (text, trailing) = Self.attributedString(for: document, style: style(for: textView))
        trailingBlock = trailing
        textView.attributedText = text
        textView.selectedRange = NSRange(location: text.length, length: 0)
        resetTypingAttributes()
        refresh()
    }

    func attach(_ textView: UITextView) {
        self.textView = textView
        if let pendingDocument {
            self.pendingDocument = nil
            load(pendingDocument)
        }
    }

    var document: RichDocument {
        guard let textView else { return pendingDocument ?? RichDocument(stored: stored) }
        return Self.document(from: textView.attributedText, trailingBlock: trailingBlock)
    }

    // MARK: Formatting (JournalFormatToolbar)

    func toggleBold() { toggleInline("bold", active: isBold) }
    func toggleItalic() { toggleInline("italic", active: isItalic) }

    private func toggleInline(_ key: String, active: Bool) {
        guard let textView else { return }
        let value: JSONValue? = active ? nil : .bool(true)
        let range = textView.selectedRange
        if range.length == 0 {
            var typing = textView.typingAttributes
            let inline = Self.json(typing[Self.inlineKey]).settingAttribute(key, to: value)
            typing[Self.inlineKey] = inline?.encoded()
            Self.applyInlineVisuals(to: &typing, inline: inline, style: style(for: textView))
            textView.typingAttributes = typing
        } else {
            let storage = textView.textStorage
            storage.beginEditing()
            storage.enumerateAttribute(Self.inlineKey, in: range) { current, runRange, _ in
                // Newlines carry only block attributes in Quill.
                let text = (storage.string as NSString).substring(with: runRange)
                var location = runRange.location
                for piece in text.components(separatedBy: "\n") {
                    let pieceRange = NSRange(location: location, length: (piece as NSString).length)
                    location += pieceRange.length + 1
                    guard pieceRange.length > 0 else { continue }
                    let inline = Self.json(current).settingAttribute(key, to: value)
                    var attrs: [NSAttributedString.Key: Any] = [:]
                    Self.applyInlineVisuals(to: &attrs, inline: inline, style: style(for: textView))
                    storage.addAttributes(attrs, range: pieceRange)
                    if let inline { storage.addAttribute(Self.inlineKey, value: inline.encoded(), range: pieceRange) }
                    else { storage.removeAttribute(Self.inlineKey, range: pieceRange) }
                }
            }
            storage.endEditing()
        }
        textChanged()
    }

    func toggleBullet() {
        guard let textView else { return }
        let ranges = paragraphRanges(intersecting: textView.selectedRange, in: textView.textStorage.string as NSString)
        let allBullets = ranges.allSatisfy { blockAttributes(forParagraph: $0).isBulletList }
        let value: JSONValue? = allBullets ? nil : .string("bullet")
        for range in ranges {
            setBlock(blockAttributes(forParagraph: range).settingAttribute("list", to: value), paragraph: range)
        }
        resetTypingAttributes()
        textChanged()
    }

    // MARK: Editing hooks (called by the coordinator)

    /// A keystroke, paste or dictation from the text view.
    func userEdited() {
        guard let textView else { return }
        if textView.markedTextRange == nil, textView.selectedRange.length == 0 {
            normalizeParagraphs()
            resetTypingAttributes()
        }
        textChanged()
    }

    func textChanged() {
        normalizeParagraphs()
        refresh()
        #if DEBUG
        if ProcessInfo.processInfo.environment["PATTERNS_EDITOR_LOG"] != nil { print("EDITOR", stored) }
        #endif
        onChange?()
    }

    func selectionChanged() {
        refreshFormatState()
    }

    /// Quill's behaviour: Return on an empty bullet line ends the list.
    func shouldInsertNewline(at range: NSRange) -> Bool {
        guard let textView, range.length == 0 else { return true }
        let string = textView.textStorage.string as NSString
        let paragraph = self.paragraph(at: range.location, in: string)
        let content = paragraphContentRange(paragraph, in: string)
        guard content.length == 0, blockAttributes(forParagraph: paragraph).isBulletList else { return true }
        setBlock(blockAttributes(forParagraph: paragraph).settingAttribute("list", to: nil), paragraph: paragraph)
        resetTypingAttributes()
        textChanged()
        return false
    }

    // MARK: Internals

    private func refresh() {
        let document = document
        stored = document.stored
        isEmpty = (textView?.textStorage.length ?? 0) == 0
        refreshFormatState()
    }

    private func refreshFormatState() {
        guard let textView else { return }
        let range = textView.selectedRange
        if range.length == 0 {
            let inline = Self.json(textView.typingAttributes[Self.inlineKey])
            isBold = inline?["bold"] == .bool(true)
            isItalic = inline?["italic"] == .bool(true)
        } else {
            // Active only when every selected character has the style.
            var sawText = false, bold = true, italic = true
            let string = textView.textStorage.string as NSString
            textView.textStorage.enumerateAttribute(Self.inlineKey, in: range) { value, runRange, _ in
                if string.substring(with: runRange).allSatisfy({ $0 == "\n" }) { return }
                sawText = true
                let attrs = Self.json(value)
                if attrs?["bold"] != .bool(true) { bold = false }
                if attrs?["italic"] != .bool(true) { italic = false }
            }
            isBold = sawText && bold
            isItalic = sawText && italic
        }
        isBullet = currentBullet(textView)
    }

    private func currentBullet(_ textView: UITextView) -> Bool {
        let string = textView.textStorage.string as NSString
        let ranges = paragraphRanges(intersecting: textView.selectedRange, in: string)
        return !ranges.isEmpty && ranges.allSatisfy { blockAttributes(forParagraph: $0).isBulletList }
    }

    /// Typing attributes for the cursor position, keeping the paragraph's
    /// block style so new text joins the current line's format.
    private func resetTypingAttributes() {
        guard let textView else { return }
        let storage = textView.textStorage
        let location = textView.selectedRange.location
        var attrs: [NSAttributedString.Key: Any]
        var inline: JSONValue?
        if location > 0, storage.length > 0 {
            let previous = location - 1
            let char = (storage.string as NSString).character(at: previous)
            attrs = [:]
            if char != 0x0A { inline = Self.json(storage.attribute(Self.inlineKey, at: previous, effectiveRange: nil)) }
        } else {
            attrs = [:]
            if storage.length > 0 { inline = Self.json(storage.attribute(Self.inlineKey, at: 0, effectiveRange: nil)) }
        }
        let style = style(for: textView)
        Self.applyInlineVisuals(to: &attrs, inline: inline, style: style)
        if let inline { attrs[Self.inlineKey] = inline.encoded() }
        let block = blockAttributes(forParagraph: paragraph(at: location, in: storage.string as NSString))
        attrs[.paragraphStyle] = style.paragraph(bullet: block.isBulletList)
        if let block { attrs[Self.blockKey] = block.encoded() }
        textView.typingAttributes = attrs
    }

    /// The paragraph holding `location`. After a final newline that is the
    /// empty last line, which `NSString.paragraphRange` does not return.
    private func paragraph(at location: Int, in string: NSString) -> NSRange {
        if location >= string.length, string.length == 0 || string.hasSuffix("\n") {
            return NSRange(location: string.length, length: 0)
        }
        return string.paragraphRange(for: NSRange(location: min(location, string.length), length: 0))
    }

    private func paragraphRanges(intersecting range: NSRange, in string: NSString) -> [NSRange] {
        var ranges: [NSRange] = []
        var location = range.location
        repeat {
            let current = paragraph(at: location, in: string)
            ranges.append(current)
            if current.length == 0 { break }
            location = NSMaxRange(current)
        } while location < NSMaxRange(range)
        return ranges
    }

    private func paragraphContentRange(_ paragraph: NSRange, in string: NSString) -> NSRange {
        var length = paragraph.length
        if length > 0, string.character(at: NSMaxRange(paragraph) - 1) == 0x0A { length -= 1 }
        return NSRange(location: paragraph.location, length: length)
    }

    /// The paragraph's closing-newline attributes: read from its newline, or
    /// for the last line (no newline in the view) from ``trailingBlock``.
    private func blockAttributes(forParagraph paragraph: NSRange) -> JSONValue? {
        guard let textView else { return nil }
        let storage = textView.textStorage
        let string = storage.string as NSString
        if paragraph.length > 0, string.character(at: NSMaxRange(paragraph) - 1) == 0x0A {
            return Self.json(storage.attribute(Self.blockKey, at: NSMaxRange(paragraph) - 1, effectiveRange: nil))
        }
        if NSMaxRange(paragraph) == string.length { return trailingBlock }
        return nil
    }

    private func setBlock(_ block: JSONValue?, paragraph: NSRange) {
        guard let textView else { return }
        let storage = textView.textStorage
        let isLast = NSMaxRange(paragraph) == storage.length
            && !(paragraph.length > 0 && (storage.string as NSString).character(at: NSMaxRange(paragraph) - 1) == 0x0A)
        if isLast { trailingBlock = block }
        guard paragraph.length > 0 else { return }
        storage.beginEditing()
        if let block { storage.addAttribute(Self.blockKey, value: block.encoded(), range: paragraph) }
        else { storage.removeAttribute(Self.blockKey, range: paragraph) }
        storage.addAttribute(.paragraphStyle, value: style(for: textView).paragraph(bullet: block.isBulletList), range: paragraph)
        storage.endEditing()
    }

    /// Makes every paragraph's characters agree with its closing newline,
    /// after edits that split or join lines. Skipped while the keyboard is
    /// composing (Japanese input), which attribute changes would disturb.
    private func normalizeParagraphs() {
        guard let textView, textView.markedTextRange == nil else { return }
        let storage = textView.textStorage
        let string = storage.string as NSString
        guard string.length > 0 else { return }
        let style = style(for: textView)
        var location = 0
        storage.beginEditing()
        while location < string.length {
            let paragraph = string.paragraphRange(for: NSRange(location: location, length: 0))
            let block = blockAttributes(forParagraph: paragraph)
            let encoded = block?.encoded()
            var consistent = true
            storage.enumerateAttribute(Self.blockKey, in: paragraph) { value, _, stop in
                if (value as? String) != encoded { consistent = false; stop.pointee = true }
            }
            if !consistent {
                if let encoded { storage.addAttribute(Self.blockKey, value: encoded, range: paragraph) }
                else { storage.removeAttribute(Self.blockKey, range: paragraph) }
                storage.addAttribute(.paragraphStyle, value: style.paragraph(bullet: block.isBulletList), range: paragraph)
            }
            location = NSMaxRange(paragraph)
        }
        storage.endEditing()
    }

    // MARK: Conversion

    struct Style {
        let regular: UIFont
        let bold: UIFont
        let lineHeight: CGFloat
        let color: UIColor

        func paragraph(bullet: Bool) -> NSParagraphStyle {
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = lineHeight
            style.maximumLineHeight = lineHeight
            // The bullet itself is drawn by `BulletLayoutFragment`. UIKit's
            // own `NSTextList` editing rewrites Return presses and would
            // drop the line's stored attributes.
            if bullet {
                style.headIndent = Self.bulletIndent
                style.firstLineHeadIndent = Self.bulletIndent
            }
            return style
        }

        var baselineOffset: CGFloat { (lineHeight - regular.lineHeight) / 4 }
        static let bulletIndent: CGFloat = 26
    }

    private func style(for textView: UITextView) -> Style {
        Self.style(traits: textView.traitCollection)
    }

    static func style(traits: UITraitCollection) -> Style {
        // The system body font, a little larger for writing, with roomy lines.
        let metrics = UIFontMetrics(forTextStyle: .body)
        let size = metrics.scaledValue(for: 18, compatibleWith: traits)
        let regular = UIFont.systemFont(ofSize: size)
        let bold = UIFont.systemFont(ofSize: size, weight: .bold)
        return Style(regular: regular, bold: bold, lineHeight: (size * 1.5).rounded(), color: UIColor(AppColors.textPrimary))
    }

    static func applyInlineVisuals(to attrs: inout [NSAttributedString.Key: Any], inline: JSONValue?, style: Style) {
        attrs[.font] = inline?["bold"] == .bool(true) ? style.bold : style.regular
        // Italic is drawn as a slant so bold and italic combine freely.
        attrs[.obliqueness] = inline?["italic"] == .bool(true) ? 0.2 : 0
        attrs[.foregroundColor] = style.color
        attrs[.baselineOffset] = style.baselineOffset
    }

    static func json(_ value: Any?) -> JSONValue? {
        guard let string = value as? String else { return nil }
        return try? JSONValue.parse(string)
    }

    static func attributedString(for document: RichDocument, style: Style) -> (NSAttributedString, JSONValue?) {
        let result = NSMutableAttributedString()
        for (index, line) in document.lines.enumerated() {
            let start = result.length
            for segment in line.segments {
                var attrs: [NSAttributedString.Key: Any] = [:]
                applyInlineVisuals(to: &attrs, inline: segment.attributes, style: style)
                if let inline = segment.attributes { attrs[inlineKey] = inline.encoded() }
                switch segment.content {
                case let .text(text):
                    result.append(NSAttributedString(string: text, attributes: attrs))
                case let .embed(value):
                    attrs[embedKey] = value.encoded()
                    result.append(NSAttributedString(string: "\u{FFFC}", attributes: attrs))
                }
            }
            let isLast = index == document.lines.count - 1
            if !isLast {
                var attrs: [NSAttributedString.Key: Any] = [:]
                applyInlineVisuals(to: &attrs, inline: nil, style: style)
                result.append(NSAttributedString(string: "\n", attributes: attrs))
            }
            let range = NSRange(location: start, length: result.length - start)
            if range.length > 0 {
                if let block = line.attributes { result.addAttribute(blockKey, value: block.encoded(), range: range) }
                result.addAttribute(.paragraphStyle, value: style.paragraph(bullet: line.isBullet), range: range)
            }
        }
        return (result, document.lines.last?.attributes)
    }

    static func document(from text: NSAttributedString, trailingBlock: JSONValue?) -> RichDocument {
        let string = text.string as NSString
        var lines: [RichDocument.Line] = []
        var segments: [RichDocument.Segment] = []
        text.enumerateAttributes(in: NSRange(location: 0, length: string.length)) { attrs, range, _ in
            let inline = json(attrs[inlineKey])
            let embed = json(attrs[embedKey])
            let block = json(attrs[blockKey])
            var piece = ""
            func flush() {
                if !piece.isEmpty { segments.append(RichDocument.Segment(text: piece, attributes: inline)) }
                piece = ""
            }
            for unit in string.substring(with: range) {
                if unit == "\n" {
                    flush()
                    lines.append(RichDocument.Line(segments: segments, attributes: block))
                    segments = []
                } else if unit == "\u{FFFC}", let embed {
                    flush()
                    segments.append(RichDocument.Segment(.embed(embed), attributes: inline))
                } else {
                    piece.append(unit)
                }
            }
            flush()
        }
        lines.append(RichDocument.Line(segments: segments, attributes: trailingBlock))
        return RichDocument(lines: lines)
    }
}

private extension Optional where Wrapped == JSONValue {
    var isBulletList: Bool { self?["list"] == .string("bullet") }
}

/// SwiftUI wrapper around the text view.
struct RichTextEditor: UIViewRepresentable {
    let controller: RichEditorController
    let placeholder: String
    var autoFocus = true

    func makeUIView(context: Context) -> UITextView {
        let view = PlainPasteTextView(usingTextLayoutManager: true)
        view.backgroundColor = .clear
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        view.alwaysBounceVertical = true
        view.keyboardDismissMode = .interactive
        view.delegate = context.coordinator
        view.textLayoutManager?.delegate = context.coordinator
        view.adjustsFontForContentSizeCategory = false
        view.accessibilityHint = nil
        view.tintColor = UIColor(AppColors.accent)
        let style = RichEditorController.style(traits: view.traitCollection)
        var typing: [NSAttributedString.Key: Any] = [.paragraphStyle: style.paragraph(bullet: false)]
        RichEditorController.applyInlineVisuals(to: &typing, inline: nil, style: style)
        view.typingAttributes = typing

        let label = UILabel()
        label.text = placeholder
        label.font = style.regular
        label.textColor = UIColor(AppColors.textSecondary).withAlphaComponent(0.5)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: style.baselineOffset + (style.lineHeight - style.regular.lineHeight) / 2),
            label.leadingAnchor.constraint(equalTo: view.frameLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.frameLayoutGuide.trailingAnchor),
        ])
        context.coordinator.placeholder = label

        controller.attach(view)
        label.isHidden = !controller.isEmpty
        if autoFocus {
            DispatchQueue.main.async { view.becomeFirstResponder() }
        }
        return view
    }

    func updateUIView(_ view: UITextView, context: Context) {
        context.coordinator.placeholder?.text = placeholder
        context.coordinator.placeholder?.isHidden = !controller.isEmpty
    }

    func makeCoordinator() -> Coordinator { Coordinator(controller: controller) }

    final class Coordinator: NSObject, UITextViewDelegate, @preconcurrency NSTextLayoutManagerDelegate {
        let controller: RichEditorController
        weak var placeholder: UILabel?

        init(controller: RichEditorController) {
            self.controller = controller
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" { return controller.shouldInsertNewline(at: range) }
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            controller.userEdited()
            placeholder?.isHidden = textView.textStorage.length > 0
        }

        func textViewDidChangeSelection(_ textView: UITextView) {
            controller.selectionChanged()
        }

        func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, textLayoutFragmentFor location: NSTextLocation,
                               in textElement: NSTextElement) -> NSTextLayoutFragment {
            guard let paragraph = textElement as? NSTextParagraph,
                  paragraph.attributedString.length > 0,
                  RichEditorController.json(paragraph.attributedString.attribute(RichEditorController.blockKey, at: 0, effectiveRange: nil))?["list"] == .string("bullet")
            else { return NSTextLayoutFragment(textElement: textElement, range: textElement.elementRange) }
            let fragment = BulletLayoutFragment(textElement: textElement, range: textElement.elementRange)
            if let font = paragraph.attributedString.attribute(.font, at: 0, effectiveRange: nil) as? UIFont {
                fragment.font = .systemFont(ofSize: font.pointSize)
            }
            fragment.color = UIColor(AppColors.textPrimary)
            fragment.baselineOffset = paragraph.attributedString.attribute(.baselineOffset, at: 0, effectiveRange: nil) as? CGFloat ?? 0
            return fragment
        }
    }
}

/// Pastes plain text only, so styling copied from other apps never enters an
/// entry (Quill's editor does the same). Pasted text takes the current
/// typing style.
final class PlainPasteTextView: UITextView {
    override func paste(_ sender: Any?) {
        guard let text = UIPasteboard.general.string else { return super.paste(sender) }
        insertText(text)
    }
}

/// Draws the "•" for a bulleted line in the indent before its first line.
final class BulletLayoutFragment: NSTextLayoutFragment {
    var font: UIFont = .systemFont(ofSize: 19)
    var color: UIColor = .label
    var baselineOffset: CGFloat = 0

    /// The fragment starts at the paragraph indent, so the bullet sits to
    /// its left, 6pt in from the text container edge.
    private var bulletX: CGFloat { 6 - layoutFragmentFrame.minX }

    override var renderingSurfaceBounds: CGRect {
        super.renderingSurfaceBounds.union(CGRect(x: bulletX, y: 0, width: -bulletX, height: layoutFragmentFrame.height))
    }

    override func draw(at point: CGPoint, in context: CGContext) {
        super.draw(at: point, in: context)
        guard let line = textLineFragments.first else { return }
        let bullet = NSAttributedString(string: "\u{2022}", attributes: [.font: font, .foregroundColor: color])
        let baseline = point.y + line.typographicBounds.minY + line.glyphOrigin.y - baselineOffset
        UIGraphicsPushContext(context)
        bullet.draw(at: CGPoint(x: point.x + bulletX, y: baseline - font.ascender))
        UIGraphicsPopContext()
    }
}
