import Foundation

/// The date helpers from `lib/l10n/l10n.dart`, using CLDR skeletons in the
/// app language as Dart's `intl` does.
struct AppDateFormat {
    let locale: Locale

    private func format(_ date: Date, skeleton: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate(skeleton)
        return formatter.string(from: date)
    }

    /// `formatFullDate`: `yMMMMd`.
    func fullDate(_ date: Date) -> String { format(date, skeleton: "yMMMMd") }
    /// `formatFullDateWithWeekday`: `yMMMEd`.
    func fullDateWithWeekday(_ date: Date) -> String { format(date, skeleton: "yMMMEd") }
    /// `formatMonthDay`: `MMMd`.
    func monthDay(_ date: Date) -> String { format(date, skeleton: "MMMd") }
    /// `formatShortWeekday`: `E`.
    func shortWeekday(_ date: Date) -> String { format(date, skeleton: "E") }
    /// `formatTime`: `jm`.
    func time(_ date: Date) -> String { format(date, skeleton: "jm") }
    /// `formatMonthDayTime`: `MMMd` + `jm`.
    func monthDayTime(_ date: Date) -> String { "\(monthDay(date)) \(time(date))" }

    /// `formatOneDecimal`.
    func oneDecimal(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: value)) ?? String(format: "%.1f", value)
    }

    /// `formatInteger`.
    func integer(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }

    /// `formatWholePercent`: 70 becomes "70%" in the app language.
    func wholePercent(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: Double(value) / 100)) ?? "\(value)%"
    }
}

extension Strings {
    var dates: AppDateFormat { AppDateFormat(locale: locale) }
}
