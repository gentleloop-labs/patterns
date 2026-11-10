import Observation
import PatternsCore
import SwiftUI

/// The five bottom tabs, in Flutter's order. Raw values are the Dart enum
/// names saved under `mobileSelectedTab`.
enum AppTab: String, CaseIterable, Identifiable {
    case home, journal, track, erp, insights
    var id: String { rawValue }
}

/// Pages pushed onto a tab's navigation stack.
enum Route: Hashable {
    /// A journal day, by its stored `yyyy-MM-dd` key.
    case journalEntry(day: String)
    /// `OcdEventFlow`: a new event (`entryID` nil) or an edit.
    case ocdEvent(entryID: Int64?, type: OcdType)
    /// `CompulsionDelayFlow`.
    case compulsionDelay
    /// `ErpPlanPracticeFlow` for a saved plan.
    case erpPractice(planID: Int64)
    case settings
    /// Screens not ported yet; each opens a placeholder until its phase.
    case selfCheck
    case exposureHierarchy
    case erpExercises
    case exposureReflection
    /// A Practice hub tool not ported yet; opens a placeholder.
    case recoveryTool(RecoveryDestination)
    /// The activity a new user picked on the welcome screen.
    case firstRunActivity(FirstRunPath)
    /// `FirstRunResultScreen`.
    case firstRunResult(FirstRunPath)
}

/// What `showQuietCompletion` says after an activity is saved.
enum CompletionKind: Equatable {
    case journal
    case trackedMoment(updated: Bool)
    case compulsionDelay
    case erp
}

/// Centred confirmation dialogs (Flutter's `showDialog` cards).
enum AppDialog: Equatable {
    /// `_showUnlockedDialog`.
    case proUnlocked(restored: Bool)
    /// `TipThanksDialog`.
    case tipThanks
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
    /// Each tab keeps its own stack, as native tab apps do.
    var paths: [AppTab: [Route]] = [:]
    /// The selected tab's stack.
    var path: [Route] {
        get { paths[selectedTab] ?? [] }
        set { paths[selectedTab] = newValue }
    }
    private(set) var toast: Toast?
    var completion: CompletionKind?
    var dialog: AppDialog?
    /// The paywall, opened from anywhere but Settings (which has its own).
    var paywall: ProEntryPoint?
    /// Set when onboarding finishes; the home routes into it once.
    var pendingFirstRun: FirstRunPath?
    /// Bumped by Settings to replay the tab tour on the home screen.
    private(set) var tourRequest = 0

    func requestTour() { tourRequest += 1 }

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
        paths.removeAll()
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

    func presentPaywall(_ entryPoint: ProEntryPoint) { paywall = entryPoint }

    /// A first-run activity was completed: record it and swap the activity
    /// for the result screen, as Flutter pops one and pushes the other.
    func finishFirstRun(_ path: FirstRunPath) {
        prefs.set(true, for: PreferenceKey.firstActivityDone)
        if case .firstRunActivity = self.path.last {
            self.path[self.path.count - 1] = .firstRunResult(path)
        } else {
            push(.firstRunResult(path))
        }
    }

    /// `requirePro`: true when Pro is unlocked; otherwise opens the paywall.
    func requirePro(_ unlocked: Bool, _ entryPoint: ProEntryPoint) -> Bool {
        if !unlocked { presentPaywall(entryPoint) }
        return unlocked
    }

    /// `showQuietCompletion` followed by `returnToNeutralHome`, as the
    /// Flutter flows do after a save.
    func completeActivity(_ kind: CompletionKind) {
        completion = kind
    }
}
