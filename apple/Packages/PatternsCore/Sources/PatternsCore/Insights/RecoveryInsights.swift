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

/// `InsightDelta`: a change between two periods.
public struct InsightDelta: Sendable, Equatable {
    public enum Tone: Sendable { case positive, neutral, negative }

    public var value: Double
    public var lowerIsBetter: Bool

    public init(value: Double, lowerIsBetter: Bool = false) {
        self.value = value
        self.lowerIsBetter = lowerIsBetter
    }

    public var tone: Tone {
        if abs(value) < 0.05 { return .neutral }
        let improved = lowerIsBetter ? value < 0 : value > 0
        return improved ? .positive : .negative
    }

    /// The arrow follows the number; the tone follows the meaning. For a
    /// lower-is-better measure they disagree on purpose: a falling Y-BOCS
    /// or urge score is a green down arrow, never a green up arrow.
    public var arrow: String {
        if tone == .neutral { return "→" }
        return value > 0 ? "↑" : "↓"
    }
}

/// `DashboardPoint`.
public struct DashboardPoint: Sendable, Equatable {
    public var date: Date
    public var value: Double
}

/// `ThemeInsight`. `label` is an internal theme id ("Contamination", or
/// `RecoveryInsights.uncategorizedTheme`), localized at display time.
public struct ThemeInsight: Sendable, Equatable {
    public var label: String
    public var percent: Double
    public var count: Int
}

/// `RecoveryDashboardSummary`.
public struct RecoveryDashboard: Sendable, Equatable {
    public var rangeDays: Int
    public var recoveryScore: Int
    public var scoreDelta: InsightDelta
    public var averageUrge: Double
    public var urgeDelta: InsightDelta
    public var erpPracticeCount: Int
    public var erpDelta: InsightDelta
    public var consistencyPercent: Int
    public var activeDays: Int
    /// Up to the last 30 days of the range, oldest first.
    public var consistencyHeatmap: [Bool]
    public var scoreTrend: [DashboardPoint]
    public var moodTrend: [DashboardPoint]
    public var urgeTrend: [DashboardPoint]
    public var erpTrend: [DashboardPoint]
    public var topThemes: [ThemeInsight]
    public var thoughts: Int
    public var compulsions: Int
    public var hasAnyData: Bool
    /// Self-check totals in the range, oldest first.
    public var ybocsTrend: [DashboardPoint]
    public var latestYbocs: YbocsAssessment?
    /// First to latest self-check in the range; a fall is an improvement.
    public var ybocsDelta: InsightDelta

    /// Two points is the least that says anything about direction.
    public var hasYbocsTrend: Bool { ybocsTrend.count >= 2 }

    public static func == (a: RecoveryDashboard, b: RecoveryDashboard) -> Bool {
        a.rangeDays == b.rangeDays && a.recoveryScore == b.recoveryScore && a.scoreDelta == b.scoreDelta
            && a.averageUrge == b.averageUrge && a.erpPracticeCount == b.erpPracticeCount
            && a.consistencyPercent == b.consistencyPercent && a.consistencyHeatmap == b.consistencyHeatmap
            && a.scoreTrend == b.scoreTrend && a.topThemes == b.topThemes && a.ybocsTrend == b.ybocsTrend
    }
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

    /// `AnalyticsDateRange` presets and their day counts.
    public enum Range: Int, Sendable, CaseIterable {
        case seven = 7, thirty = 30, ninety = 90, year = 365
    }

    /// `buildRecoveryDashboard`: this period against the one before it.
    public static func dashboard(_ snapshot: ActivitySnapshot, rangeDays: Int = 30, now: Date = Date(),
                                 calendar: Calendar = .current) -> RecoveryDashboard {
        let days = min(max(rangeDays, 7), 365)
        let currentStart = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -(days - 1), to: now)!)
        let currentEnd = endOfDay(now, calendar)
        let previousStart = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -days, to: currentStart)!)
        let previousEnd = endOfDay(calendar.date(byAdding: .day, value: -1, to: currentStart)!, calendar)

        let current = PeriodData(snapshot, start: currentStart, end: currentEnd, days: days, calendar: calendar)
        let previous = PeriodData(snapshot, start: previousStart, end: previousEnd, days: days, calendar: calendar)

        // `consistencyHeatmap`: the last min(days, 30) days, oldest first.
        let heatmapDays = min(days, 30)
        let heatmap = (0..<heatmapDays).reversed().map { offset in
            current.activeDays.contains(dayKey(calendar.date(byAdding: .day, value: -offset, to: currentEnd)!, calendar))
        }

        // Up to seven buckets across the range, each scored on its own.
        let bucketCount = days <= 7 ? days : 7
        var scoreTrend: [DashboardPoint] = [], moodTrend: [DashboardPoint] = []
        var urgeTrend: [DashboardPoint] = [], erpTrend: [DashboardPoint] = []
        for bucket in 0..<bucketCount {
            let startOffset = Int((Double(days * bucket) / Double(bucketCount)).rounded(.down))
            let endOffset = Int((Double(days * (bucket + 1)) / Double(bucketCount)).rounded(.down)) - 1
            let bucketStart = calendar.startOfDay(for: calendar.date(byAdding: .day, value: startOffset, to: currentStart)!)
            let bucketEnd = endOfDay(calendar.date(byAdding: .day, value: endOffset, to: currentStart)!, calendar)
            let bucketDays = (calendar.dateComponents([.day], from: bucketStart, to: calendar.startOfDay(for: bucketEnd)).day ?? 0) + 1
            let data = PeriodData(snapshot, start: bucketStart, end: bucketEnd, days: bucketDays, calendar: calendar)
            scoreTrend.append(DashboardPoint(date: bucketEnd, value: Double(data.recoveryScore)))
            moodTrend.append(DashboardPoint(date: bucketEnd, value: data.mood))
            urgeTrend.append(DashboardPoint(date: bucketEnd, value: data.averageUrge))
            erpTrend.append(DashboardPoint(date: bucketEnd, value: Double(data.erpPracticeCount)))
        }

        let ybocs = snapshot.ybocsAssessments
            .compactMap { a in a.datetime.date.map { (a, $0) } }
            .filter { $0.1 >= currentStart && $0.1 <= currentEnd }
            .sorted { $0.1 < $1.1 }

        return RecoveryDashboard(
            rangeDays: days,
            recoveryScore: current.recoveryScore,
            scoreDelta: InsightDelta(value: Double(current.recoveryScore - previous.recoveryScore)),
            averageUrge: current.averageUrge,
            urgeDelta: InsightDelta(value: current.averageUrge - previous.averageUrge, lowerIsBetter: true),
            erpPracticeCount: current.erpPracticeCount,
            erpDelta: InsightDelta(value: Double(current.erpPracticeCount - previous.erpPracticeCount)),
            consistencyPercent: current.consistencyPercent,
            activeDays: current.activeDays.count,
            consistencyHeatmap: heatmap,
            scoreTrend: scoreTrend,
            moodTrend: moodTrend,
            urgeTrend: urgeTrend,
            erpTrend: erpTrend,
            topThemes: topThemes(journals: current.journalEntries, ocds: current.ocds),
            thoughts: current.ocds.filter { $0.type == .obsession }.count,
            compulsions: current.ocds.filter { $0.type == .compulsion }.count,
            hasAnyData: current.hasAnyData,
            ybocsTrend: ybocs.map { DashboardPoint(date: $0.1, value: Double($0.0.totalScore)) },
            latestYbocs: ybocs.last?.0,
            ybocsDelta: InsightDelta(
                value: ybocs.count < 2 ? 0 : Double(ybocs.last!.0.totalScore - ybocs.first!.0.totalScore),
                lowerIsBetter: true
            )
        )
    }

    // MARK: Themes

    /// `uncategorizedThemeId`: shown as "Other".
    public static let uncategorizedTheme = "uncategorized"

    /// `_themeRules`: English keyword matching, in Flutter's order. Ids are
    /// localized at display time.
    public static let themeRules: [(id: String, keywords: [String])] = [
        ("Contamination", ["contamination", "contaminated", "dirty", "germs", "germ", "wash", "clean", "hygiene", "infect"]),
        ("Harm", ["harm", "hurt", "violent", "attack", "kill", "knife", "danger", "injure"]),
        ("Checking", ["check", "checking", "lock", "stove", "door", "switch", "recheck"]),
        ("Reassurance", ["reassurance", "reassure", "ask again", "asked", "confirm", "certainty"]),
        ("Health", ["health", "illness", "symptom", "disease", "doctor", "cancer", "heart", "medical"]),
        ("Relationship", ["relationship", "partner", "love", "break up", "cheat", "dating", "marriage"]),
        ("Symmetry", ["symmetry", "even", "order", "arrange", "aligned", "just right", "perfect"]),
        ("Moral", ["moral", "religious", "sin", "blasphemy", "guilt", "confess", "wrong person"]),
        ("Rumination", ["ruminate", "rumination", "analyze", "mental review", "figure out", "replay", "solve"]),
        ("Uncertainty", ["uncertain", "uncertainty", "what if", "doubt", "maybe", "not sure", "unknown"]),
    ]

    /// `_topThemes`: the four most frequent themes. Journal text is matched
    /// as stored, as Flutter does.
    static func topThemes(journals: [JournalEntry], ocds: [OcdEntry]) -> [ThemeInsight] {
        var counts: [String: Int] = [:]
        var order: [String] = []
        var categorized = 0, uncategorized = 0
        func classify(_ text: String) {
            let lower = text.lowercased()
            let matches = themeRules.filter { rule in rule.keywords.contains { lower.contains($0) } }.map(\.id)
            if matches.isEmpty { uncategorized += 1; return }
            categorized += 1
            for theme in matches {
                if counts[theme] == nil { order.append(theme) }
                counts[theme, default: 0] += 1
            }
        }
        journals.forEach { classify($0.content) }
        ocds.forEach { classify("\($0.content) \($0.response) \($0.actionTaken ?? "")") }

        if counts.isEmpty && uncategorized > 0 {
            return [ThemeInsight(label: uncategorizedTheme, percent: 1, count: uncategorized)]
        }
        let denominator = Double(max(categorized, 1))
        // Dart's sort is not stable either, but ties keep first-seen order
        // here so the list does not jump between renders.
        return order.enumerated()
            .sorted { lhs, rhs in
                let a = counts[lhs.element]!, b = counts[rhs.element]!
                return a != b ? a > b : lhs.offset < rhs.offset
            }
            .prefix(4)
            .map { ThemeInsight(label: $0.element, percent: Double(counts[$0.element]!) / denominator, count: counts[$0.element]!) }
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

/// `_DashboardPeriodData`: one window's activity and score.
private struct PeriodData {
    var journalEntries: [JournalEntry] = []
    var ocds: [OcdEntry] = []
    var activeDays = Set<String>()
    var erpPracticeCount = 0
    var averageUrge = 0.0
    var consistencyPercent = 0
    var recoveryScore = 0

    var hasAnyData: Bool { !journalEntries.isEmpty || !ocds.isEmpty || erpPracticeCount > 0 }

    /// `mood`: steady when there is nothing to go on.
    var mood: Double {
        if ocds.isEmpty { return journalEntries.isEmpty ? 5 : 6 }
        return min(max(10 - averageUrge, 0), 10)
    }

    init(_ s: ActivitySnapshot, start: Date, end: Date, days: Int, calendar: Calendar) {
        let inRange = { (t: DartTimestamp) -> Bool in
            guard let d = t.date else { return false }
            return d >= start && d <= end
        }
        // Journal days are stored as `yyyy-MM-dd` and parse to local midnight.
        let journals = s.journals.filter { entry in
            guard let d = DartDateTime.parse(entry.date) else { return false }
            return d >= start && d <= end
        }
        let periodOcds = s.ocds.filter { inRange($0.datetime) }
        let delays = s.delaySessions.filter { inRange($0.createdAt) }
        let erp = s.erpSessions.filter { inRange($0.createdAt) }
        let steps = s.completedSteps.filter { inRange($0.completedAt) }
        let responses = s.responsePreventionLogs.filter { inRange($0.createdAt) }
        let surfs = s.urgeSurfSessions.filter { inRange($0.createdAt) }

        var active = Set(journals.map(\.date))
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
        let consistency = min(max(Int((Double(active.count) / Double(days) * 100).dartRounded), 0), 100)
        let journalScore = min(max(Double(journals.count) / Double(days) * 100, 0), 100)
        let erpWindow = (Double(days) / 3).rounded(.up)
        let erpScore = min(max(Double(practice) / erpWindow * 100, 0), 100)
        let urgeScore = urges.isEmpty ? 50 : min(max((10 - averageUrge) / 10 * 100, 0), 100)
        let raw = Double(consistency) * 0.30 + erpScore * 0.30 + urgeScore * 0.25 + journalScore * 0.15

        journalEntries = journals
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
