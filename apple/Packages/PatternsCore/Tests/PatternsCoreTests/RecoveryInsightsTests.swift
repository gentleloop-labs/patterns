import Foundation
import Testing
@testable import PatternsCore

@Suite("Today insights match Flutter's AnalyticsService")
struct RecoveryInsightsTests {
    let calendar = Calendar.current
    let now: Date = {
        var c = DateComponents()
        c.year = 2026; c.month = 11; c.day = 9; c.hour = 15
        return Calendar.current.date(from: c)!
    }()

    func daysAgo(_ n: Int, hour: Int = 10) -> DartTimestamp {
        let day = calendar.date(byAdding: .day, value: -n, to: now)!
        return DartTimestamp(calendar.date(bySettingHour: hour, minute: 0, second: 0, of: day)!)
    }

    func delay(_ n: Int, before: Int = 7, after: Int = 4) -> DelaySession {
        DelaySession(compulsion: "check", plannedSeconds: 300, actualSeconds: 300, completed: true, urgeBefore: before, urgeAfter: after,
                     outcome: .resisted, createdAt: daysAgo(n))
    }

    func ocd(_ n: Int, distress: Int) -> OcdEntry {
        OcdEntry(type: .obsession, datetime: daysAgo(n), content: "x", distressLevel: distress, response: "",
                 createdAt: daysAgo(n))
    }

    func journal(_ n: Int) -> JournalEntry {
        let t = daysAgo(n)
        return JournalEntry(date: String(t.raw.prefix(10)), content: "x", createdAt: t, updatedAt: t)
    }

    @Test("next step ladder never hands a free user a Pro step")
    func nextStep() {
        #expect(RecoveryInsights.nextStep(isPro: true, hasYbocs: false, hasHierarchy: false, practicedToday: false) == .selfCheck)
        #expect(RecoveryInsights.nextStep(isPro: true, hasYbocs: true, hasHierarchy: false, practicedToday: false) == .buildHierarchy)
        #expect(RecoveryInsights.nextStep(isPro: false, hasYbocs: true, hasHierarchy: false, practicedToday: false) == .dailyPractice)
        #expect(RecoveryInsights.nextStep(isPro: true, hasYbocs: true, hasHierarchy: true, practicedToday: true) == .reflect)
        #expect(RecoveryInsights.nextStep(isPro: false, hasYbocs: true, hasHierarchy: true, practicedToday: true) == .journal)
    }

    @Test("a score needs three activities over two days")
    func enoughForProgress() {
        var s = ActivitySnapshot(ocds: [ocd(0, distress: 5), ocd(0, distress: 5), ocd(0, distress: 5)])
        #expect(!RecoveryInsights.hasEnoughForProgress(s))
        s.journals = [journal(1)]
        #expect(RecoveryInsights.hasEnoughForProgress(s))
    }

    @Test("streak counts back from today, or from yesterday before practising today")
    func streak() {
        let s = ActivitySnapshot(delaySessions: [delay(0), delay(1), delay(2), delay(4)])
        #expect(RecoveryInsights.metrics(s, now: now).practiceStreakDays == 3)
        let fromYesterday = ActivitySnapshot(delaySessions: [delay(1), delay(2)])
        #expect(RecoveryInsights.metrics(fromYesterday, now: now).practiceStreakDays == 2)
        #expect(RecoveryInsights.metrics(fromYesterday, now: now).weeklyActivity == [false, false, false, false, true, true, false])
    }

    @Test("empty data scores 13, as Dart rounds 12.5 up")
    func emptyScore() {
        let d = RecoveryInsights.dashboard(ActivitySnapshot(), now: now)
        #expect(d.recoveryScore == 13)
        #expect(d.scoreDelta.value == 0)
        #expect(!d.hasAnyData)
    }

    @Test("score formula and delta match Flutter")
    func score() {
        // consistency round(1/30*100)=3, erp 0, urge (10-4)*10=60, journal 3.33
        // 0.9 + 0 + 15 + 0.5 = 16.4 -> 16; the empty previous period is 13.
        let s = ActivitySnapshot(journals: [journal(0)], ocds: [ocd(0, distress: 4)])
        let d = RecoveryInsights.dashboard(s, now: now)
        #expect(d.recoveryScore == 16)
        #expect(d.scoreDelta.value == 3)
        #expect(d.hasAnyData)
        #expect(d.activeDays == 1)
    }

    @Test("calm insights count the last seven calendar days")
    func calm() {
        let s = ActivitySnapshot(journals: [journal(0), journal(7)], ocds: [ocd(6, distress: 3)],
                                 delaySessions: [delay(2), delay(9)])
        let c = RecoveryInsights.calmInsights(s, now: now)
        #expect(c == CalmInsightsSummary(journalCount: 1, trackedMomentCount: 1, delayCount: 1,
                                         erpPracticeCount: 0, exposureCount: 0))
    }

    @Test("a falling lower-is-better measure is a green down arrow, never a green up arrow")
    func deltaArrows() {
        let fallingUrge = InsightDelta(value: -1.5, lowerIsBetter: true)
        #expect(fallingUrge.tone == .positive)
        #expect(fallingUrge.arrow == "↓")
        let risingUrge = InsightDelta(value: 2, lowerIsBetter: true)
        #expect(risingUrge.tone == .negative)
        #expect(risingUrge.arrow == "↑")
        let risingScore = InsightDelta(value: 4)
        #expect(risingScore.tone == .positive)
        #expect(risingScore.arrow == "↑")
        let flat = InsightDelta(value: 0.04)
        #expect(flat.tone == .neutral)
        #expect(flat.arrow == "→")
    }

    @Test("themes count entries by keyword, top four, and fall back to Other")
    func themes() {
        var lock = ocd(0, distress: 5)
        lock.content = "Did I lock the door?"
        var wash = ocd(1, distress: 5)
        wash.content = "My hands feel dirty"
        wash.response = "did not wash"
        var both = ocd(2, distress: 5)
        both.content = "Checking if the stove is dirty"
        let themes = RecoveryInsights.topThemes(journals: [], ocds: [lock, wash, both])
        #expect(themes.map(\.label) == ["Checking", "Contamination"])
        #expect(themes.map(\.count) == [2, 2])
        #expect(themes[0].percent == 2.0 / 3.0)
        let plain = RecoveryInsights.topThemes(journals: [], ocds: [ocd(0, distress: 3)])
        #expect(plain == [ThemeInsight(label: RecoveryInsights.uncategorizedTheme, percent: 1, count: 1)])
        #expect(RecoveryInsights.topThemes(journals: [], ocds: []).isEmpty)
    }

    @Test("the dashboard buckets trends, maps the last 30 days and compares to the previous period")
    func dashboardShape() {
        let s = ActivitySnapshot(ocds: [ocd(0, distress: 4), ocd(40, distress: 8)],
                                 delaySessions: [delay(0), delay(3)])
        let week = RecoveryInsights.dashboard(s, rangeDays: 7, now: now)
        #expect(week.scoreTrend.count == 7)
        #expect(week.consistencyHeatmap.count == 7)
        #expect(week.consistencyHeatmap.last == true)
        let quarter = RecoveryInsights.dashboard(s, rangeDays: 90, now: now)
        #expect(quarter.scoreTrend.count == 7)
        #expect(quarter.consistencyHeatmap.count == 30)
        let month = RecoveryInsights.dashboard(s, rangeDays: 30, now: now)
        // The 8/10 moment falls in the previous 30 days, so urges fell.
        #expect(month.urgeDelta.lowerIsBetter)
        #expect(month.urgeDelta.value < 0)
        #expect(month.urgeDelta.arrow == "↓")
        #expect(month.thoughts == 1)
    }

    @Test("self-check change runs from the first to the latest in range")
    func ybocsTrend() {
        let older = YbocsAssessment(datetime: daysAgo(20), obsessionScore: 12, compulsionScore: 12, totalScore: 24,
                                    severity: .severe, itemScores: [], themes: [], symptoms: [], createdAt: daysAgo(20))
        let newer = YbocsAssessment(datetime: daysAgo(2), obsessionScore: 9, compulsionScore: 9, totalScore: 18,
                                    severity: .moderate, itemScores: [], themes: [], symptoms: [], createdAt: daysAgo(2))
        let d = RecoveryInsights.dashboard(ActivitySnapshot(ybocsAssessments: [newer, older]), rangeDays: 30, now: now)
        #expect(d.ybocsTrend.map(\.value) == [24, 18])
        #expect(d.latestYbocs?.totalScore == 18)
        #expect(d.ybocsDelta.value == -6)
        #expect(d.ybocsDelta.tone == .positive)
        #expect(d.hasYbocsTrend)
    }

    @Test("report ranges keep what Flutter's DateRangeFilter keeps")
    func reportFilter() {
        let snapshot = ActivitySnapshot(journals: [journal(2), journal(40)], ocds: [ocd(1, distress: 6), ocd(10, distress: 2)])
        let week = ReportData(snapshot: snapshot, filter: ReportFilter(range: .seven, now: now))
        #expect(week.journals.count == 1)
        #expect(week.ocds.map(\.distressLevel) == [6])
        let all = ReportData(snapshot: snapshot, filter: ReportFilter(range: .allTime, now: now))
        #expect(all.journals.count == 2)
        #expect(all.averageDistress == 4)
        let start = calendar.date(byAdding: .day, value: -10, to: now)!
        let custom = ReportData(snapshot: snapshot,
                                filter: ReportFilter(range: .custom, customStart: start, customEnd: start, now: now))
        #expect(custom.ocds.map(\.distressLevel) == [2])
        #expect(ReportFilter(range: .custom, customStart: start, customEnd: now, now: now).suggestedFileName(now: now)
            == "patterns_report_2026-10-30_to_2026-11-09.pdf")
    }
}
