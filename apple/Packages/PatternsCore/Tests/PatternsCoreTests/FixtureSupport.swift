import CryptoKit
import Foundation
@testable import PatternsCore

/// Locations of the fixtures written by `test/native_fixtures_test.dart`.
enum Fixtures {
    static let appleDir = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent() // PatternsCoreTests
        .deletingLastPathComponent() // Tests
        .deletingLastPathComponent() // PatternsCore
        .deletingLastPathComponent() // Packages
        .deletingLastPathComponent() // apple

    static let flutterDir = appleDir.appendingPathComponent("Fixtures/flutter")
    static let swiftOutDir = appleDir.appendingPathComponent("Fixtures/swift-out")

    static func url(_ name: String) -> URL { flutterDir.appendingPathComponent(name) }

    static func data(_ name: String) throws -> Data { try Data(contentsOf: url(name)) }

    static func text(_ name: String) throws -> String {
        try String(contentsOf: url(name), encoding: .utf8)
    }

    static func json(_ name: String) throws -> JSONValue { try JSONValue.parse(data(name)) }

    /// Copies a fixture database into a fresh temp folder so tests never
    /// touch the committed file.
    static func copyDatabase(_ name: String, in dir: TempDir) throws -> URL {
        let destination = dir.url.appendingPathComponent(PatternsSchema.databaseFileName)
        try FileManager.default.copyItem(at: url(name), to: destination)
        return destination
    }
}

final class TempDir {
    let url: URL

    init() throws {
        url = FileManager.default.temporaryDirectory
            .appendingPathComponent("patterns-core-tests-\(UUID().uuidString)", isDirectory: true)
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
    }

    deinit { try? FileManager.default.removeItem(at: url) }
}

func sha256(_ url: URL) throws -> String {
    SHA256.hash(data: try Data(contentsOf: url)).map { String(format: "%02x", $0) }.joined()
}

extension JSONValue {
    /// Replaces or removes a key in an object.
    func setting(_ key: String, to value: JSONValue?) -> JSONValue {
        guard case var .object(pairs) = self else { return self }
        if let index = pairs.firstIndex(where: { $0.0 == key }) {
            if let value { pairs[index].1 = value } else { pairs.remove(at: index) }
        } else if let value {
            pairs.append((key, value))
        }
        return .object(pairs)
    }
}

/// The result string format used by the Dart validation fixture.
func validationResult(_ body: () throws -> Void) -> String {
    do {
        try body()
        return "ok"
    } catch let error as BackupFormatError {
        return "format:\(error.message)"
    } catch {
        return "error:\(type(of: error))"
    }
}
