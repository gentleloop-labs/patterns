import Foundation
import Testing
@testable import PatternsCore

@Suite("Copy matches Flutter in every language")
struct LocalizationTests {
    static let arbDirectory = Fixtures.appleDir.deletingLastPathComponent().appendingPathComponent("lib/l10n")

    @Test("every message renders exactly as gen_l10n renders it, in all six languages")
    func everyMessageMatches() throws {
        let cases = try Fixtures.json("l10n.json").arrayValue!
        #expect(cases.count > 10_000)

        var tables: [String: StringTable] = [:]
        var mismatches: [String] = []
        for item in cases {
            let locale = item["locale"]!.stringValue!
            let key = item["key"]!.stringValue!
            let expected = item["value"]!.stringValue!
            let table = try tables[locale] ?? StringTable(locale: locale, arbDirectory: Self.arbDirectory)
            tables[locale] = table

            var arguments: [String: MessageArgument] = [:]
            if case let .object(pairs)? = item["args"] {
                for (name, value) in pairs {
                    switch value {
                    case let .int(i): arguments[name] = .int(Int(i))
                    case let .string(s): arguments[name] = .string(s)
                    default: break
                    }
                }
            }
            let actual = table.string(key, arguments)
            if actual != expected {
                mismatches.append("[\(locale)] \(key) \(arguments): Flutter \"\(expected)\" native \"\(actual)\"")
            }
        }
        #expect(mismatches.isEmpty, "\(mismatches.count) mismatches:\n\(mismatches.prefix(15).joined(separator: "\n"))")
    }

    @Test("system language resolves like resolveSystemLocale")
    func systemLocale() {
        #expect(LocaleResolver.systemLocale(preferred: ["pt-BR"]) == "pt-BR")
        #expect(LocaleResolver.systemLocale(preferred: ["pt-PT", "de-DE"]) == "de")
        #expect(LocaleResolver.systemLocale(preferred: ["pt-PT"]) == "en")
        #expect(LocaleResolver.systemLocale(preferred: ["ja-JP"]) == "ja")
        #expect(LocaleResolver.systemLocale(preferred: ["zh-Hans-CN", "fr-CA"]) == "fr")
        #expect(LocaleResolver.systemLocale(preferred: []) == "en")
        #expect(LocaleResolver.effectiveLocale(language: .german, preferred: ["ja"]) == "de")
        #expect(LocaleResolver.effectiveLocale(language: .system, preferred: ["es-MX"]) == "es")
    }

    @Test("CLDR plural categories")
    func pluralRules() {
        #expect(PluralRules.category(for: 0, locale: "fr") == "one")
        #expect(PluralRules.category(for: 0, locale: "en") == "other")
        #expect(PluralRules.category(for: 1, locale: "pt-BR") == "one")
        #expect(PluralRules.category(for: 1_000_000, locale: "es") == "many")
        #expect(PluralRules.category(for: 1, locale: "ja") == "other")
    }
}
