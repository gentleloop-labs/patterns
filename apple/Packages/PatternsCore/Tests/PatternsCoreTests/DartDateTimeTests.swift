import Foundation
import Testing
@testable import PatternsCore

@Suite("Timestamps match Dart")
struct DartDateTimeTests {
    struct ParseCase: CustomTestStringConvertible {
        let input: String
        let valid: Bool
        let utc: Bool
        let epochMicros: Int64?
        let local: [Int]?
        var testDescription: String { "\"\(input)\"" }
    }

    static func cases() throws -> (parse: [ParseCase], format: [JSONValue]) {
        let root = try Fixtures.json("dates.json").arrayValue![0]
        let parse = root["parse"]!.arrayValue!.map { item in
            ParseCase(
                input: item["input"]!.stringValue!,
                valid: item["valid"] == .bool(true),
                utc: item["utc"] == .bool(true),
                epochMicros: item["epochMicros"]?.intValue,
                local: item["local"]?.arrayValue?.map { Int($0.intValue!) }
            )
        }
        return (parse, root["format"]!.arrayValue!)
    }

    static func localFields(_ date: Date, _ zone: TimeZone) -> [Int] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = zone
        let c = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let totalMicros = Int64((date.timeIntervalSince1970 * 1_000_000).rounded())
        let micros = Int(((totalMicros % 1_000_000) + 1_000_000) % 1_000_000)
        return [c.year!, c.month!, c.day!, c.hour!, c.minute!, c.second!, micros / 1000, micros % 1000]
    }

    static let zones: [TimeZone] = [
        .current,
        TimeZone(identifier: "Asia/Kolkata")!,
        TimeZone(identifier: "America/Los_Angeles")!,
        TimeZone(identifier: "Pacific/Chatham")!,
    ]

    @Test("parses everything Dart's DateTime.parse accepts, and nothing else")
    func parseParity() throws {
        for zone in Self.zones {
            for c in try Self.cases().parse {
                let parsed = DartDateTime.parse(c.input, timeZone: zone)
                #expect((parsed != nil) == c.valid, "\(c.input) validity in \(zone.identifier)")
                guard let parsed else { continue }
                if c.utc {
                    let micros = Int64((parsed.timeIntervalSince1970 * 1_000_000).rounded())
                    #expect(micros == c.epochMicros, "\(c.input)")
                } else {
                    #expect(Self.localFields(parsed, zone) == c.local, "\(c.input) in \(zone.identifier)")
                }
            }
        }
    }

    @Test("formats exactly like toIso8601String")
    func formatParity() throws {
        for zone in Self.zones {
            for item in try Self.cases().format {
                let expected = item["string"]!.stringValue!
                if let micros = item["utcEpochMicros"]?.intValue {
                    let date = Date(timeIntervalSince1970: Double(micros) / 1_000_000)
                    #expect(DartDateTime.format(date, utc: true) == expected)
                } else {
                    let f = item["local"]!.arrayValue!.map { Int($0.intValue!) }
                    var calendar = Calendar(identifier: .gregorian)
                    calendar.timeZone = zone
                    let whole = calendar.date(from: DateComponents(
                        year: f[0], month: f[1], day: f[2], hour: f[3], minute: f[4], second: f[5]
                    ))!
                    let date = whole.addingTimeInterval(Double(f[6] * 1000 + f[7]) / 1_000_000)
                    #expect(DartDateTime.format(date, timeZone: zone) == expected, "in \(zone.identifier)")
                }
            }
        }
    }

    @Test("format then parse keeps the exact microsecond")
    func roundTrip() {
        var generator = SystemRandomNumberGenerator()
        for zone in Self.zones {
            for _ in 0..<2000 {
                // 1990 to 2060, random microsecond.
                let micros = Int64.random(in: 631_152_000_000_000...2_871_763_200_000_000, using: &generator)
                let date = Date(timeIntervalSince1970: Double(micros) / 1_000_000)
                let text = DartDateTime.format(date, timeZone: zone)
                let back = DartDateTime.parse(text, timeZone: zone)!
                // Skip the repeated hour when clocks go back: the wall time is
                // ambiguous there for Dart as well.
                if DartDateTime.format(back, timeZone: zone) != text { continue }
                let backMicros = Int64((back.timeIntervalSince1970 * 1_000_000).rounded())
                if backMicros != micros {
                    #expect(zone.isDaylightSavingTime(for: date) != zone.isDaylightSavingTime(for: back),
                            "\(text) in \(zone.identifier)")
                }
            }
        }
    }

    @Test("DartTimestamp keeps unusual stored text verbatim")
    func timestampPreservesRaw() {
        let raw = "2026-03-01 08:15:04"
        let stamp = DartTimestamp(raw: raw)
        #expect(stamp.raw == raw)
        #expect(stamp.date != nil)
        #expect(DartTimestamp(raw: "garbage").date == nil)
    }
}
