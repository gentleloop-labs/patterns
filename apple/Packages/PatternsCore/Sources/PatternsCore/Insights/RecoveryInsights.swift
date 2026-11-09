import Foundation

/// The rows the Today screen and Insights summarise, read in one go.
public struct ActivitySnapshot: Sendable {
    public var journals: [JournalEntry]
    public var ocds: [OcdEntry]
    public var delaySessions: [DelaySession]
    public var erpSessions: [ErpExerciseSession]
    public var exposureSteps: [ExposureStep]
    public var responsePreventionLogs: [ResponsePreventionLog]
    public var urgeSurfSessions: [UrgeSurfSession]
    public var ybocsAssessments: [YbocsAssessment]

    public init(journals: [JournalEntry] = [], ocds: [OcdEntry] = [], delaySessions: [DelaySession] = [],
                erpSessions: [ErpExerciseSession] = [], exposureSteps: [ExposureStep] = [],
                responsePreventionLogs: [ResponsePreventionLog] = [], urgeSurfSessions: [UrgeSurfSession] = [],
                ybocsAssessments: [YbocsAssessment] = []) {
        self.journals = journals; self.ocds = ocds; self.delaySessions = delaySessions
        self.erpSessions = erpSessions; self.exposureSteps = exposureSteps
        self.responsePreventionLogs = responsePreventionLogs; self.urgeSurfSessions = urgeSurfSessions
        self.ybocsAssessments = ybocsAssessments
    }

    public static func fetch(_ db: Database) throws -> ActivitySnapshot {
        try ActivitySnapshot(
            journals: JournalEntry.fetchAll(db),
            ocds: OcdEntry.fetchAll(db),
            delaySessions: DelaySession.fetchAll(db),
            erpSessions: ErpExerciseSession.fetchAll(db),
            exposureSteps: ExposureStep.fetchAll(db),
            responsePreventionLogs: ResponsePreventionLog.fetchAll(db),
            urgeSurfSessions: UrgeSurfSession.fetchAll(db),
            ybocsAssessments: YbocsAssessment.fetchAll(db)
        )
    }

    /// Anything real done yet: the Today screen switches from the first-run
    /// layout to the full one at this point.
    public var hasActivity: Bool {
        !journals.isEmpty || !ocds.isEmpty || !delaySessions.isEmpty || !erpSessions.isEmpty
    }

    /// The newest compulsion-delay session, for "Continue practice".
    public var latestDelay: DelaySession? {
        delaySessions.max { ($0.createdAt.date ?? .distantPast) < ($1.createdAt.date ?? .distantPast) }
    }

    fileprivate var completedSteps: [(step: ExposureStep, completedAt: DartTimestamp)] {
        exposureSteps.compactMap { step in
            guard step.status == .completed, let at = step.completedAt else { return nil }
            return (step, at)
        }
    }
}

/// `RecoveryStep`: the ERP-journey stage the "Your next step" card points at.
public enum RecoveryStep: String, Sendable, CaseIterable {
    case selfCheck, buildHierarchy, dailyPractice, reflect, journal
}

/// `CalmInsightsSummary`: factual counts with no score or streak.
public struct CalmInsightsSummary: Sendable, Equatable {
    public var journalCount: Int
    public var trackedMomentCount: Int
    public var delayCount: Int
    public var erpPracticeCount: Int
    public var exposureCount: Int

    public var totalCount: Int { journalCount + trackedMomentCount + delayCount + erpPracticeCount + exposureCount }
    public var hasAnyData: Bool { totalCount > 0 }
}

/// The parts of `RecoveryMetrics` the app shows so far.
public struct RecoveryMetrics: Sendable, Equatable {
    public var practiceStreakDays: Int
    public var exposuresCompleted: Int
    public var sessionsPracticed: Int
    public var avgUrgeReduction: Double
    /// Seven days, oldest first, ending today.
    public var weeklyActivity: [Bool]
    public var hasAnyData: Bool
}

/// The headline numbers of `RecoveryDashboardSummary`. Trends and themes
/// arrive with the Insights port.
public struct RecoveryDashboard: Sendable, Equatable {
    public var rangeDays: Int
    public var recoveryScore: Int
    public var scoreDelta: Double
    public var averageUrge: Double
    public var erpPracticeCount: Int
    public var consistencyPercent: Int
    public var activeDays: Int
    public var hasAnyData: Bool
}

/// `AnalyticsService` from `lib/services/analytics_service.dart`. The
/// formulas match Flutter exactly, so the score a user sees does not change
/// with the update.
public enum RecoveryInsights {
    /// `chooseNextStep`: Assess, Plan, Practice, Review. A free user is never
    /// handed a Pro-only step.
    public static func nextStep(isPro: Bool, hasYbocs: Bool, hasHierarchy: Bool, practicedToday: Bool) -> RecoveryStep {
        if !hasYbocs { return .selfCheck }
        if isPro && !hasHierarchy { return .buildHierarchy }
        if !practicedToday { return .dailyPractice }
        return isPro ? .reflect : .journal
    }

    /// Whether an ERP session or a compulsion delay was logged today.
    public static func practicedToday(_ snapshot: ActivitySnapshot, now: Date = Date(),
                                      calendar: Calendar = .current) -> Bool {
        let isToday = { (t: DartTimestamp) in t.date.map { calendar.isDate($0, inSameDayAs: now) } ?? false }
        return snapshot.erpSessions.contains { isToday($0.createdAt) }
            || snapshot.delaySessions.contains { isToday($0.createdAt) }
    }

    /// `hasEnoughForProgress`: at least three activities over at least two
    /// days before any score is shown.
    public static func hasEnoughForProgress(_ snapshot: ActivitySnapshot, minActivities: Int = 3,
                                            minDistinctDays: Int = 2) -> Bool {
        var count = 0
        var days = Set<String>()
        for j in snapshot.journals { count += 1; days.insert(dayKey(j.createdAt)) }
        for o in snapshot.ocds { count += 1; days.insert(dayKey(o.datetime)) }
        for d in snapshot.delaySessions { count += 1; days.insert(dayKey(d.createdAt)) }
        for e in snapshot.erpSessions { count += 1; days.insert(dayKey(e.createdAt)) }
        return count >= minActivities && days.count >= minDistinctDays
    }

    /// `buildCalmInsights`: counts over the last `days` calendar days.
    public static func calmInsights(_ snapshot: ActivitySnapshot, now: Date = Date(), days: Int = 7,
                                    calendar: Calendar = .current) -> CalmInsightsSummary {
        let today = calendar.startOfDay(for: now)
        let start = calendar.date(byAdding: .day, value: -(days - 1), to: today)!
        let endExclusive = calendar.date(byAdding: .day, value: 1, to: today)!
        let isRecent = { (t: DartTimestamp) -> Bool in
            guard let d = t.date else { return false }
            return d >= start && d < endExclusive
        }
        return CalmInsightsSummary(
            journalCount: snapshot.journals.filter { isRecent($0.createdAt) }.count,
            trackedMomentCount: snapshot.ocds.filter { isRecent($0.datetime) }.count,
            delayCount: snapshot.delaySessions.filter { isRecent($0.createdAt) }.count,
            erpPracticeCount: snapshot.erpSessions.filter { isRecent($0.createdAt) }.count,
            exposureCount: snapshot.completedSteps.filter { isRecent($0.completedAt) }.count
        )
    }

    /// `buildRecoveryMetrics`.
    public static func metrics(_ snapshot: ActivitySnapshot, now: Date = Date(),
                               calendar: Calendar = .current) -> RecoveryMetrics {
        var active = Set<String>()
        snapshot.delaySessions.forEach { active.insert(dayKey($0.createdAt)) }
        snapshot.erpSessions.forEach { active.insert(dayKey($0.createdAt)) }
        snapshot.completedSteps.forEach { active.insert(dayKey($0.completedAt)) }
        snapshot.responsePreventionLogs.forEach { active.insert(dayKey($0.createdAt)) }
        snapshot.urgeSurfSessions.forEach { active.insert(dayKey($0.createdAt)) }

        // Anchored to today, or yesterday if nothing is logged yet today, so a
        // streak is not lost mid-day.
        var streak = 0
        var cursor = active.contains(dayKey(now, calendar)) ? now : calendar.date(byAdding: .day, value: -1, to: now)!
        while active.contains(dayKey(cursor, calendar)) {
            streak += 1
            cursor = calendar.date(byAdding: .day, value: -1, to: cursor)!
        }

        let drops = snapshot.delaySessions.map { $0.urgeBefore - $0.urgeAfter }
            + snapshot.urgeSurfSessions.map { $0.initialUrge - $0.finalUrge }
        let weekly = (0..<7).reversed().map { offset in
            active.contains(dayKey(calendar.date(byAdding: .day, value: -offset, to: now)!, calendar))
        }
        return RecoveryMetrics(
            practiceStreakDays: streak,
            exposuresCompleted: snapshot.exposureSteps.filter { $0.status == .completed }.count,
            sessionsPracticed: snapshot.delaySessions.count + snapshot.erpSessions.count + snapshot.urgeSurfSessions.count,
            avgUrgeReduction: drops.isEmpty ? 0 : Double(drops.reduce(0, +)) / Double(drops.count),
            weeklyActivity: weekly,
            hasAnyData: !active.isEmpty
        )
    }

    /// `buildRecoveryDashboard` for a preset range (30 days on Today).
    public static func dashboard(_ snapshot: ActivitySnapshot, rangeDays: Int = 30, now: Date = Date(),
                                 calendar: Calendar = .current) -> RecoveryDashboard {
        let days = min(max(rangeDays, 7), 365)
        let currentStart = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -(days - 1), to: now)!)
        let currentEnd = endOfDay(now, calendar)
        let previousStart = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -days, to: currentStart)!)
        let previousEnd = endOfDay(calendar.date(byAdding: .day, value: -1, to: currentStart)!, calendar)

        let current = PeriodData(snapshot, start: currentStart, end: currentEnd, days: days, calendar: calendar)
        let previous = PeriodData(snapshot, start: previousStart, end: previousEnd, days: days, calendar: calendar)
        return RecoveryDashboard(
            rangeDays: days,
            recoveryScore: current.recoveryScore,
            scoreDelta: Double(current.recoveryScore - previous.recoveryScore),
            averageUrge: current.averageUrge,
            erpPracticeCount: current.erpPracticeCount,
            consistencyPercent: current.consistencyPercent,
            activeDays: current.activeDays.count,
            hasAnyData: current.hasAnyData
        )
    }

    // MARK: Helpers

    /// Dart's `_dateKey`: the stored date's own year, month and day. Dart
    /// timestamps are written in local time, so this is the text's date part.
    static func dayKey(_ timestamp: DartTimestamp) -> String {
        String(timestamp.raw.prefix(10))
    }

    static func dayKey(_ date: Date, _ calendar: Calendar) -> String {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", c.year!, c.month!, c.day!)
    }

    static func endOfDay(_ date: Date, _ calendar: Calendar) -> Date {
        calendar.date(bySettingHour: 23, minute: 59, second: 59, of: date)!.addingTimeInterval(0.999)
    }
}

/// `_DashboardPeriodData` without the trend buckets.
private struct PeriodData {
    var journals = 0
    var ocds: [OcdEntry] = []
    var activeDays = Set<String>()
    var erpPracticeCount = 0
    var averageUrge = 0.0
    var consistencyPercent = 0
    var recoveryScore = 0

    var hasAnyData: Bool { journals > 0 || !ocds.isEmpty || erpPracticeCount > 0 }

    init(_ s: ActivitySnapshot, start: Date, end: Date, days: Int, calendar: Calendar) {
        let inRange = { (t: DartTimestamp) -> Bool in
            guard let d = t.date else { return false }
            return d >= start && d <= end
        }
        // Journal days are stored as `yyyy-MM-dd` and parse to local midnight.
        let journalDays = s.journals.map(\.date).filter { day in
            guard let d = DartDateTime.parse(day) else { return false }
            return d >= start && d <= end
        }
        let periodOcds = s.ocds.filter { inRange($0.datetime) }
        let delays = s.delaySessions.filter { inRange($0.createdAt) }
        let erp = s.erpSessions.filter { inRange($0.createdAt) }
        let steps = s.completedSteps.filter { inRange($0.completedAt) }
        let responses = s.responsePreventionLogs.filter { inRange($0.createdAt) }
        let surfs = s.urgeSurfSessions.filter { inRange($0.createdAt) }

        var active = Set(journalDays)
        periodOcds.forEach { active.insert(RecoveryInsights.dayKey($0.datetime)) }
        delays.forEach { active.insert(RecoveryInsights.dayKey($0.createdAt)) }
        erp.forEach { active.insert(RecoveryInsights.dayKey($0.createdAt)) }
        steps.forEach { active.insert(RecoveryInsights.dayKey($0.completedAt)) }
        responses.forEach { active.insert(RecoveryInsights.dayKey($0.createdAt)) }
        surfs.forEach { active.insert(RecoveryInsights.dayKey($0.createdAt)) }

        let practice = delays.count + erp.count + steps.count + responses.count + surfs.count
        let urges = periodOcds.map(\.distressLevel) + delays.map(\.urgeAfter) + erp.map(\.anxietyAfter)
            + responses.map(\.anxietyLevel) + surfs.map(\.finalUrge)
        let averageUrge = urges.isEmpty ? 0 : Double(urges.reduce(0, +)) / Double(urges.count)
        let consistency = min(max(Int((Double(active.count) / Double(days) * 100).rounded()), 0), 100)
        let journalScore = min(max(Double(journalDays.count) / Double(days) * 100, 0), 100)
        let erpWindow = (Double(days) / 3).rounded(.up)
        let erpScore = min(max(Double(practice) / erpWindow * 100, 0), 100)
        let urgeScore = urges.isEmpty ? 50 : min(max((10 - averageUrge) / 10 * 100, 0), 100)
        let raw = Double(consistency) * 0.30 + erpScore * 0.30 + urgeScore * 0.25 + journalScore * 0.15

        journals = journalDays.count
        ocds = periodOcds
        activeDays = active
        erpPracticeCount = practice
        self.averageUrge = averageUrge
        consistencyPercent = consistency
        recoveryScore = min(max(Int(raw.dartRounded), 0), 100)
    }
}

extension Double {
    /// Dart's `round()`: halves round away from zero.
    var dartRounded: Double { rounded(.toNearestOrAwayFromZero) }
}
