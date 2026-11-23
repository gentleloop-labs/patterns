import Foundation

/// The eligibility rules of `ReviewPromptService` from
/// `lib/services/review_prompt.dart`, on the same `rating_` preferences, so
/// an upgraded user's history, cooldowns and opt-outs carry over.
///
/// The App Store review sheet is asked for only when the user has had the
/// app a day, used it on two different days, done two meaningful things,
/// and has not been asked in the last 30 days (3 times a year at most). The
/// system decides whether the sheet actually appears and never says whether
/// a rating was left, so attempts are recorded, not ratings.
public struct ReviewPromptPolicy {
    public static let minHoursInstalled = 24
    public static let minMeaningfulActions = 2
    public static let minDistinctDays = 2
    public static let automaticCooldownDays = 30
    public static let failureBackoffDays = 7
    public static let maxAutomaticAttempts = 3
    public static let attemptWindowDays = 365
    static let legacyDeclineCooldownDays = 14

    /// `ReviewTrigger`. Flutter defines four; only `analyticsLinger` asks.
    public enum Trigger: String, Sendable {
        case journalSaved, urgeCompleted, erpCompleted, analyticsLinger
    }

    /// `RatingPromptIneligibility`, by Dart enum name.
    public enum Ineligibility: String, Sendable {
        case optedOut, completed, missingFirstSeen, tooRecentlyInstalled, notEnoughMeaningfulActions,
             notEnoughDistinctDays, promptCooldown, annualAttemptLimit, failureBackoff, declineCooldown
    }

    public struct Diagnostics: Equatable, Sendable {
        public var hoursInstalled: Int
        public var meaningfulActionCount: Int
        public var distinctDays: Int
        public var attemptsInWindow: Int
        public var reason: Ineligibility?
        public var eligible: Bool { reason == nil }
    }

    private let prefs: FlutterPreferences
    private let now: () -> Date

    public init(prefs: FlutterPreferences, now: @escaping () -> Date = Date.init) {
        self.prefs = prefs
        self.now = now
    }

    /// `recordSessionStart`: moves a pre-history `rating_last_prompt_ts`
    /// into the attempt list, stamps the first launch, and counts the day.
    public func recordSessionStart() {
        let date = now()
        writeAttempts(attempts(at: date))
        if !prefs.contains(PreferenceKey.ratingFirstSeen) {
            prefs.set(Self.millis(date), for: PreferenceKey.ratingFirstSeen)
        }
        let today = JournalEntry.dayKey(for: date)
        if prefs.string(PreferenceKey.ratingLastDayKey) != today {
            prefs.set((prefs.int(PreferenceKey.ratingDistinctDays) ?? 0) + 1, for: PreferenceKey.ratingDistinctDays)
            prefs.set(today, for: PreferenceKey.ratingLastDayKey)
        }
    }

    public func diagnostics() -> Diagnostics {
        let date = now()
        let firstSeen = prefs.int(PreferenceKey.ratingFirstSeen).map(Self.date)
        let installed = firstSeen.map { date.timeIntervalSince($0) } ?? 0
        let journal = prefs.int(PreferenceKey.ratingJournalCount) ?? 0
        let ocd = prefs.int(PreferenceKey.ratingOcdCount) ?? 0
        let meaningful = prefs.int(PreferenceKey.ratingMeaningfulActionCount) ?? (journal + ocd)
        let distinctDays = prefs.int(PreferenceKey.ratingDistinctDays) ?? 0
        let attempts = attempts(at: date)
        let lastFailure = prefs.int(PreferenceKey.ratingLastFailureTs).map(Self.date)
        let lastDecline = prefs.int(PreferenceKey.ratingLastDeclineTs).map(Self.date)
        let day: TimeInterval = 86_400

        var reason: Ineligibility?
        if prefs.bool(PreferenceKey.ratingOptedOut) ?? false {
            reason = .optedOut
        } else if prefs.bool(PreferenceKey.ratingCompleted) ?? false {
            reason = .completed
        } else if firstSeen == nil {
            reason = .missingFirstSeen
        } else if Int(installed / 3600) < Self.minHoursInstalled {
            reason = .tooRecentlyInstalled
        } else if meaningful < Self.minMeaningfulActions {
            reason = .notEnoughMeaningfulActions
        } else if distinctDays < Self.minDistinctDays {
            reason = .notEnoughDistinctDays
        } else if let lastFailure, date.timeIntervalSince(lastFailure) < Double(Self.failureBackoffDays) * day {
            reason = .failureBackoff
        } else if let last = attempts.last, date.timeIntervalSince(last) < Double(Self.automaticCooldownDays) * day {
            reason = .promptCooldown
        } else if attempts.count >= Self.maxAutomaticAttempts {
            reason = .annualAttemptLimit
        } else if let lastDecline, date.timeIntervalSince(lastDecline) < Double(Self.legacyDeclineCooldownDays) * day {
            reason = .declineCooldown
        }
        return Diagnostics(hoursInstalled: Int(installed / 3600), meaningfulActionCount: meaningful,
                           distinctDays: distinctDays, attemptsInWindow: attempts.count, reason: reason)
    }

    /// `_recordAttempt`: the sheet was asked for.
    public func recordAttempt() {
        let date = now()
        writeAttempts(attempts(at: date) + [date])
        prefs.set(Self.millis(date), for: PreferenceKey.ratingLastPromptTs)
        prefs.remove(PreferenceKey.ratingLastFailureTs)
    }

    /// `_recordFailure`: asking failed; back off for a week.
    public func recordFailure() {
        prefs.set(Self.millis(now()), for: PreferenceKey.ratingLastFailureTs)
    }

    // MARK: Internals

    /// `_readAttemptHistory`: attempts in the last 365 days, oldest first.
    /// Without a list, the legacy single timestamp stands in.
    private func attempts(at date: Date) -> [Date] {
        var values: [Date]
        if let raw = prefs.stringList(PreferenceKey.ratingAttemptHistory) {
            values = raw.compactMap { Int64($0) }.map { Date(timeIntervalSince1970: Double($0) / 1000) }
        } else if let legacy = prefs.int(PreferenceKey.ratingLastPromptTs) {
            values = [Self.date(legacy)]
        } else {
            values = []
        }
        let window = Double(Self.attemptWindowDays) * 86_400
        return values.filter { candidate in
            let age = date.timeIntervalSince(candidate)
            return age >= 0 && age < window
        }.sorted()
    }

    private func writeAttempts(_ attempts: [Date]) {
        prefs.set(attempts.map { String(Self.millis($0)) }, for: PreferenceKey.ratingAttemptHistory)
    }

    static func millis(_ date: Date) -> Int { Int((date.timeIntervalSince1970 * 1000).rounded(.down)) }
    static func date(_ millis: Int) -> Date { Date(timeIntervalSince1970: Double(millis) / 1000) }
}
