import Foundation

/// Exposure-material binaries (loop-tape audio, images), stored exactly as
/// the Flutter app stores them (`lib/services/material_file_store.dart`):
/// files in `<Application Support>/materials/`, with only the relative file
/// name in the database. Names are resolved at use time because the app
/// container path changes between installs.
public struct MaterialFileStore: Sendable {
    public static let folderName = "materials"

    public let directory: URL

    public init(supportDirectory: URL) {
        directory = supportDirectory.appendingPathComponent(Self.folderName, isDirectory: true)
    }

    public struct InvalidFileName: Error, Equatable {
        public let name: String
    }

    /// A stored name must be a plain file name. Backups come from outside
    /// the app, so anything with a path separator or `..` is rejected rather
    /// than written outside the materials folder.
    public static func isSafeFileName(_ name: String) -> Bool {
        !name.isEmpty
            && name != "." && name != ".."
            && !name.contains("/") && !name.contains("\\")
            && !name.contains("\0")
    }

    @discardableResult
    func ensureDirectory(_ fileManager: FileManager = .default) throws -> URL {
        try fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
        return directory
    }

    /// Same naming as Flutter: `m_<microseconds since epoch>.<ext>`.
    public static func generatedName(extension ext: String, now: Date = Date()) -> String {
        let micros = Int64((now.timeIntervalSince1970 * 1_000_000).rounded())
        let cleanExt = ext.hasPrefix(".") ? String(ext.dropFirst()) : ext
        return "m_\(micros).\(cleanExt)"
    }

    /// Copies `source` into the store and returns the relative name to save
    /// in the database.
    public func save(copying source: URL, extension ext: String, fileManager: FileManager = .default) throws -> String {
        try ensureDirectory(fileManager)
        let base = Date()
        var offset = 0.0
        var name = Self.generatedName(extension: ext, now: base)
        while fileManager.fileExists(atPath: directory.appendingPathComponent(name).path) {
            offset += 0.000001
            name = Self.generatedName(extension: ext, now: base.addingTimeInterval(offset))
        }
        try fileManager.copyItem(at: source, to: directory.appendingPathComponent(name))
        return name
    }

    /// Writes raw bytes under a stored name (used when restoring a backup).
    public func write(_ data: Data, named name: String, fileManager: FileManager = .default) throws {
        guard Self.isSafeFileName(name) else { throw InvalidFileName(name: name) }
        try ensureDirectory(fileManager)
        try data.write(to: directory.appendingPathComponent(name), options: .atomic)
    }

    /// The file for a stored name. It may not exist (for example after a
    /// metadata-only restore), so callers check before use.
    public func resolve(_ name: String) -> URL? {
        guard Self.isSafeFileName(name) else { return nil }
        return directory.appendingPathComponent(name)
    }

    public func delete(_ name: String, fileManager: FileManager = .default) throws {
        guard let url = resolve(name), fileManager.fileExists(atPath: url.path) else { return }
        try fileManager.removeItem(at: url)
    }

    /// Every stored file, sorted by name.
    public func allFiles(fileManager: FileManager = .default) -> [URL] {
        let items = (try? fileManager.contentsOfDirectory(
            at: directory, includingPropertiesForKeys: [.isRegularFileKey]
        )) ?? []
        return items
            .filter { (try? $0.resourceValues(forKeys: [.isRegularFileKey]).isRegularFile) ?? false }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }
    }

    /// Removes every stored file ("Wipe all data").
    public func deleteAll(fileManager: FileManager = .default) throws {
        if fileManager.fileExists(atPath: directory.path) {
            try fileManager.removeItem(at: directory)
        }
    }
}
