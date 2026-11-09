import Foundation

/// The app's copy, read straight from Flutter's ARB files (`lib/l10n`), which
/// stay the single source of truth for Android and iOS.
///
/// Lookups fall back the way gen_l10n's class hierarchy does:
/// `pt-BR` → `pt` → `en`, and any other locale → `en`.
public final class StringTable: @unchecked Sendable {
    /// The resolved locale, as a BCP-47 tag (`en`, `pt-BR`, `ja`...).
    public let locale: String

    private let layers: [[String: String]]
    private var cache: [String: [ICUMessage]] = [:]
    private let lock = NSLock()

    public init(locale: String, arbDirectory: URL) throws {
        self.locale = locale
        var files: [String] = []
        switch locale {
        case "pt-BR": files = ["app_pt_BR.arb", "app_pt.arb"]
        case "en": files = []
        default: files = ["app_\(locale).arb"]
        }
        files.append("app_en.arb")
        layers = try files.map { try StringTable.load(arbDirectory.appendingPathComponent($0)) }
    }

    /// Builds from in-memory ARB JSON layers, most specific first (tests).
    public init(locale: String, arbLayers: [Data]) throws {
        self.locale = locale
        layers = try arbLayers.map(StringTable.decode)
    }

    static func load(_ url: URL) throws -> [String: String] {
        try decode(try Data(contentsOf: url))
    }

    static func decode(_ data: Data) throws -> [String: String] {
        guard case let .object(pairs) = try JSONValue.parse(data) else { return [:] }
        var table: [String: String] = [:]
        for (key, value) in pairs where !key.hasPrefix("@") {
            if case let .string(s) = value { table[key] = s }
        }
        return table
    }

    public func source(_ key: String) -> String? {
        for layer in layers {
            if let s = layer[key] { return s }
        }
        return nil
    }

    public var keys: Set<String> {
        layers.reduce(into: Set<String>()) { $0.formUnion($1.keys) }
    }

    /// The formatted message. A missing key returns the key itself, so a gap
    /// is visible in testing rather than silently blank.
    public func string(_ key: String, _ arguments: [String: MessageArgument] = [:]) -> String {
        guard let parts = parsed(key) else { return key }
        return ICUMessage.format(parts, locale: locale, arguments: arguments)
    }

    private func parsed(_ key: String) -> [ICUMessage]? {
        lock.lock()
        defer { lock.unlock() }
        if let hit = cache[key] { return hit }
        guard let source = source(key) else { return nil }
        let parts = (try? ICUMessage.parse(source)) ?? [.text(source)]
        cache[key] = parts
        return parts
    }
}

/// Which language the app shows, matching `lib/l10n/app_language.dart`.
public enum LocaleResolver {
    public static let supported = ["en", "pt-BR", "de", "ja", "es", "fr"]

    /// `resolveSystemLocale`: the first preferred language the app has. Only
    /// Brazilian Portuguese maps to pt-BR; other Portuguese is skipped.
    public static func systemLocale(preferred: [String]) -> String {
        for identifier in preferred {
            let parts = identifier.replacingOccurrences(of: "_", with: "-").split(separator: "-").map(String.init)
            guard let language = parts.first?.lowercased() else { continue }
            let region = parts.dropFirst().first { $0.count == 2 && $0.uppercased() == $0 }
            if language == "pt", region == "BR" { return "pt-BR" }
            if ["en", "de", "ja", "es", "fr"].contains(language) { return language }
        }
        return "en"
    }

    /// `resolveEffectiveLocale`: an explicit choice wins over the system.
    public static func effectiveLocale(language: AppLanguage, preferred: [String] = Locale.preferredLanguages) -> String {
        switch language {
        case .system: return systemLocale(preferred: preferred)
        default: return language.rawValue
        }
    }
}
