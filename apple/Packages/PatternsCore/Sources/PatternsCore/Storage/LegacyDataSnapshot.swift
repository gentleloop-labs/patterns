import Foundation

/// A one-time safety copy of the Flutter app's data, taken on the first
/// native launch before anything opens the database.
///
/// It lives in `Application Support/pre-native-backup/`. It is never
/// exported, never overwritten once taken, and excluded from iCloud device
/// backups (the originals are already backed up). If the native app ever
/// mishandles data, support can restore from this copy.
public enum LegacyDataSnapshot {
    public static let folderName = "pre-native-backup"
    static let manifestName = "manifest.json"

    public struct Manifest: Codable, Equatable, Sendable {
        public var takenAt: String
        public var databaseBytes: Int64?
        public var databaseCompanions: [String]
        public var materials: [Material]

        public struct Material: Codable, Equatable, Sendable {
            public var name: String
            public var bytes: Int64
        }
    }

    public enum Outcome: Equatable, Sendable {
        /// No Flutter data existed (fresh install). Nothing copied.
        case nothingToSnapshot
        /// A snapshot already exists from an earlier launch. Nothing changed.
        case alreadyTaken
        case taken(Manifest)
    }

    /// Takes the snapshot if Flutter data exists and no snapshot was taken.
    /// Must run before ``PatternsDatabase/open(at:)``.
    @discardableResult
    public static func takeIfNeeded(
        supportDirectory: URL,
        fileManager: FileManager = .default,
        now: Date = Date()
    ) throws -> Outcome {
        let destination = supportDirectory.appendingPathComponent(folderName, isDirectory: true)
        if fileManager.fileExists(atPath: destination.appendingPathComponent(manifestName).path) {
            return .alreadyTaken
        }

        let database = supportDirectory.appendingPathComponent(PatternsSchema.databaseFileName)
        let materialsDir = supportDirectory.appendingPathComponent(MaterialFileStore.folderName, isDirectory: true)
        let hasDatabase = fileManager.fileExists(atPath: database.path)
        let materialFiles = (try? fileManager.contentsOfDirectory(
            at: materialsDir, includingPropertiesForKeys: [.fileSizeKey, .isRegularFileKey]
        )) ?? []
        guard hasDatabase || !materialFiles.isEmpty else { return .nothingToSnapshot }

        // Build in a scratch folder and move it into place at the end, so an
        // interrupted launch never leaves a half-written snapshot that looks
        // complete.
        let staging = supportDirectory.appendingPathComponent(folderName + ".partial", isDirectory: true)
        try? fileManager.removeItem(at: staging)
        try fileManager.createDirectory(at: staging, withIntermediateDirectories: true)

        var manifest = Manifest(
            takenAt: DartDateTime.format(now, utc: true),
            databaseBytes: nil,
            databaseCompanions: [],
            materials: []
        )

        if hasDatabase {
            try fileManager.copyItem(at: database, to: staging.appendingPathComponent(PatternsSchema.databaseFileName))
            manifest.databaseBytes = fileSize(database, fileManager)
            // A hot rollback journal or WAL must travel with the file, or the
            // copy would be inconsistent after a crash mid-write.
            for suffix in ["-journal", "-wal", "-shm"] {
                let companion = URL(fileURLWithPath: database.path + suffix)
                if fileManager.fileExists(atPath: companion.path) {
                    try fileManager.copyItem(
                        at: companion,
                        to: staging.appendingPathComponent(PatternsSchema.databaseFileName + suffix)
                    )
                    manifest.databaseCompanions.append(PatternsSchema.databaseFileName + suffix)
                }
            }
        }

        if !materialFiles.isEmpty {
            let stagedMaterials = staging.appendingPathComponent(MaterialFileStore.folderName, isDirectory: true)
            try fileManager.createDirectory(at: stagedMaterials, withIntermediateDirectories: true)
            for file in materialFiles.sorted(by: { $0.lastPathComponent < $1.lastPathComponent }) {
                let isFile = (try? file.resourceValues(forKeys: [.isRegularFileKey]).isRegularFile) ?? false
                guard isFile else { continue }
                try fileManager.copyItem(at: file, to: stagedMaterials.appendingPathComponent(file.lastPathComponent))
                manifest.materials.append(.init(name: file.lastPathComponent, bytes: fileSize(file, fileManager) ?? 0))
            }
        }

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        try encoder.encode(manifest).write(to: staging.appendingPathComponent(manifestName), options: .atomic)

        try? fileManager.removeItem(at: destination)
        try fileManager.moveItem(at: staging, to: destination)

        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        var mutableDestination = destination
        try? mutableDestination.setResourceValues(values)

        return .taken(manifest)
    }

    public static func manifest(supportDirectory: URL) -> Manifest? {
        let url = supportDirectory
            .appendingPathComponent(folderName, isDirectory: true)
            .appendingPathComponent(manifestName)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(Manifest.self, from: data)
    }

    private static func fileSize(_ url: URL, _ fileManager: FileManager) -> Int64? {
        (try? fileManager.attributesOfItem(atPath: url.path)[.size] as? NSNumber)?.int64Value
    }
}
