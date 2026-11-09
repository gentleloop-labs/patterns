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
}

extension Strings {
    var dates: AppDateFormat { AppDateFormat(locale: locale) }
}
