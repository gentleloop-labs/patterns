import Foundation
import GRDB
import ZIPFoundation

/// Row counts in a backup, shown before restoring. Mirrors `BackupSummary`.
public struct BackupSummary: Equatable, Sendable {
    /// Count per table, keyed by table name. Every data table is present.
    public let counts: [String: Int]

    public func count(_ table: String) -> Int { counts[table] ?? 0 }
    public var journalCount: Int { count("journal") }
    public var ocdCount: Int { count("ocd") }
    public var totalRows: Int { counts.values.reduce(0, +) }
}

/// Full-data export and restore, compatible in both directions with the
/// Flutter app on every platform (`DbHelper.exportAll`, `importAll`,
/// `exportBundle`, `importBundle`).
///
/// - `data.json`: `{"schema_version": 10, "<table>": [rows...], ...}`, rows
///   being the raw column maps.
/// - Bundle: a zip containing `data.json` plus `materials/<file name>` for
///   every stored exposure-material file.
public enum BackupCodec {
    /// Guards against a hostile or corrupt zip expanding without limit.
    public static let maxBundleUncompressedBytes: Int64 = 2 * 1024 * 1024 * 1024

    // MARK: JSON

    public static func exportJSON(_ database: PatternsDatabase) throws -> String {
        try database.queue.read { db in try exportJSON(db) }
    }

    static func exportJSON(_ db: Database) throws -> String {
        var root: [(String, JSONValue)] = [("schema_version", .int(Int64(PatternsSchema.backupSchemaVersion)))]
        for table in PatternsSchema.dataTables {
            let rows = try Row.fetchAll(db, sql: "SELECT * FROM \(table.quotedDatabaseIdentifier)")
            root.append((table, .array(rows.map(jsonRow))))
        }
        return JSONValue.object(root).encoded()
    }

    private static func jsonRow(_ row: Row) -> JSONValue {
        var pairs: [(String, JSONValue)] = []
        for (column, value) in row {
            pairs.append((column, json(value)))
        }
        return .object(pairs)
    }

    private static func json(_ value: DatabaseValue) -> JSONValue {
        switch value.storage {
        case .null: return .null
        case let .int64(i): return .int(i)
        case let .double(d): return .double(d)
        case let .string(s): return .string(s)
        // Dart's jsonEncode writes a Uint8List as a list of byte values.
        case let .blob(data): return .array(data.map { .int(Int64($0)) })
        }
    }

    public static func preview(json text: String) throws -> BackupSummary {
        let data = try BackupValidator.decodeRoot(text)
        try BackupValidator.validate(data)
        var counts: [String: Int] = [:]
        for table in PatternsSchema.dataTables {
            counts[table] = try BackupValidator.list(data, table).count
        }
        return BackupSummary(counts: counts)
    }

    /// Replaces all data with the backup's rows, in one transaction. Nothing
    /// changes if validation or any insert fails.
    public static func importJSON(_ text: String, into database: PatternsDatabase) throws {
        let data = try BackupValidator.decodeRoot(text)
        try BackupValidator.validate(data)
        try database.queue.write { db in
            var columnsByTable: [String: Set<String>] = [:]
            for table in PatternsSchema.dataTables {
                columnsByTable[table] = Set(try db.columns(in: table).map(\.name))
            }
            for table in PatternsSchema.dataTables {
                try db.execute(sql: "DELETE FROM \(table.quotedDatabaseIdentifier)")
            }
            for table in PatternsSchema.dataTables {
                let known = columnsByTable[table] ?? []
                for item in try BackupValidator.list(data, table) {
                    try insert(item, into: table, knownColumns: known, db)
                }
            }
        }
    }

    private static func insert(_ item: JSONValue, into table: String, knownColumns: Set<String>, _ db: Database) throws {
        guard case let .object(pairs) = item else { throw BackupFormatError("Invalid \(table) row") }
        guard !pairs.isEmpty else {
            try db.execute(sql: "INSERT INTO \(table.quotedDatabaseIdentifier) DEFAULT VALUES")
            return
        }
        var columns: [String] = []
        var arguments: [DatabaseValueConvertible?] = []
        for (column, value) in pairs {
            // sqflite would fail on an unknown column too; checking first also
            // keeps backup-supplied names out of the SQL text.
            guard knownColumns.contains(column) else {
                throw BackupFormatError("Unknown column \(column) in \(table)")
            }
            columns.append(column.quotedDatabaseIdentifier)
            switch value {
            case .null: arguments.append(nil)
            case let .bool(b): arguments.append(b ? 1 : 0)
            case let .int(i): arguments.append(i)
            case let .double(d): arguments.append(d)
            case let .string(s): arguments.append(s)
            case .array, .object:
                throw BackupFormatError("Unsupported value for \(column) in \(table)")
            }
        }
        let placeholders = Array(repeating: "?", count: columns.count).joined(separator: ", ")
        try db.execute(
            sql: "INSERT INTO \(table.quotedDatabaseIdentifier) (\(columns.joined(separator: ", "))) VALUES (\(placeholders))",
            arguments: StatementArguments(arguments)
        )
    }

    // MARK: Bundle (zip)

    public static func exportBundle(_ database: PatternsDatabase, materials: MaterialFileStore) throws -> Data {
        let json = try exportJSON(database)
        let archive = try Archive(accessMode: .create)
        try addEntry(archive, path: "data.json", data: Data(json.utf8))
        for file in materials.allFiles() {
            try addEntry(archive, path: "materials/\(file.lastPathComponent)", data: try Data(contentsOf: file))
        }
        guard let data = archive.data else { throw BackupFormatError("Could not create backup archive") }
        return data
    }

    private static func addEntry(_ archive: Archive, path: String, data: Data) throws {
        try archive.addEntry(
            with: path,
            type: .file,
            uncompressedSize: Int64(data.count),
            compressionMethod: .deflate,
            provider: { position, size in
                data.subdata(in: Data.Index(position)..<Data.Index(position) + size)
            }
        )
    }

    struct ExtractedBundle {
        var json: String
        var materials: [(name: String, data: Data)]
    }

    static func extract(_ zip: Data, includeMaterials: Bool) throws -> ExtractedBundle {
        let archive: Archive
        do {
            archive = try Archive(data: zip, accessMode: .read)
        } catch {
            throw BackupFormatError("Backup is not a valid archive")
        }
        var total: Int64 = 0
        func read(_ entry: Entry) throws -> Data {
            total += Int64(clamping: entry.uncompressedSize)
            guard total <= maxBundleUncompressedBytes else { throw BackupFormatError("Backup is too large") }
            var out = Data()
            _ = try archive.extract(entry, skipCRC32: false) { chunk in out.append(chunk) }
            return out
        }

        guard let dataEntry = archive.first(where: { $0.path == "data.json" }) else {
            throw BackupFormatError("Backup is missing data.json")
        }
        guard let json = String(data: try read(dataEntry), encoding: .utf8) else {
            throw BackupFormatError("Backup data.json is not UTF-8")
        }

        var materials: [(String, Data)] = []
        if includeMaterials {
            for entry in archive where entry.type == .file && entry.path.hasPrefix("materials/") {
                let name = String(entry.path.dropFirst("materials/".count))
                // Flutter skips an empty name; native also skips any name that
                // would land outside the materials folder.
                guard MaterialFileStore.isSafeFileName(name) else { continue }
                materials.append((name, try read(entry)))
            }
        }
        return ExtractedBundle(json: json, materials: materials)
    }

    public static func previewBundle(_ zip: Data) throws -> BackupSummary {
        try preview(json: try extract(zip, includeMaterials: false).json)
    }

    /// Restores a bundle: rows first (all-or-nothing), then material files.
    /// Existing material files that are not in the backup are left in place,
    /// as Flutter does.
    public static func importBundle(_ zip: Data, into database: PatternsDatabase, materials: MaterialFileStore) throws {
        let bundle = try extract(zip, includeMaterials: true)
        try importJSON(bundle.json, into: database)
        for file in bundle.materials {
            try materials.write(file.data, named: file.name)
        }
    }
}
