import Observation
import PatternsCore
import SwiftUI

/// The five bottom tabs, in Flutter's order. Raw values are the Dart enum
/// names saved under `mobileSelectedTab`.
enum AppTab: String, CaseIterable, Identifiable {
    case home, journal, track, erp, insights
    var id: String { rawValue }
}

/// Full-screen pages pushed over the tabs, as Flutter's `MaterialPageRoute`
/// pushes cover the floating tab bar.
enum Route: Hashable {
    /// A journal day, by its stored `yyyy-MM-dd` key.
    case journalEntry(day: String)
    case settings
}

/// What `showQuietCompletion` says after an activity is saved.
enum CompletionKind: Equatable {
    case journal
    case trackedMoment(updated: Bool)
    case compulsionDelay
    case erp
}

/// `ToastType` from `lib/widgets/app_snack_bar.dart`.
enum ToastKind: Equatable {
    case neutral, success, error, info
}

struct Toast: Equatable, Identifiable {
    let id = UUID()
    let message: String
    let kind: ToastKind
}

/// Navigation and app-wide overlays (toasts and the completion sheet), shared
/// by every screen through the environment.
@MainActor
@Observable
final class AppNavigation {
    var selectedTab: AppTab
    var path: [Route] = []
    private(set) var toast: Toast?
    var completion: CompletionKind?

    private let prefs: FlutterPreferences
    private var toastTask: Task<Void, Never>?

    init(prefs: FlutterPreferences) {
        self.prefs = prefs
        selectedTab = prefs.string(PreferenceKey.mobileSelectedTab).flatMap(AppTab.init(rawValue:)) ?? .home
    }

    func select(_ tab: AppTab) {
        guard tab != selectedTab else { return }
        selectedTab = tab
        prefs.set(tab.rawValue, for: PreferenceKey.mobileSelectedTab)
    }

    func push(_ route: Route) { path.append(route) }

    func pop() {
        if !path.isEmpty { path.removeLast() }
    }

    /// `returnToNeutralHome`: closes every pushed page and selects Today.
    func returnToNeutralHome() {
        path.removeAll()
        select(.home)
    }

    /// `showAppSnackBar`: one toast at a time, 2.8 s (4 s for errors).
    func showToast(_ message: String, kind: ToastKind = .neutral) {
        let toast = Toast(message: message, kind: kind)
        self.toast = toast
        UIAccessibility.post(notification: .announcement, argument: message)
        toastTask?.cancel()
        toastTask = Task { [weak self] in
            try? await Task.sleep(for: kind == .error ? .seconds(4) : .milliseconds(2800))
            guard !Task.isCancelled, self?.toast?.id == toast.id else { return }
            self?.toast = nil
        }
    }

    func dismissToast() { toast = nil }

    /// `showQuietCompletion` followed by `returnToNeutralHome`, as the
    /// Flutter flows do after a save.
    func completeActivity(_ kind: CompletionKind) {
        completion = kind
    }
}
