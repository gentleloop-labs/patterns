import Foundation

/// `AnalyticsDateRange` for the report, which adds all time and a custom
/// range to the Insights presets.
public enum ReportRange: String, Sendable, CaseIterable, Hashable {
    case seven, thirty, ninety, year, allTime, custom

    var presetDays: Int? {
        switch self {
        case .seven: 7
        case .thirty: 30
        case .ninety: 90
        case .year: 365
        case .allTime, .custom: nil
        }
    }
}

/// `DateRangeFilter`: a preset keeps what falls after "now minus N days";
/// a custom range keeps whole days from start to end; all time keeps
/// everything.
public struct ReportFilter: Sendable {
    public let cutoffExclusive: Date?
    public let startInclusive: Date?
    public let endInclusive: Date?

    public init(range: ReportRange, customStart: Date? = nil, customEnd: Date? = nil,
                now: Date = Date(), calendar: Calendar = .current) {
        if let days = range.presetDays {
            cutoffExclusive = now.addingTimeInterval(-Double(days) * 86_400)
            startInclusive = nil
            endInclusive = nil
        } else if range == .custom {
            let start = customStart ?? now, end = customEnd ?? now
            cutoffExclusive = nil
            startInclusive = calendar.startOfDay(for: start)
            endInclusive = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: end)!.addingTimeInterval(0.999)
        } else {
            cutoffExclusive = nil
            startInclusive = nil
            endInclusive = nil
        }
    }

    /// `includesOcdDateTime`.
    public func includes(_ date: Date) -> Bool {
        if let cutoffExclusive { return date > cutoffExclusive }
        guard let startInclusive, let endInclusive else { return true }
        return date >= startInclusive && date <= endInclusive
    }

    /// `includesJournalDate`: the stored day, read as local midnight.
    public func includesJournalDay(_ day: String) -> Bool {
        guard let date = DartDateTime.parse(day) else { return false }
        return includes(date)
    }

    /// `displayBounds`: what the report's header says it covers.
    public func displayBounds(now: Date = Date(), calendar: Calendar = .current) -> (start: Date, end: Date) {
        if let cutoffExclusive { return (cutoffExclusive, now) }
        if let startInclusive, let endInclusive { return (startInclusive, calendar.startOfDay(for: endInclusive)) }
        return (calendar.date(from: DateComponents(year: 2000, month: 1, day: 1))!, now)
    }

    /// `suggestedFilename`: `patterns_report_<start>_to_<end>.pdf`.
    public func suggestedFileName(now: Date = Date(), calendar: Calendar = .current) -> String {
        let bounds = displayBounds(now: now, calendar: calendar)
        func day(_ date: Date) -> String {
            let c = calendar.dateComponents([.year, .month, .day], from: date)
            return String(format: "%04d-%02d-%02d", c.year!, c.month!, c.day!)
        }
        return "patterns_report_\(day(bounds.start))_to_\(day(bounds.end)).pdf"
    }
}

/// What a report covers, filtered and in reading order.
public struct ReportData: Sendable {
    /// Oldest first.
    public let journals: [JournalEntry]
    /// Oldest first.
    public let ocds: [OcdEntry]
    /// Oldest first.
    public let ybocs: [YbocsAssessment]

    public init(snapshot: ActivitySnapshot, filter: ReportFilter) {
        journals = snapshot.journals.filter { filter.includesJournalDay($0.date) }.sorted { $0.date < $1.date }
        ocds = snapshot.ocds.filter { $0.datetime.date.map(filter.includes) ?? false }
            .sorted { ($0.datetime.date ?? .distantPast) < ($1.datetime.date ?? .distantPast) }
        ybocs = snapshot.ybocsAssessments.filter { $0.datetime.date.map(filter.includes) ?? false }
            .sorted { ($0.datetime.date ?? .distantPast) < ($1.datetime.date ?? .distantPast) }
    }

    /// `averageDistress` over the tracked moments.
    public var averageDistress: Double {
        ocds.isEmpty ? 0 : Double(ocds.map(\.distressLevel).reduce(0, +)) / Double(ocds.count)
    }

    public var obsessions: Int { ocds.filter { $0.type == .obsession }.count }
    public var compulsions: Int { ocds.filter { $0.type == .compulsion }.count }
}
