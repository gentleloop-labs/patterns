import XCTest

/// Every text field must stay above the keyboard while someone types in it.
///
/// Each form is opened, every field in it is typed into, and the field's
/// frame is compared with the keyboard's. Forms are cancelled, never saved.
@MainActor
final class KeyboardVisibilityTests: XCTestCase {
    private var app = XCUIApplication()
    private var problems: [String] = []

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    func testFieldsStayAboveKeyboard() throws {
        form("ERP plan", tab: "erp") { openTool("Guided ERP") && tap("New") }
        form("OCD event", tab: "track") { tap("Track OCD event") && tap("Compulsion") }
        form("Compulsion delay", tab: "erp") { openTool("Compulsion Delay") }
        form("Urge surf", tab: "erp") { openTool("Urge Surfing") && tap("Start a surf") }
        form("Uncertainty", tab: "erp") { openTool("Uncertainty Training") && tapPrefix("Maybe, maybe not") }
        form("Hierarchy", tab: "erp") { openTool("Exposure Hierarchy") && tap("New") }
        form("Material", tab: "erp") { openTool("Exposure Materials") && tap("New") && tap("Script") }
        form("Action plan", tab: "erp") { openTool("Action Planner") && tap("New") }
        form("If-then plan", tab: "erp") { openTool("Implementation Intentions") && tap("New") }
        form("Experiment", tab: "erp") { openTool("Behavioral Experiments") && tap("New") }
        form("Response prevention", tab: "erp") { openTool("Response Prevention") && tap("Log") }
        form("Reflection", tab: "erp") { openTool("Reflection Journal") && tap("New") }
        XCTAssertTrue(problems.isEmpty, problems.joined(separator: "\n"))
    }

    // MARK: Checking

    private func form(_ name: String, tab: String, open: () -> Bool) {
        launch(tab)
        guard open() else { return problems.append("\(name): could not open") }
        pause(1)
        var checked = Set<String>()
        // Lower fields only exist once scrolled to, so walk down the form.
        for _ in 0..<4 {
            let fields = app.descendants(matching: .any).matching(NSPredicate(
                format: "elementType == %d OR elementType == %d",
                XCUIElement.ElementType.textField.rawValue, XCUIElement.ElementType.textView.rawValue))
            var index = 0
            // The form can change as fields fill, so recount each time.
            while index < fields.count {
                let field = fields.element(boundBy: index)
                index += 1
                guard field.exists else { continue }
                let key = field.placeholderValue ?? field.label
                // Fields scrolled up under the navigation bar come back on a later pass.
                guard field.isHittable, !checked.contains(key), field.frame.minY > 100 else { continue }
                checked.insert(key)
                field.tap()
                pause(0.5)
                guard field.value(forKey: "hasKeyboardFocus") as? Bool == true else { continue }
                field.typeText("Keyboard check, a line long enough to wrap onto a second line")
                pause(1)
                let keyboard = app.keyboards.firstMatch
                // Typing can reshape the form, so measure whatever holds focus.
                let focused = app.descendants(matching: .any)
                    .matching(NSPredicate(format: "hasKeyboardFocus == true")).firstMatch
                guard keyboard.exists, focused.exists else { continue }
                let frame = focused.frame
                print("KEYS|\(name)|\(key.prefix(30))|field \(Int(frame.minY))-\(Int(frame.maxY))|keyboard \(Int(keyboard.frame.minY))")
                if frame.maxY > keyboard.frame.minY + 1 {
                    problems.append("\(name): '\(key.prefix(40))' ends at \(Int(frame.maxY)), keyboard starts at \(Int(keyboard.frame.minY))")
                }
            }
            app.swipeUp(velocity: .slow)
            pause(0.5)
        }
        if checked.isEmpty { problems.append("\(name): no fields found") }
    }

    // MARK: Helpers

    private func launch(_ tab: String) {
        app.terminate()
        app = XCUIApplication()
        app.launchArguments = [
            "-flutter.mobileSelectedTab", tab, "-flutter.appLockEnabled", "<false/>",
            "-flutter.proUnlocked", "<true/>", "-AppleLanguages", "(en)", "-AppleLocale", "en_US",
        ]
        app.launch()
        _ = app.tabBars.firstMatch.waitForExistence(timeout: 8)
    }

    private func pause(_ seconds: Double) {
        RunLoop.current.run(until: Date().addingTimeInterval(seconds))
    }

    private func openTool(_ title: String) -> Bool { tapPrefix(title) }

    private func tap(_ label: String) -> Bool {
        let button = app.buttons[label].firstMatch
        return tapScrolling(button.waitForExistence(timeout: 3) ? button : app.staticTexts[label].firstMatch)
    }

    private func tapPrefix(_ prefix: String) -> Bool {
        tapScrolling(app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch)
    }

    private func tapScrolling(_ element: XCUIElement) -> Bool {
        _ = element.waitForExistence(timeout: 3)
        for _ in 0..<6 {
            if element.exists, element.isHittable { element.tap(); pause(1); return true }
            app.swipeUp(velocity: .slow)
        }
        return false
    }
}
