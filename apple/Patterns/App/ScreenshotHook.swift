#if DEBUG
import UIKit

/// Debug builds only: opens a screen from a launch argument so store
/// screenshots can be captured from the simulator, for example
/// `-screenshotRoute hierarchy` or `-screenshotRoute settings -screenshotSheet privacy`.
enum ScreenshotHook {
    static var route: String? { UserDefaults.standard.string(forKey: "screenshotRoute") }
    static var sheet: String? { UserDefaults.standard.string(forKey: "screenshotSheet") }

    /// Returns true when a screenshot route was opened.
    @MainActor
    static func open(_ navigation: AppNavigation) -> Bool {
        guard let route else { return false }
        // `-screenshotEndEditing <seconds>` drops the keyboard focus after
        // text was typed in, so no blinking cursor is captured.
        let seconds = UserDefaults.standard.double(forKey: "screenshotEndEditing")
        if seconds > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        switch route {
        case "delay": navigation.push(.compulsionDelay)
        case "hierarchy": navigation.push(.exposureHierarchyDetail(id: 1))
        case "uncertainty": navigation.push(.uncertaintyTraining)
        case let r where r.hasPrefix("uncertainty:"): navigation.push(.uncertaintyPractice(exercise: String(r.dropFirst(12))))
        case "urgesurf": navigation.push(.urgeSurf)
        case "materials": navigation.push(.exposureMaterials(stepID: nil, hierarchyID: nil))
        case let r where r.hasPrefix("journal:"): navigation.push(.journalEntry(day: String(r.dropFirst(8))))
        case "settings": navigation.push(.settings)
        case "paywall": navigation.presentPaywall(.settings)
        default: return false
        }
        return true
    }
}
#endif
