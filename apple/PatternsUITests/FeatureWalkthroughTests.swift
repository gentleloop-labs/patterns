import XCTest

private extension CGRect {
    var center: CGPoint { CGPoint(x: midX, y: midY) }
}

/// End-to-end walkthrough of every feature, paced for a screen recording.
///
/// It writes, edits and deletes real data, so it only runs when
/// `PATTERNS_WALKTHROUGH=1` is set, and only on a throwaway clone of a
/// seeded simulator (see `apple/scripts/record-walkthrough.sh`). Each step
/// prints `STEP|seconds|chapter|what`; a step that cannot find its control
/// prints `MISS|…` with the visible controls, and the walk carries on.
@MainActor
final class FeatureWalkthroughTests: XCTestCase {
    private var app = XCUIApplication()
    private var start = Date()
    private var misses: [String] = []
    private var chapter = ""

    override func setUpWithError() throws {
        try XCTSkipUnless(ProcessInfo.processInfo.environment["PATTERNS_WALKTHROUGH"] == "1",
                          "Writes data; run through apple/scripts/record-walkthrough.sh")
        continueAfterFailure = true
    }

    func testWalkthrough() throws {
        start = Date()
        today()
        journal()
        track()
        compulsionDelay()
        guidedErp()
        selfCheck()
        supportTools()
        exposureTools()
        planningTools()
        practiceLogs()
        insights()
        settings()
        app.terminate()
        print(misses.isEmpty ? "WALK|clean" : misses.joined(separator: "\n"))
        XCTAssertTrue(misses.isEmpty, "\(misses.count) steps could not be completed")
    }

    // MARK: Chapters

    private func today() {
        begin("Today", tab: "home")
        step("Scroll the Today dashboard")
        app.swipeUp(velocity: .slow); pause(); app.swipeDown(velocity: .slow); pause()
    }

    private func journal() {
        begin("Journal", tab: "journal")
        step("Open an older entry")
        if tapPrefix("Nov 9,") { pause(2); back() }
        step("Write today's entry with formatting")
        guard tapLabel("New entry") else { return }
        let editor = app.textViews["Journal editor"]
        guard wait(editor) else { return miss("journal editor") }
        editor.tap()
        app.typeText(" Walkthrough entry. ")
        tapLabel("Bold"); app.typeText("Bold words"); tapLabel("Bold")
        app.typeText(" and ")
        tapLabel("Italic"); app.typeText("italic words"); tapLabel("Italic")
        app.typeText("\n"); tapLabel("Bulleted list"); app.typeText("A bullet point")
        pause(3) // autosave fires after 2 s; status shows Saved
        step("Leave and come back: the entry was autosaved")
        back(); pause()
        tapLabel("New entry"); pause(2)
        if !((app.textViews["Journal editor"].value as? String) ?? "").contains("A bullet point") {
            miss("autosaved journal text missing")
        }
        tapLabel("Save"); pause(2); dismissAny()
        back()
        step("Search the journal")
        app.swipeDown(velocity: .slow)
        let search = app.searchFields.firstMatch
        if wait(search) { search.tap(); search.typeText("contamination"); pause(2); tapAny(["Cancel", "Close"]) } else { miss("journal search field") }
        step("Pick a date")
        if tapLabel("Choose date") { pause(); tapLabel("Cancel") }
    }

    private func track() {
        begin("Track", tab: "track")
        step("Filter obsessions and compulsions")
        tapLabel("Obsessions"); pause(); tapLabel("Compulsions"); pause(); tapLabel("All")
        step("Log a new OCD event")
        guard tapLabel("Track OCD event") else { return }
        tapLabel("Compulsion")
        // Slider before typing: the keyboard would cover it.
        let slider = app.sliders["Distress, 0 to 10"]
        if slider.waitForExistence(timeout: 2) {
            slider.adjust(toNormalizedSliderPosition: 0.7); pause()
            print("PEEK|Track|slider after adjust|\(slider.value as? String ?? "?")")
        }
        let field = app.textFields.firstMatch
        if wait(field) { field.tap(); field.typeText("Walkthrough: urge to recheck the stove") }
        tapLabel("Save event"); pause(2)
        tapAny(["Done for now"], quiet: true)
        selectTab("Track") // "Done for now" returns to Today
        step("Edit the event")
        if tapPrefix("Compulsion. ") {
            pause()
            let edit = app.textFields.firstMatch
            if wait(edit) { edit.tap(); edit.typeText(" (edited)") }
            tapAny(["Update event", "Save event"]); pause(2)
            tapAny(["Done for now"], quiet: true)
            selectTab("Track")
        }
        step("Delete the event")
        let row = app.buttons.matching(NSPredicate(format: "label CONTAINS %@", "(edited)")).firstMatch
        if wait(row) {
            row.swipeLeft(); pause()
            // The swipe action is "Delete event"; the alert confirms with "Delete".
            if tapAny(["Delete event"]) { tapAny(["Delete"]) }
            pause(2)
        } else { miss("edited event row") }
    }

    private func compulsionDelay() {
        begin("Compulsion delay (1 minute, full length)", tab: "erp")
        guard openTool("Compulsion Delay") else { return }
        tapLabel("1 min")
        let field = app.textFields.firstMatch
        if wait(field) { field.tap(); field.typeText("Rechecking the front door") }
        guard tapLabel("Begin") else { return }
        step("Timer running")
        pause(64)
        step("Timer done: record the outcome")
        tapLabel("Did not do it")
        tapLabel("Save practice"); pause(2)
        tapAny(["Done for now", "Done"], quiet: true)
    }

    private func guidedErp() {
        begin("Guided ERP", tab: "erp")
        guard openTool("Guided ERP") else { return }
        step("Create a plan")
        if tapLabel("New") {
            tapLabel("Delay Googling")
            fill(["Not searching a symptom for 10 minutes", "I will feel worse forever",
                  "No searching while the timer runs"])
            tapLabel("Create plan"); pause(2)
        }
        step("Practise the plan, then stop early")
        guard tapAnyPrefix(["Delay Googling", "Delay Checking"]) else { return miss("ERP plan row") }
        guard tapLabel("Start practice") else { return }
        pause(10)
        tapLabel("Stop early"); pause(); tapLabel("Stop"); pause()
        step("Reflect and save")
        tapLabel("Delayed the response")
        tapLabel("Save practice"); pause(2)
        tapAny(["Done for now", "Done"], quiet: true)
    }

    private func selfCheck() {
        begin("OCD self-check (Y-BOCS)", tab: "erp")
        guard openTool("OCD Self-Check"), tapLabel("Take it again") else { return }
        step("Checklist")
        tapLabel("Concern with dirt or germs"); tapLabel("Fear I might harm someone else")
        guard tapPrefix("Continue") else { return }
        step("Answer the 10 questions")
        for _ in 0..<10 {
            let options = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'A moderate' OR label BEGINSWITH 'Moderate' OR label BEGINSWITH 'Some'"))
            if options.firstMatch.exists { options.firstMatch.tap() } else { tapNthOption(2) }
            pause(0.6)
            if !tapAny(["Next", "See results"]) { miss("Y-BOCS next"); break }
        }
        step("Result: save to history")
        tapLabel("Save to my history"); pause(2)
        tapLabel("Done"); pause()
    }

    private func supportTools() {
        begin("Support in a difficult moment", tab: "erp")
        guard openTool("Support in a difficult moment") else { return }
        step("Paced breathing")
        if tapPrefix("Breathe") { pause(8); back() }
        step("Coping techniques")
        if tapPrefix("Coping techniques") { pause(); tapLabel("Grounding (5-4-3-2-1)"); pause(2); back() }

        begin("Urge surfing", tab: "erp")
        guard openTool("Urge Surfing"), tapLabel("Start a surf") else { return }
        tapLabel("1 minute")
        let field = app.textFields.firstMatch
        if wait(field) { field.tap(); field.typeText("Urge to wash my hands again") }
        guard tapLabel("Begin") else { return }
        step("Observing the urge, rating it as it changes")
        pause(10)
        if app.sliders.firstMatch.exists { app.sliders.firstMatch.adjust(toNormalizedSliderPosition: 0.4) }
        pause(10)
        tapLabel("Done for now"); pause()
        step("Save the surf")
        peek("urge surf reflection")
        tapAny(["Save surf", "Finish"]); pause(2)

        begin("Uncertainty training", tab: "erp")
        guard openTool("Uncertainty Training"), tapPrefix("Maybe, maybe not") else { return }
        step("Record a practice")
        let note = app.textFields.firstMatch
        if wait(note) { note.tap(); note.typeText("Let the question stay open") }
        tapLabel("Record this practice"); pause(2)
        peek("after uncertainty record")
    }

    private func exposureTools() {
        begin("Exposure hierarchy", tab: "erp")
        guard openTool("Exposure Hierarchy") else { return }
        step("Build a new ladder")
        if tapLabel("New") {
            let fields = app.textFields
            if wait(fields.firstMatch) {
                fields.element(boundBy: 0).tap(); app.typeText("Walkthrough ladder")
                let stepField = app.textFields["What exposure could you practise?"].exists
                    ? app.textFields["What exposure could you practise?"] : fields.element(boundBy: 2)
                stepField.tap(); app.typeText("Touch a door handle")
            }
            dismissKeyboard()
            tapLabel("Create hierarchy"); pause(2)
        }
        step("Mark a step in progress")
        if tapAnyPrefix(["Walkthrough ladder", "Checking ladder"]) {
            tapLabel("In progress"); pause(2); back()
        }

        begin("Exposure materials", tab: "erp")
        guard openTool("Exposure Materials") else { return }
        step("Read an existing script")
        if tapLabel("Read script") { pause(2); dismissAny() }
        step("Save a new script")
        if tapLabel("New"), tapLabel("Script") {
            typeInto(placeholder: "A short name", "Walkthrough script")
            typeInto(placeholder: "The text you want to read", "Maybe it is clean, maybe not. I can carry on.")
            tapLabel("Save material"); pause(2)
        }

        begin("Structured programs", tab: "erp")
        guard openTool("Structured Programs") else { return }
        step("Open a program and tick a task")
        if tapPrefix("Checking and doubt") {
            pause(2)
            let week = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Week 1'")).firstMatch
            let weekTwo = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Week 2'")).firstMatch
            if wait(week), wait(weekTwo) {
                // Expanded when its tasks sit between Week 1 and Week 2.
                if weekTwo.frame.minY - week.frame.maxY < 40 { week.tap(); pause() }
                // Tick the first task, the row just under the week header.
                week.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 1.9)).tap(); pause(2)
            }
            back()
        } else { miss("program row") }
    }

    private func planningTools() {
        begin("Action planner", tab: "erp")
        if openTool("Action Planner"), tapLabel("New") {
            fill(["I notice the urge to search a symptom", "Wait 15 minutes before deciding"])
            tapLabel("Save action plan"); pause(2)
            step("Mark the plan done")
            tapPrefix("Mark action plan"); pause(2)
        }

        begin("Implementation intentions", tab: "erp")
        if openTool("Implementation Intentions"), tapLabel("New") {
            fill(["I notice the urge to seek reassurance", "write down what I am noticing"])
            tapLabel("Save if–then plan"); pause(2)
        }

        begin("Behavioral experiments", tab: "erp")
        if openTool("Behavioral Experiments"), tapLabel("New") {
            fill(["If I do not check again, the house will flood", "Leave after one normal check"])
            tapLabel("Save experiment"); pause(2)
        }
    }

    private func practiceLogs() {
        begin("Response prevention", tab: "erp")
        if openTool("Response Prevention"), tapLabel("Log") {
            tapLabel("Delayed")
            fill(["Asked to text my partner for reassurance"])
            tapLabel("Save log"); pause(2)
        }

        begin("Reflection journal", tab: "erp")
        if openTool("Reflection Journal"), tapLabel("New") {
            fill(["Touched the door handle", "I would get ill", "Anxiety peaked then dropped"])
            tapLabel("Save reflection"); pause(2)
        }

        begin("Practice activity and coping library", tab: "erp")
        if openTool("Practice Activity") { app.swipeUp(velocity: .slow); pause(2); back() }
        if openTool("Coping Library") { tapLabel("Self-compassion"); pause(2) }
    }

    private func insights() {
        begin("Insights", tab: "insights")
        step("Overview, obsessions, compulsions, ERP")
        app.swipeUp(velocity: .slow); pause(); app.swipeDown(velocity: .fast)
        for tab in ["Obsessions", "Compulsions", "ERP", "Overview"] { tapLabel(tab); pause(1.5) }
        step("Change the date range")
        if tapLabel("Change date range") { pause(); tapNthMenuItem(); pause() }
        step("Export a PDF report")
        if tapLabel("Export report") {
            pause()
            tapLabel("Save PDF"); pause(3)
            // The system save sheet: save to On My iPhone.
            if app.buttons["Save"].waitForExistence(timeout: 4) {
                app.buttons["Save"].tap(); pause(2)
                if app.buttons["Replace"].waitForExistence(timeout: 2) { app.buttons["Replace"].tap(); pause(2) }
            }
            else if app.buttons["Move"].exists { app.buttons["Move"].tap(); pause(2) }
            else { dismissAny() }
        }
    }

    private func settings() {
        begin("Settings", tab: "home")
        guard tapLabel("Settings") else { return }
        step("Appearance: dark, then light, then system")
        tapLabel("Dark"); pause(2); tapLabel("Light"); pause(2); tapLabel("System"); pause()
        step("Calm Insights on and off")
        toggle("Calm Insights"); pause(); toggle("Calm Insights")
        step("Daily reminder on")
        toggle("Daily reminder"); pause(2)
        allowSystemAlert()
        step("Export a ZIP backup")
        if tapPrefix("Export data") {
            pause()
            tapLabel("Export ZIP backup"); pause(3)
            if app.buttons["Save"].waitForExistence(timeout: 4) {
                app.buttons["Save"].tap(); pause(2)
                if app.buttons["Replace"].waitForExistence(timeout: 2) { app.buttons["Replace"].tap(); pause(2) }
            } else { dismissAny() }
        }
        app.swipeUp(velocity: .slow); pause()
        step("Privacy & safety")
        if tapPrefix("Privacy & safety") { pause(2); dismissAny() }
        step("Replay the app tour")
        if tapPrefix("Replay the app tour") {
            for _ in 0..<6 { pause(); if !tapAny(["Next", "Continue"], quiet: true) { break } }
            dismissAny()
        }
    }

    // MARK: Steps

    private func begin(_ title: String, tab: String) {
        chapter = title
        launchTab(tab)
        step("Open")
    }

    private func step(_ what: String) {
        print(String(format: "STEP|%.0f|%@|%@", Date().timeIntervalSince(start), chapter, what))
    }

    private func miss(_ what: String) {
        // One snapshot: querying elements one by one fails while the screen
        // is still animating.
        var labels: [String] = []
        func walk(_ node: XCUIElementSnapshot) {
            if node.elementType == .button || node.elementType == .textField || node.elementType == .switch,
               !node.label.isEmpty || node.placeholderValue != nil {
                labels.append(node.label.isEmpty ? "ph:\(node.placeholderValue ?? "")" : String(node.label.prefix(50)))
            }
            node.children.forEach(walk)
        }
        if let root = try? app.snapshot() { walk(root) }
        let line = "MISS|\(chapter)|\(what)|\(labels.prefix(45).joined(separator: " ; "))"
        print(line)
        misses.append(line)
    }

    private func launchTab(_ tab: String) {
        app.terminate()
        app = XCUIApplication()
        app.launchArguments = [
            "-flutter.mobileSelectedTab", tab, "-flutter.appLockEnabled", "<false/>",
            "-flutter.proUnlocked", "<true/>", "-AppleLanguages", "(en)", "-AppleLocale", "en_US",
        ]
        app.launch()
        _ = app.tabBars.firstMatch.waitForExistence(timeout: 8)
        pause()
    }

    /// Switches tab if the tab bar is showing (pushed screens hide it).
    private func selectTab(_ name: String) {
        let tab = app.tabBars.buttons[name]
        if tab.waitForExistence(timeout: 2) { tab.tap(); pause() }
    }

    private func pause(_ seconds: Double = 1) {
        RunLoop.current.run(until: Date().addingTimeInterval(seconds))
    }

    private func wait(_ element: XCUIElement) -> Bool { element.waitForExistence(timeout: 4) }

    /// Taps an element by exact label, scrolling down to find it.
    @discardableResult
    private func tapLabel(_ label: String) -> Bool {
        let element = app.buttons[label].exists ? app.buttons[label].firstMatch
            : app.switches[label].exists ? app.switches[label].firstMatch
            : app.staticTexts[label].firstMatch
        return tapScrolling(element, label)
    }

    @discardableResult
    private func tapPrefix(_ prefix: String) -> Bool {
        tapScrolling(app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch, prefix)
    }

    private func tapScrolling(_ element: XCUIElement, _ name: String) -> Bool {
        _ = element.waitForExistence(timeout: 3)
        for _ in 0..<6 {
            if element.exists, element.isHittable { element.tap(); pause(); return true }
            // Some controls (segments, buttons inside rows) report not
            // hittable while plainly on screen: tap where they are.
            if element.exists, app.windows.firstMatch.frame.insetBy(dx: 0, dy: 60).contains(element.frame.center) {
                element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap(); pause(); return true
            }
            app.swipeUp(velocity: .slow)
        }
        miss("tap \(name)")
        return false
    }

    /// Taps the first of several labels that is on screen (a fallback chain
    /// without logging a miss for the alternatives).
    @discardableResult
    private func tapAny(_ labels: [String], quiet: Bool = false) -> Bool {
        for _ in 0..<6 {
            for label in labels {
                for element in [app.buttons[label].firstMatch, app.staticTexts[label].firstMatch]
                where element.exists && element.isHittable {
                    element.tap(); pause(); return true
                }
            }
            app.swipeUp(velocity: .slow)
        }
        if !quiet { miss("tap any of \(labels)") }
        return false
    }

    @discardableResult
    private func tapAnyPrefix(_ prefixes: [String]) -> Bool {
        for prefix in prefixes {
            let element = app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch
            if element.waitForExistence(timeout: 2) { return tapScrolling(element, prefix) }
        }
        miss("tap any prefix of \(prefixes)")
        return false
    }

    /// Prints the visible controls without counting a miss (to learn labels).
    private func peek(_ what: String) {
        var labels: [String] = []
        func walk(_ node: XCUIElementSnapshot) {
            if [.button, .textField, .switch, .staticText].contains(node.elementType), !node.label.isEmpty {
                labels.append(String(node.label.prefix(40)))
            }
            node.children.forEach(walk)
        }
        if let root = try? app.snapshot() { walk(root) }
        print("PEEK|\(chapter)|\(what)|\(labels.prefix(40).joined(separator: " ; "))")
    }

    private func typeInto(placeholder: String, _ text: String) {
        let predicate = NSPredicate(format: "placeholderValue BEGINSWITH %@", placeholder)
        let field = app.textFields.matching(predicate).firstMatch.exists
            ? app.textFields.matching(predicate).firstMatch : app.textViews.matching(predicate).firstMatch
        guard field.waitForExistence(timeout: 3) else { return miss("field \(placeholder)") }
        field.tap(); app.typeText(text)
    }

    private func openTool(_ title: String) -> Bool { tapPrefix(title) }

    private func toggle(_ label: String) {
        let element = app.switches.matching(NSPredicate(format: "label BEGINSWITH %@", label)).firstMatch
        if !tapScrolling(element, label) { return }
    }

    private func fill(_ values: [String]) {
        let fields = app.textFields
        guard wait(fields.firstMatch) else { return miss("form fields") }
        for (index, value) in values.enumerated() where index < fields.count {
            fields.element(boundBy: index).tap()
            app.typeText(value)
        }
    }

    private func tapNthOption(_ n: Int) {
        let cells = app.buttons.allElementsBoundByIndex.filter { $0.isHittable && $0.label.count > 12 }
        if cells.count > n { cells[n].tap() } else { cells.last?.tap() }
    }

    private func tapNthMenuItem() {
        let items = app.buttons.allElementsBoundByIndex.filter { $0.isHittable && $0.label.hasSuffix("days") }
        items.first?.tap()
    }

    private func dismissKeyboard() {
        if app.keyboards.firstMatch.exists {
            if app.toolbars.buttons["Done"].exists { app.toolbars.buttons["Done"].tap() }
            else { app.swipeDown(velocity: .slow) }
            pause(0.5)
        }
    }

    @discardableResult
    private func dismissAny() -> Bool {
        for name in ["Done", "Close", "Cancel", "Not now"] where app.buttons[name].exists && app.buttons[name].isHittable {
            app.buttons[name].firstMatch.tap(); pause(); return true
        }
        return false
    }

    private func allowSystemAlert() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let allow = springboard.buttons["Allow"]
        if allow.waitForExistence(timeout: 3) { allow.tap(); pause() }
    }

    private func back() {
        let button = app.navigationBars.buttons.element(boundBy: 0)
        if button.exists, button.isHittable { button.tap() } else { app.swipeRight() }
        pause()
    }
}
