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
        #expect(d.scoreDelta == 0)
        #expect(!d.hasAnyData)
    }

    @Test("score formula and delta match Flutter")
    func score() {
        // consistency round(1/30*100)=3, erp 0, urge (10-4)*10=60, journal 3.33
        // 0.9 + 0 + 15 + 0.5 = 16.4 -> 16; the empty previous period is 13.
        let s = ActivitySnapshot(journals: [journal(0)], ocds: [ocd(0, distress: 4)])
        let d = RecoveryInsights.dashboard(s, now: now)
        #expect(d.recoveryScore == 16)
        #expect(d.scoreDelta == 3)
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
}
