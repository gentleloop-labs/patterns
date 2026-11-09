import Foundation
import PatternsCore
import UserNotifications

/// `NotificationService` from `lib/services/notification_service.dart`.
///
/// flutter_local_notifications names iOS requests by their integer id, so
/// the native app uses the same identifiers. Scheduling under an existing
/// identifier replaces the Flutter-made request instead of adding a second
/// one.
enum Reminders {
    static let dailyReminderID = "1001"
    static let releaseAnnouncementID = "1002"
    static let pauseTimerID = "2001"
    static let erpTimerID = "2002"

    static let defaultHour = 20
    static let defaultMinute = 0

    private static var center: UNUserNotificationCenter { .current() }

    /// Asks for permission only when the user turns a reminder on.
    static func requestPermission() async -> Bool {
        (try? await center.requestAuthorization(options: [.alert, .badge, .sound])) ?? false
    }

    /// Replaces the daily reminder with one at `hour:minute` local time,
    /// repeating every day.
    static func scheduleDaily(hour: Int, minute: Int, strings: Strings) async throws {
        center.removePendingNotificationRequests(withIdentifiers: [dailyReminderID])
        let content = UNMutableNotificationContent()
        content.title = strings.dailyReminderTitle
        content.body = strings.dailyReminderBody
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: hour, minute: minute), repeats: true)
        try await center.add(UNNotificationRequest(identifier: dailyReminderID, content: content, trigger: trigger))
    }

    /// `scheduleUpdateAnnouncement`: a one-off note about a new release for
    /// people who already allowed reminders. Never asks for permission.
    static func scheduleReleaseAnnouncement(at date: Date, strings: Strings) async throws {
        guard date > Date() else { return }
        center.removePendingNotificationRequests(withIdentifiers: [releaseAnnouncementID])
        let content = UNMutableNotificationContent()
        content.title = strings.updateAnnouncementTitle
        content.body = strings.updateAnnouncementBody
        content.sound = .default
        let parts = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: parts, repeats: false)
        try await center.add(UNNotificationRequest(identifier: releaseAnnouncementID, content: content, trigger: trigger))
    }

    static func cancelReleaseAnnouncement() {
        center.removePendingNotificationRequests(withIdentifiers: [releaseAnnouncementID])
    }

    /// `main.dart`: an upgraded user who has not opened this release and
    /// already allowed reminders gets one note six hours later.
    static func scheduleReleaseAnnouncementIfNeeded(prefs: FlutterPreferences, strings: Strings) async {
        let hasStarted = prefs.bool(PreferenceKey.hasStarted) ?? false
        let seen = prefs.string(PreferenceKey.lastSeenReleaseId) == AppRelease.currentID
        let scheduled = prefs.string(PreferenceKey.releaseAnnouncementScheduledId) == AppRelease.currentID
        let canNotify = prefs.bool(PreferenceKey.reminderEnabled) ?? false
        guard hasStarted, !seen, !scheduled, canNotify else { return }
        guard (try? await scheduleReleaseAnnouncement(at: Date().addingTimeInterval(6 * 60 * 60), strings: strings)) != nil
        else { return }
        prefs.set(AppRelease.currentID, for: PreferenceKey.releaseAnnouncementScheduledId)
    }

    static func cancelDaily() {
        center.removePendingNotificationRequests(withIdentifiers: [dailyReminderID])
    }

    /// `main.dart` re-arms the saved reminder on every launch, so it survives
    /// updates and picks up the current language. The first native launch
    /// replaces the Flutter-made request the same way.
    static func rescheduleOnLaunch(prefs: FlutterPreferences, strings: Strings) async {
        guard prefs.bool(PreferenceKey.reminderEnabled) == true else { return }
        try? await scheduleDaily(
            hour: prefs.int(PreferenceKey.reminderHour) ?? defaultHour,
            minute: prefs.int(PreferenceKey.reminderMinute) ?? defaultMinute,
            strings: strings
        )
    }
}
