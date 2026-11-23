import Foundation
import PatternsCore

/// The app's copy for the active language. Typed accessors for every ARB
/// message live in `Generated/Strings+Generated.swift`.
final class Strings: Sendable {
    let table: StringTable

    init(table: StringTable) {
        self.table = table
    }

    /// Loads the ARB files bundled with the app.
    static func load(locale: String, bundle: Bundle = .main) -> Strings {
        let directory = bundle.resourceURL ?? bundle.bundleURL
        if let table = try? StringTable(locale: locale, arbDirectory: directory) {
            return Strings(table: table)
        }
        // A missing translation file must never block the app: fall back to
        // English, then to an empty table that shows keys.
        if let english = try? StringTable(locale: "en", arbDirectory: directory) {
            return Strings(table: english)
        }
        return Strings(table: try! StringTable(locale: "en", arbLayers: [Data("{}".utf8)]))
    }

    var localeIdentifier: String { table.locale }

    /// For date and number formatting in the app language.
    var locale: Locale { Locale(identifier: table.locale) }

    func string(_ key: String, _ arguments: [String: MessageArgument] = [:]) -> String {
        table.string(key, arguments)
    }
}
