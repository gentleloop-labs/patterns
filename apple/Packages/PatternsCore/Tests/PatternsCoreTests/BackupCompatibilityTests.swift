import Foundation
import GRDB
import Testing
import ZIPFoundation
@testable import PatternsCore

@Suite("Backups are interchangeable with Flutter")
struct BackupCompatibilityTests {
    @Test("accepts and rejects exactly the backups Flutter does, with the same messages")
    func validationParity() throws {
        let fixture = try Fixtures.json("validation-cases.json")
        let base = fixture["base"]!
        let cases = fixture["cases"]!.arrayValue!
        #expect(cases.count > 1000)

        var mismatches: [String] = []
        for item in cases {
            let name = item["name"]!.stringValue!
            let expected = item["result"]!.stringValue!
            let remove = item["remove"] == .bool(true)
            let value = item["value"] ?? .null

            let backup: JSONValue
            if let root = item["root"] {
                backup = root
            } else if let top = item["top"]?.stringValue {
                backup = base.setting(top, to: remove ? nil : value)
            } else {
                let table = item["table"]!.stringValue!
                let column = item["column"]!.stringValue!
                var rows = base[table]!.arrayValue!
                rows[0] = rows[0].setting(column, to: remove ? nil : value)
                backup = base.setting(table, to: .array(rows))
            }

            let actual = validationResult { _ = try BackupCodec.preview(json: backup.encoded()) }
            if actual != expected { mismatches.append("\(name): Flutter \(expected), native \(actual)") }
        }
        #expect(mismatches.isEmpty, "\(mismatches.prefix(20).joined(separator: "\n"))")
    }

    @Test("a Flutter data.json restores into native with every row intact")
    func importFlutterJSON() throws {
        let database = try PatternsDatabase.inMemory()
        let text = try Fixtures.text("v10-backup.json")
        let summary = try BackupCodec.preview(json: text)
        #expect(summary.journalCount == 4)
        #expect(summary.count("exposure_materials") == 4)

        try BackupCodec.importJSON(text, into: database)
        #expect(try BackupCodec.exportJSON(database) == Fixtures.text("v10.expected.json"))

        // Restoring twice replaces rather than duplicates.
        try BackupCodec.importJSON(text, into: database)
        #expect(try BackupCodec.exportJSON(database) == Fixtures.text("v10.expected.json"))
    }

    @Test("a Flutter zip bundle restores rows and material files")
    func importFlutterBundle() throws {
        let dir = try TempDir()
        let database = try PatternsDatabase.inMemory()
        let store = MaterialFileStore(supportDirectory: dir.url)
        let zip = try Fixtures.data("v10-backup.zip")

        #expect(try BackupCodec.previewBundle(zip).journalCount == 4)
        try BackupCodec.importBundle(zip, into: database, materials: store)

        #expect(try BackupCodec.exportJSON(database) == Fixtures.text("v10.expected.json"))
        let names = store.allFiles().map(\.lastPathComponent)
        #expect(names == ["m_1772352904120045.m4a", "m_1772352904999999.jpg"])
        let tape = try Data(contentsOf: store.resolve("m_1772352904120045.m4a")!)
        #expect(tape == Data((0..<4096).map { UInt8(($0 * 31) % 256) }))
    }

    @Test("a native bundle restores into a clean native install")
    func nativeBundleRoundTrip() throws {
        let sourceDir = try TempDir()
        let source = try PatternsDatabase.inMemory()
        let sourceStore = MaterialFileStore(supportDirectory: sourceDir.url)
        try BackupCodec.importBundle(try Fixtures.data("v10-backup.zip"), into: source, materials: sourceStore)

        let zip = try BackupCodec.exportBundle(source, materials: sourceStore)

        let targetDir = try TempDir()
        let target = try PatternsDatabase.inMemory()
        let targetStore = MaterialFileStore(supportDirectory: targetDir.url)
        try BackupCodec.importBundle(zip, into: target, materials: targetStore)

        #expect(try BackupCodec.exportJSON(target) == BackupCodec.exportJSON(source))
        #expect(targetStore.allFiles().map(\.lastPathComponent) == sourceStore.allFiles().map(\.lastPathComponent))
    }

    @Test("a rejected restore leaves existing data untouched")
    func failedImportIsAtomic() throws {
        let database = try PatternsDatabase.inMemory()
        try BackupCodec.importJSON(try Fixtures.text("v10-backup.json"), into: database)
        let before = try BackupCodec.exportJSON(database)

        // Passes validation (ids are not validated) but fails on insert.
        let base = try Fixtures.json("v10-backup.json")
        var rows = base["ocd"]!.arrayValue!
        rows.append(rows[0]) // duplicate primary key
        let bad = base.setting("ocd", to: .array(rows)).encoded()
        #expect(throws: (any Error).self) { try BackupCodec.importJSON(bad, into: database) }
        #expect(try BackupCodec.exportJSON(database) == before)

        let unknownColumn = base.setting("journal", to: .array([
            base["journal"]!.arrayValue![0].setting("extra; DROP TABLE ocd", to: .int(1)),
        ])).encoded()
        #expect(throws: BackupFormatError.self) { try BackupCodec.importJSON(unknownColumn, into: database) }
        #expect(try BackupCodec.exportJSON(database) == before)
    }

    @Test("material names that would escape the folder are never written")
    func unsafeMaterialNamesSkipped() throws {
        let dir = try TempDir()
        let archive = try Archive(accessMode: .create)
        func add(_ path: String, _ data: Data) throws {
            try archive.addEntry(with: path, type: .file, uncompressedSize: Int64(data.count),
                                 provider: { position, size in data.subdata(in: Int(position)..<Int(position) + size) })
        }
        try add("data.json", Data(try Fixtures.text("v10-backup.json").utf8))
        try add("materials/../escaped.txt", Data("x".utf8))
        try add("materials/nested/inner.txt", Data("x".utf8))
        try add("materials/ok.m4a", Data("ok".utf8))

        let database = try PatternsDatabase.inMemory()
        let store = MaterialFileStore(supportDirectory: dir.url.appendingPathComponent("support"))
        try BackupCodec.importBundle(archive.data!, into: database, materials: store)

        #expect(store.allFiles().map(\.lastPathComponent) == ["ok.m4a"])
        #expect(!FileManager.default.fileExists(atPath: dir.url.appendingPathComponent("support/escaped.txt").path))
    }

    @Test("a zip without data.json is refused with Flutter's message")
    func missingDataJSON() throws {
        let archive = try Archive(accessMode: .create)
        let data = Data("x".utf8)
        try archive.addEntry(with: "other.txt", type: .file, uncompressedSize: Int64(data.count),
                             provider: { _, _ in data })
        #expect(throws: BackupFormatError("Backup is missing data.json")) {
            _ = try BackupCodec.previewBundle(archive.data!)
        }
    }
}
