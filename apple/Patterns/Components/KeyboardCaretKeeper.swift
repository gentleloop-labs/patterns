import UIKit

/// Keeps the line being typed above the keyboard, everywhere in the app.
///
/// SwiftUI forms only partly scroll a focused field into view: a field near
/// the bottom of a sheet, or a multi-line field that grows as you type, can
/// end up behind the keyboard. This watches every text field and text view,
/// and when the caret sits under the keyboard it scrolls the nearest
/// scrollable container just enough to bring it back into sight.
@MainActor
final class KeyboardCaretKeeper {
    static let shared = KeyboardCaretKeeper()

    /// Space kept between the caret's line and the top of the keyboard.
    private let margin: CGFloat = 16
    private weak var input: UIView?
    private var keyboardFrame: CGRect?
    /// Insets added to containers too short to scroll far enough.
    private var addedInsets: [(view: UIScrollView, amount: CGFloat)] = []
    private var installed = false

    func install() {
        guard !installed else { return }
        installed = true
        let center = NotificationCenter.default
        for name in [UITextField.textDidBeginEditingNotification, UITextView.textDidBeginEditingNotification] {
            center.addObserver(forName: name, object: nil, queue: .main) { note in
                let view = note.object as? UIView
                MainActor.assumeIsolated { self.input = view; self.revealSoon() }
            }
        }
        for name in [UITextField.textDidChangeNotification, UITextView.textDidChangeNotification] {
            center.addObserver(forName: name, object: nil, queue: .main) { note in
                let view = note.object as? UIView
                MainActor.assumeIsolated {
                    if view === self.input { self.revealSoon(delay: 0.02) }
                }
            }
        }
        center.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { note in
            let frame = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            MainActor.assumeIsolated { self.keyboardFrame = frame }
        }
        for name in [UIResponder.keyboardDidShowNotification, UIResponder.keyboardDidChangeFrameNotification] {
            center.addObserver(forName: name, object: nil, queue: .main) { _ in
                MainActor.assumeIsolated { self.revealSoon(delay: 0.02) }
            }
        }
        center.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            MainActor.assumeIsolated {
                self.keyboardFrame = nil
                self.removeAddedInsets()
            }
        }
    }

    /// Waits for SwiftUI's own keyboard avoidance and layout to settle.
    private func revealSoon(delay: TimeInterval = 0.12) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            MainActor.assumeIsolated { self?.reveal() }
        }
    }

    private func reveal() {
        guard let input, input.isFirstResponder, let window = input.window,
              let screenFrame = keyboardFrame else { return }
        let keyboard = window.convert(screenFrame, from: window.screen.coordinateSpace)
        guard keyboard.minY < window.bounds.maxY - 1 else { return }

        // The caret's line, and the rest of the field when it is close by,
        // so a short field shows in full.
        let caret = caretRect(in: input).map { input.convert($0, to: nil) }
            ?? input.convert(input.bounds, to: nil)
        let fieldBottom = input.convert(input.bounds, to: nil).maxY
        let wanted = max(caret.maxY, min(fieldBottom, caret.maxY + 120)) + margin

        var view: UIView? = input
        while let current = view {
            view = current.superview
            guard let scroll = current as? UIScrollView, scroll.isScrollEnabled else { continue }
            let frame = scroll.convert(scroll.bounds, to: nil)
            let visibleBottom = min(keyboard.minY, frame.maxY)
            let overlap = wanted - visibleBottom
            guard overlap > 0.5 else { return }
            // Never push the caret's own line above the container's top.
            let room = caret.minY - (frame.minY + scroll.adjustedContentInset.top)
            let distance = min(overlap, max(room, 0))
            guard distance > 0.5 else { continue }
            let maxOffset = scroll.contentSize.height + scroll.adjustedContentInset.bottom - scroll.bounds.height
            let shortfall = distance - (maxOffset - scroll.contentOffset.y)
            if shortfall > 0 {
                scroll.contentInset.bottom += shortfall
                addedInsets.append((scroll, shortfall))
            }
            scroll.setContentOffset(CGPoint(x: scroll.contentOffset.x, y: scroll.contentOffset.y + distance),
                                    animated: true)
            return
        }
    }

    private func caretRect(in view: UIView) -> CGRect? {
        guard let text = view as? UITextInput, let range = text.selectedTextRange else { return nil }
        let rect = text.caretRect(for: range.end)
        return rect.isNull || rect.isInfinite ? nil : rect
    }

    private func removeAddedInsets() {
        for (view, amount) in addedInsets {
            view.contentInset.bottom = max(view.contentInset.bottom - amount, 0)
        }
        addedInsets.removeAll()
    }
}
