import Foundation
import Testing
@testable import PatternsCore

@Suite("Journal rich text matches Flutter")
struct JournalContentTests {
    @Test("plain text and styled runs match rich_journal.dart for every case")
    func parity() throws {
        let cases = try Fixtures.json("journal-content.json").arrayValue!
        #expect(!cases.isEmpty)
        for item in cases {
            let content = item["content"]!.stringValue!
            let body = JournalContent(stored: content)
            #expect(body.plainText == item["plainText"]!.stringValue!, "plainText of \(content)")
            let expectedRuns = item["runs"]!.arrayValue!.map {
                RichRun($0["text"]!.stringValue!, bold: $0["bold"] == .bool(true), italic: $0["italic"] == .bool(true))
            }
            #expect(body.richRuns == expectedRuns, "runs of \(content)")
        }
    }

    @Test("re-saving an unedited Delta keeps every op and attribute")
    func preservesUnknownAttributes() throws {
        let cases = try Fixtures.json("journal-content.json").arrayValue!
        let rich = cases[0]["content"]!.stringValue!
        let body = JournalContent(stored: rich)
        guard case .delta = body else {
            Issue.record("Expected a Delta")
            return
        }
        #expect(try JSONValue.parse(body.stored) == JSONValue.parse(rich))
        #expect(body.stored.contains("\"header\":2"))
    }

    @Test("a Delta missing its closing newline reads as release Flutter reads it")
    func missingClosingNewline() {
        // Quill only asserts on this (debug builds). Shipped Flutter loads
        // the ops, so native does too instead of showing raw JSON.
        let body = JournalContent(stored: #"[{"insert":"no newline"}]"#)
        #expect(body.plainText == "no newline")
        #expect(body.richRuns == [RichRun("no newline")])
        #expect(body.stored == #"[{"insert":"no newline\n"}]"#)
    }

    @Test("legacy plain text upgrades to a Delta ending in a newline")
    func legacyUpgrade() throws {
        let body = JournalContent(stored: "Old note")
        #expect(body == .plain("Old note"))
        let stored = body.stored
        #expect(stored == #"[{"insert":"Old note\n"}]"#)
        #expect(JournalContent(stored: stored).plainText == "Old note")
    }
}
