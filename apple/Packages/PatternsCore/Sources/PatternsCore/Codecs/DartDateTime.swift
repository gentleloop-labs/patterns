import Foundation

/// Reads and writes timestamps exactly the way the Flutter app does.
///
/// Flutter stores every date column with Dart's `DateTime.toIso8601String()`:
/// local wall-clock time, no offset, milliseconds always present and
/// microseconds only when non-zero, e.g. `2026-11-09T14:03:05.120` or
/// `2026-11-09T14:03:05.120045`. A UTC value gets a trailing `Z`.
///
/// Parsing accepts everything Dart's `DateTime.parse` accepts, so any value
/// that Flutter could read (including imported backups) is readable here.
public enum DartDateTime {
    /// Dart's `DateTime.parse` grammar, ported verbatim from the Dart SDK.
    private static let pattern = try! NSRegularExpression(
        pattern: #"^([+-]?\d{4,6})-?(\d\d)-?(\d\d)(?:[ T](\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d+))?)?)?( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$"#
    )

    /// Parses a Dart timestamp. Values without an offset are interpreted in
    /// `timeZone`, which matches Dart treating them as device-local.
    public static func parse(_ string: String, timeZone: TimeZone = .current) -> Date? {
        let range = NSRange(string.startIndex..., in: string)
        guard let match = pattern.firstMatch(in: string, range: range) else { return nil }

        func group(_ index: Int) -> String? {
            let r = match.range(at: index)
            guard r.location != NSNotFound, let swiftRange = Range(r, in: string) else { return nil }
            return String(string[swiftRange])
        }
        func int(_ index: Int) -> Int { group(index).flatMap { Int($0) } ?? 0 }

        guard let year = group(1).flatMap({ Int($0) }) else { return nil }

        // Fraction: the first six digits are milli+micro. Dart truncates
        // anything beyond that (".9999996" reads as 999 ms 999 us).
        var micros = 0
        if let fraction = group(7) {
            let digits = Array(fraction)
            for i in 0..<6 {
                micros = micros * 10 + (i < digits.count ? Int(String(digits[i]))! : 0)
            }
        }

        var zone = timeZone
        if let designator = group(8) {
            if designator.trimmingCharacters(in: .whitespaces).lowercased() == "z" {
                zone = TimeZone(secondsFromGMT: 0)!
            } else {
                let sign = group(9) == "-" ? -1 : 1
                let offset = sign * (int(10) * 3600 + int(11) * 60)
                guard let fixed = TimeZone(secondsFromGMT: offset) else { return nil }
                zone = fixed
            }
        }

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = zone
        var components = DateComponents()
        components.year = year
        components.month = int(2)
        components.day = int(3)
        components.hour = int(4)
        components.minute = int(5)
        components.second = int(6)
        guard let whole = calendar.date(from: components) else { return nil }
        return whole.addingTimeInterval(Double(micros) / 1_000_000)
    }

    /// Formats a date the way Dart's `toIso8601String()` formats a local
    /// `DateTime` (or a UTC one when `utc` is true).
    public static func format(_ date: Date, timeZone: TimeZone = .current, utc: Bool = false) -> String {
        let zone = utc ? TimeZone(secondsFromGMT: 0)! : timeZone
        let totalMicros = Int64((date.timeIntervalSince1970 * 1_000_000).rounded())
        var seconds = totalMicros / 1_000_000
        var micros = totalMicros % 1_000_000
        if micros < 0 { micros += 1_000_000; seconds -= 1 }

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = zone
        let c = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: Date(timeIntervalSince1970: TimeInterval(seconds))
        )
        let year = c.year!
        let yearString: String
        if (0...9999).contains(year) {
            yearString = pad(year, 4)
        } else {
            yearString = (year < 0 ? "-" : "+") + pad(abs(year), 6)
        }
        let ms = Int(micros / 1000)
        let us = Int(micros % 1000)
        var result = "\(yearString)-\(pad(c.month!, 2))-\(pad(c.day!, 2))T"
            + "\(pad(c.hour!, 2)):\(pad(c.minute!, 2)):\(pad(c.second!, 2)).\(pad(ms, 3))"
        if us != 0 { result += pad(us, 3) }
        if utc { result += "Z" }
        return result
    }

    private static func pad(_ value: Int, _ width: Int) -> String {
        let s = String(value)
        return s.count >= width ? s : String(repeating: "0", count: width - s.count) + s
    }
}

/// A timestamp column value that keeps the exact stored text.
///
/// Rows the native app reads but does not change are written back
/// byte-for-byte, so nothing drifts between the Flutter and native builds.
/// New values are formatted with ``DartDateTime/format(_:timeZone:utc:)``.
public struct DartTimestamp: Hashable, Sendable, Codable, CustomStringConvertible {
    public let raw: String

    public init(raw: String) { self.raw = raw }

    public init(_ date: Date, timeZone: TimeZone = .current) {
        raw = DartDateTime.format(date, timeZone: timeZone)
    }

    public static func now() -> DartTimestamp { DartTimestamp(Date()) }

    /// The parsed instant, or nil if the stored text is not a valid Dart date.
    public func date(in timeZone: TimeZone = .current) -> Date? {
        DartDateTime.parse(raw, timeZone: timeZone)
    }

    public var date: Date? { date(in: .current) }

    public var description: String { raw }

    public init(from decoder: Decoder) throws {
        raw = try decoder.singleValueContainer().decode(String.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(raw)
    }
}
