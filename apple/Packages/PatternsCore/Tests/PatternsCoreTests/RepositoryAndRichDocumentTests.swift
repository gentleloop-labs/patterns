import Foundation
import GRDB
import Testing
@testable import PatternsCore

@Suite struct RepositoryTests {
    @Test func journalUpsertKeepsIdAndCreatedAt() throws {
        let db = try PatternsDatabase.inMemory()
        let first = Date(timeIntervalSince1970: 1_700_000_000)
        #expect(try db.saveJournalEntry(date: "2026-11-09", content: "a", now: first))
        #expect(try !db.saveJournalEntry(date: "2026-11-09", content: "b", now: first.addingTimeInterval(60)))
        let rows = try db.queue.read { try JournalEntry.all().fetchAll($0) }
        #expect(rows.count == 1)
        #expect(rows[0].id == 1)
        #expect(rows[0].content == "b")
        #expect(rows[0].createdAt == DartTimestamp(first))
        #expect(rows[0].updatedAt == DartTimestamp(first.addingTimeInterval(60)))
        try db.deleteJournalEntry(date: "2026-11-09")
        #expect(try db.queue.read { try JournalEntry.fetchCount($0) } == 0)
    }

    @Test func dayKeyRoundTrips() throws {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        let date = try #require(calendar.date(from: DateComponents(year: 2026, month: 3, day: 7, hour: 23)))
        #expect(JournalEntry.dayKey(for: date, calendar: calendar) == "2026-03-07")
        let parsed = try #require(JournalEntry.date(forDayKey: "2026-03-07"))
        #expect(calendar.dateComponents([.year, .month, .day, .hour], from: parsed) == DateComponents(year: 2026, month: 3, day: 7, hour: 0))
    }

    @Test func ocdCrudOrdersNewestFirst() throws {
        let db = try PatternsDatabase.inMemory()
        let now = Date()
        let older = OcdEntry(type: .obsession, datetime: DartTimestamp(now.addingTimeInterval(-3600)), content: "old",
                             distressLevel: 3, response: "", createdAt: DartTimestamp(now))
        let newer = OcdEntry(type: .compulsion, datetime: DartTimestamp(now), content: "new",
                             distressLevel: 8, response: "r", actionTaken: "x", createdAt: DartTimestamp(now))
        _ = try db.insertOcdEntry(older)
        var inserted = try db.insertOcdEntry(newer)
        var rows = try db.queue.read { try OcdEntry.all().fetchAll($0) }
        #expect(rows.map(\.content) == ["new", "old"])
        inserted.distressLevel = 2
        try db.updateOcdEntry(inserted)
        try db.deleteOcdEntry(id: try #require(rows.last?.id))
        rows = try db.queue.read { try OcdEntry.all().fetchAll($0) }
        #expect(rows.map(\.distressLevel) == [2])
    }

    @Test func clearAllEmptiesDataButKeepsSchema() throws {
        let db = try PatternsDatabase.inMemory()
        _ = try db.saveJournalEntry(date: "2026-11-09", content: "[]")
        _ = try db.insertOcdEntry(OcdEntry(type: .obsession, datetime: .now(), content: "x", distressLevel: 1,
                                           response: "", createdAt: .now()))
        try db.clearAll()
        let counts = try db.queue.read { db in
            try PatternsSchema.dataTables.map { try Int.fetchOne(db, sql: "SELECT COUNT(*) FROM \($0)") ?? -1 }
        }
        #expect(counts.allSatisfy { $0 == 0 })
        #expect(try db.schemaVersion() == PatternsSchema.currentVersion)
    }

    /// The wipe copy tells people the device forgets the local unlock, so
    /// every `flutter.` key goes, `proUnlocked` included, and nothing else.
    @Test func wipeClearsOnlyFlutterKeys() throws {
        let defaults = try #require(UserDefaults(suiteName: "test.\(UUID())"))
        let prefs = FlutterPreferences(defaults: defaults)
        prefs.set(true, for: PreferenceKey.proUnlocked)
        prefs.set("dark", for: PreferenceKey.appearance)
        defaults.set("x", forKey: "not_flutter")
        prefs.clear()
        #expect(prefs.keys.isEmpty)
        #expect(defaults.string(forKey: "not_flutter") == "x")
    }

    @Test func meaningfulActionCounters() throws {
        let defaults = try #require(UserDefaults(suiteName: "test.\(UUID())"))
        let prefs = FlutterPreferences(defaults: defaults)
        prefs.recordMeaningfulAction(.journal)
        prefs.recordMeaningfulAction(.compulsionDelay)
        prefs.recordReviewJournalSaved()
        #expect(prefs.int(PreferenceKey.meaningfulActionCount) == 2)
        #expect(prefs.string(PreferenceKey.lastMeaningfulAction) == "compulsionDelay")
        #expect(prefs.int(PreferenceKey.ratingJournalCount) == 1)
        #expect(prefs.int(PreferenceKey.ratingMeaningfulActionCount) == 1)
    }
}

@Suite struct RichDocumentTests {
    /// Every stored form must survive load and save unchanged once it is in
    /// Quill's canonical form, including attributes the editor ignores.
    @Test(arguments: [
        #"[{"insert":"Hello "},{"insert":"bold","attributes":{"bold":true}},{"insert":"\n"}]"#,
        #"[{"insert":"one"},{"insert":"\n","attributes":{"list":"bullet"}},{"insert":"two"},{"insert":"\n","attributes":{"list":"bullet"}}]"#,
        #"[{"insert":"link","attributes":{"link":"https://example.com","italic":true}},{"insert":"\nTitle"},{"insert":"\n","attributes":{"header":1}}]"#,
        #"[{"insert":{"image":"x.png"}},{"insert":"after\n"}]"#,
        #"[{"insert":"\n"}]"#,
    ])
    func canonicalRoundTrip(stored: String) {
        #expect(RichDocument(stored: stored).stored == stored)
    }

    @Test func plainTextUpgradesLikeQuill() {
        #expect(RichDocument(stored: "Old note").stored == #"[{"insert":"Old note\n"}]"#)
        #expect(RichDocument(stored: "a\nb").lines.count == 2)
    }

    @Test func emptyDocumentHasOneLine() {
        let document = RichDocument(stored: "")
        #expect(document.lines == [RichDocument.Line()])
        #expect(document.stored == #"[{"insert":"\n"}]"#)
        #expect(document.plainText.isEmpty)
    }

    @Test func settingAttributeKeepsOrder() {
        let attrs: JSONValue? = .object([("bold", .bool(true)), ("link", .string("u"))])
        #expect(attrs.settingAttribute("bold", to: nil) == .object([("link", .string("u"))]))
        #expect(attrs.settingAttribute("italic", to: .bool(true))?.encoded() == #"{"bold":true,"link":"u","italic":true}"#)
        #expect(JSONValue?.none.settingAttribute("list", to: nil) == nil)
    }
}

@Suite struct RichDocumentParityTests {
    /// Opening an entry and saving it unedited writes what Flutter's
    /// `storedFromDocument(documentFromStored(x))` writes, byte for byte.
    @Test func resavedMatchesFlutter() throws {
        let cases = try Fixtures.json("journal-content.json").arrayValue!
        for item in cases {
            let content = item["content"]!.stringValue!
            let expected = try #require(item["resaved"]?.stringValue, "regenerate fixtures")
            #expect(RichDocument(stored: content).stored == expected, "resave of \(content)")
        }
    }
}
