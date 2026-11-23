import PatternsCore
import SwiftUI

/// `FirstRunResultScreen`: the calm close of a new user's first activity.
/// It credits effort, offers an optional reminder (the honest moment to ask
/// for notification permission), and leads into the app.
struct FirstRunResultScreen: View {
    let kind: FirstRunPath
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var reminderSet = false
    @State private var pickingTime = false

    var body: some View {
        let strings = model.strings
        let copy = copy(strings)
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    Image(systemName: copy.icon)
                        .font(.system(size: 34, weight: .medium))
                        .foregroundStyle(AppColors.accent)
                        .frame(width: 80, height: 80)
                        .background(AppColors.accent.opacity(0.15), in: .circle)
                        .accessibilityHidden(true)
                    Text(copy.headline)
                        .font(.custom(AppFont.display, size: 27, relativeTo: .title).weight(.semibold))
                        .foregroundStyle(AppColors.textPrimary)
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)
                        .padding(.top, 26)
                    Text(copy.body)
                        .textRole(.bodyLarge, color: AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 14)
                }
                .frame(maxWidth: .infinity)
                .containerRelativeFrame(.vertical, alignment: .center) { length, _ in length }
            }
            .scrollBounceBehavior(.basedOnSize)

            if !reminderSet {
                Button { pickingTime = true } label: {
                    Label(strings.shellText(key: "setReminder"), systemImage: "bell")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            Button { navigation.returnToNeutralHome() } label: {
                Text(strings.shellText(key: "goToSpace")).frame(maxWidth: .infinity)
            }
            .buttonStyle(.accentProminent)
            .controlSize(.large)
            .padding(.top, 10)
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 20, trailing: 24))
        .background(AppColors.surface)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $pickingTime) {
            ReminderTimePicker(initial: model.reminder.date, title: strings.shellText(key: "reminderPrompt")) { picked in
                pickingTime = false
                if let picked { Task { await setReminder(picked) } }
            }
        }
    }

    private func copy(_ strings: Strings) -> (headline: String, body: String, icon: String) {
        switch kind {
        case .urge: (strings.completionPracticeTitle, strings.completionDelayBody, "hourglass")
        case .journal: (strings.completionSavedTitle, strings.completionTrackedBody, "pencil")
        case .erp: (strings.completionPracticeTitle, strings.completionErpBody, "leaf")
        case .selfcheck: (strings.completionSavedTitle, strings.shellText(key: "firstSelfCheckBody"), "list.clipboard")
        case .explore: (strings.shellText(key: "firstExploreTitle"), strings.shellText(key: "firstExploreBody"), "safari")
        }
    }

    /// `_askReminder`: time first, then permission, then schedule.
    private func setReminder(_ date: Date) async {
        let strings = model.strings
        guard await Reminders.requestPermission() else {
            navigation.showToast(strings.shellText(key: "notificationsOff"), kind: .info)
            return
        }
        let parts = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = parts.hour ?? Reminders.defaultHour, minute = parts.minute ?? Reminders.defaultMinute
        do {
            try await Reminders.scheduleDaily(hour: hour, minute: minute, strings: strings)
            model.setReminderTime(hour: hour, minute: minute)
            model.setReminderEnabled(true)
            reminderSet = true
            navigation.showToast(strings.shellText(key: "reminderSet"), kind: .success)
        } catch {
            Reminders.cancelDaily()
            navigation.showToast(strings.shellText(key: "reminderFailed"), kind: .error)
        }
    }
}
