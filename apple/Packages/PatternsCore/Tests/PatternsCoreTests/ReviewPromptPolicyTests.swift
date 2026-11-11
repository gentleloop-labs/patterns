import Foundation
import Testing
@testable import PatternsCore

/// The rules from `test/review_prompt_test.dart`'s point of view: who may be
/// asked for a review, and in which order the reasons are checked.
@Suite("Review prompt eligibility")
struct ReviewPromptPolicyTests {
    final class Defaults {
        let name = "patterns-review-\(UUID().uuidString)"
        let defaults: UserDefaults
        init() { defaults = UserDefaults(suiteName: name)! }
        deinit { defaults.removePersistentDomain(forName: name) }
        var prefs: FlutterPreferences { FlutterPreferences(defaults: defaults) }
    }

    let now = Date(timeIntervalSince1970: 1_787_571_700)
    func ago(days: Double = 0, hours: Double = 0) -> Int {
        ReviewPromptPolicy.millis(now.addingTimeInterval(-(days * 86_400 + hours * 3600)))
    }

    /// An engaged user: two days in, two actions, two distinct days.
    func eligibleStore() -> Defaults {
        let store = Defaults()
        store.prefs.set(ago(days: 2), for: PreferenceKey.ratingFirstSeen)
        store.prefs.set(2, for: PreferenceKey.ratingMeaningfulActionCount)
        store.prefs.set(2, for: PreferenceKey.ratingDistinctDays)
        return store
    }

    func policy(_ store: Defaults, at date: Date? = nil) -> ReviewPromptPolicy {
        ReviewPromptPolicy(prefs: store.prefs, now: { date ?? now })
    }

    @Test("an engaged user is eligible")
    func eligible() {
        let store = eligibleStore()
        #expect(policy(store).diagnostics().eligible)
    }

    @Test("each rule holds the prompt back")
    func rules() {
        func reason(_ change: (FlutterPreferences) -> Void) -> ReviewPromptPolicy.Ineligibility? {
            let store = eligibleStore()
            change(store.prefs)
            return policy(store).diagnostics().reason
        }
        #expect(reason { $0.set(true, for: PreferenceKey.ratingOptedOut) } == .optedOut)
        #expect(reason { $0.set(true, for: PreferenceKey.ratingCompleted) } == .completed)
        #expect(reason { $0.remove(PreferenceKey.ratingFirstSeen) } == .missingFirstSeen)
        #expect(reason { $0.set(ago(hours: 23), for: PreferenceKey.ratingFirstSeen) } == .tooRecentlyInstalled)
        #expect(reason { $0.set(1, for: PreferenceKey.ratingMeaningfulActionCount) } == .notEnoughMeaningfulActions)
        #expect(reason { $0.set(1, for: PreferenceKey.ratingDistinctDays) } == .notEnoughDistinctDays)
        #expect(reason { $0.set(ago(days: 6), for: PreferenceKey.ratingLastFailureTs) } == .failureBackoff)
        #expect(reason { $0.set(ago(days: 8), for: PreferenceKey.ratingLastFailureTs) } == nil)
        #expect(reason { $0.set([String(ago(days: 29))], for: PreferenceKey.ratingAttemptHistory) } == .promptCooldown)
        #expect(reason {
            $0.set([ago(days: 200), ago(days: 100), ago(days: 40)].map(String.init), for: PreferenceKey.ratingAttemptHistory)
        } == .annualAttemptLimit)
        #expect(reason {
            $0.set([ago(days: 400), ago(days: 100), ago(days: 40)].map(String.init), for: PreferenceKey.ratingAttemptHistory)
        } == nil)
        #expect(reason { $0.set(ago(days: 13), for: PreferenceKey.ratingLastDeclineTs) } == .declineCooldown)
    }

    @Test("older installs count journal and tracker saves as meaningful actions")
    func legacyMeaningfulActions() {
        let store = eligibleStore()
        store.prefs.remove(PreferenceKey.ratingMeaningfulActionCount)
        store.prefs.set(1, for: PreferenceKey.ratingJournalCount)
        store.prefs.set(1, for: PreferenceKey.ratingOcdCount)
        #expect(policy(store).diagnostics().meaningfulActionCount == 2)
    }

    @Test("session starts stamp the first launch and count each day once")
    func sessions() {
        let store = Defaults()
        policy(store).recordSessionStart()
        policy(store).recordSessionStart()
        #expect(store.prefs.int(PreferenceKey.ratingFirstSeen) == ReviewPromptPolicy.millis(now))
        #expect(store.prefs.int(PreferenceKey.ratingDistinctDays) == 1)
        policy(store, at: now.addingTimeInterval(86_400)).recordSessionStart()
        #expect(store.prefs.int(PreferenceKey.ratingDistinctDays) == 2)
        #expect(store.prefs.int(PreferenceKey.ratingFirstSeen) == ReviewPromptPolicy.millis(now))
    }

    @Test("a legacy single prompt time becomes the attempt history")
    func legacyMigration() {
        let store = eligibleStore()
        store.prefs.set(ago(days: 10), for: PreferenceKey.ratingLastPromptTs)
        policy(store).recordSessionStart()
        #expect(store.prefs.stringList(PreferenceKey.ratingAttemptHistory) == [String(ago(days: 10))])
        #expect(policy(store).diagnostics().reason == .promptCooldown)
    }

    @Test("an attempt starts the cooldown and clears a failure")
    func attempts() {
        let store = eligibleStore()
        policy(store).recordFailure()
        #expect(policy(store).diagnostics().reason == .failureBackoff)
        policy(store).recordAttempt()
        #expect(!store.prefs.contains(PreferenceKey.ratingLastFailureTs))
        #expect(store.prefs.int(PreferenceKey.ratingLastPromptTs) == ReviewPromptPolicy.millis(now))
        #expect(policy(store).diagnostics().reason == .promptCooldown)
        #expect(policy(store, at: now.addingTimeInterval(31 * 86_400)).diagnostics().eligible)
    }
}
