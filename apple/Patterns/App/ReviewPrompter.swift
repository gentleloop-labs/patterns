import OSLog
import PatternsCore
import StoreKit
import UIKit

/// `ReviewPromptService.maybeRequestReview`: asks for the App Store review
/// sheet at a calm, positive moment, only when `ReviewPromptPolicy` allows.
/// Settings' "Rate Patterns" opens the store page instead and never counts
/// towards these limits.
@MainActor
final class ReviewPrompter {
    private let policy: ReviewPromptPolicy
    private let events: AppEvents
    private var inFlight = false
    private static let log = Logger(subsystem: "com.maskedsyntax.patterns", category: "review")

    init(prefs: FlutterPreferences, events: AppEvents) {
        policy = ReviewPromptPolicy(prefs: prefs)
        self.events = events
    }

    /// Counts the launch day and stamps the first launch.
    func recordSessionStart() { policy.recordSessionStart() }

    /// Asks for the sheet if the user is eligible, after a short pause,
    /// unless the caller's task was cancelled (they left the screen).
    func maybeRequest(_ trigger: ReviewPromptPolicy.Trigger) async {
        guard !inFlight else { return }
        if let reason = policy.diagnostics().reason {
            events.reviewSkipped(trigger, reason: reason)
            return
        }
        events.reviewEligible(trigger)
        inFlight = true
        defer { inFlight = false }
        try? await Task.sleep(for: .milliseconds(600))
        guard !Task.isCancelled else { return }
        // StoreKit with an explicit scene: SwiftUI's `requestReview` action
        // could not find one from inside the tab view.
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        guard let scene = scenes.first(where: { $0.activationState == .foregroundActive }) else {
            Self.log.info("No active scene: \(scenes.map { String(describing: $0.activationState.rawValue) })")
            // `isAvailable` false in Flutter: back off a week.
            policy.recordFailure()
            events.reviewUnavailable(trigger)
            return
        }
        AppStore.requestReview(in: scene)
        policy.recordAttempt()
        events.reviewRequested(trigger)
    }
}
