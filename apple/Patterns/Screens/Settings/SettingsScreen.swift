import LocalAuthentication
import PatternsCore
import StoreKit
import SwiftUI
import UniformTypeIdentifiers

/// `SettingsScreen` from `lib/mobile/screens/settings_screen.dart`.
struct SettingsScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.openURL) private var openURL

    @State private var panel: SettingsPanel?
    @State private var exportDocument: BackupDocument?
    @State private var exporting = false
    @State private var importing = false
    @State private var pickingTime = false
    @State private var redeeming = false
    /// Offer-code redemptions report nothing back; the unlock arrives later
    /// as a transaction. Flutter listened for 10 minutes.
    @State private var redeemWatchUntil: Date?

    var body: some View {
        let strings = model.strings
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header(strings)
                    .padding(.bottom, 22)

                section(strings.appearanceTitle)
                AppearancePicker(value: model.appearance) { model.setAppearance($0) }
                SettingsItem(icon: "character.bubble", title: strings.languageTitle,
                             subtitle: model.language == .system ? strings.systemDefault : model.language.nativeName) {
                    panel = .language
                }
                .padding(.top, 12)
                SettingsSwitchItem(icon: "leaf", title: strings.calmInsightsTitle, subtitle: strings.calmInsightsSubtitle,
                                   value: model.calmInsightsEnabled) { model.setCalmInsights($0) }
                    .padding(.top, 10)

                section(strings.settingsDataSection).padding(.top, 28)
                SettingsItem(icon: "arrow.down.circle", title: strings.settingsExportDataTitle,
                             subtitle: strings.settingsExportDataSubtitle) { panel = .export }
                // The PDF report row arrives with the Insights port.
                SettingsItem(icon: "arrow.up.circle", title: strings.settingsImportDataTitle,
                             subtitle: strings.settingsImportDataSubtitle) { panel = .importPrompt }
                    .padding(.top, 10)

                section(strings.settingsRemindersSection).padding(.top, 28)
                SettingsSwitchItem(
                    icon: "bell", title: strings.settingsDailyReminderTitle,
                    subtitle: model.reminder.enabled
                        ? strings.settingsDailyReminderAt(time: strings.dates.time(model.reminder.date))
                        : strings.settingsDailyReminderOff,
                    value: model.reminder.enabled
                ) { enabled in Task { await setReminderEnabled(enabled) } }
                if model.reminder.enabled {
                    SettingsItem(icon: "clock", title: strings.settingsReminderTimeTitle,
                                 subtitle: strings.dates.time(model.reminder.date)) { pickingTime = true }
                        .padding(.top, 10)
                }

                section(strings.settingsPrivacySection).padding(.top, 28)
                SettingsItem(icon: "lock", title: strings.privacySafetyTitle,
                             subtitle: strings.settingsPrivacySafetySubtitle) { panel = .privacy }
                SettingsSwitchItem(icon: "chart.bar", title: strings.settingsAnalyticsTitle,
                                   subtitle: strings.settingsAnalyticsSubtitle,
                                   value: model.usageAnalyticsEnabled) { model.setUsageAnalytics($0) }
                    .padding(.top, 10)
                SettingsSwitchItem(icon: "person.badge.key", title: strings.settingsAppLockTitle,
                                   subtitle: strings.settingsAppLockSubtitle,
                                   value: model.appLockEnabled) { enabled in Task { await setAppLock(enabled) } }
                    .padding(.top, 10)
                SettingsItem(icon: "trash", title: strings.settingsWipeTitle,
                             subtitle: strings.settingsWipeSubtitle) { panel = .wipe }
                    .padding(.top, 10)

                section(strings.settingsProSection).padding(.top, 28)
                if model.proUnlocked {
                    SettingsItem(icon: "checkmark.circle", title: strings.settingsProActiveTitle,
                                 subtitle: strings.settingsProActiveSubtitle) {
                        navigation.showToast(strings.settingsText(key: "proActiveMessage"), kind: .success)
                    }
                } else {
                    SettingsItem(icon: "lock.open", title: strings.settingsUnlockProTitle,
                                 subtitle: strings.settingsUnlockProSubtitle) { panel = .paywall }
                    SettingsItem(icon: "gift", title: strings.settingsRedeemCodeTitle,
                                 subtitle: strings.settingsRedeemCodeSubtitle) {
                        redeemWatchUntil = Date().addingTimeInterval(10 * 60)
                        redeeming = true
                    }
                        .padding(.top, 10)
                }
                SettingsItem(icon: "arrow.triangle.2.circlepath", title: strings.settingsRestorePurchasesTitle,
                             subtitle: strings.settingsRestorePurchasesSubtitle) { Task { await restorePurchases() } }
                    .padding(.top, 10)

                section(strings.settingsHelpSection).padding(.top, 28)
                SettingsItem(icon: "safari", title: strings.settingsReplayTourTitle,
                             subtitle: strings.settingsReplayTourSubtitle) {
                    // The tour itself arrives with the onboarding port.
                    model.prefs.set(false, for: PreferenceKey.tabTourSeen)
                    navigation.pop()
                }
                SettingsItem(icon: "lightbulb", title: strings.settingsShowWelcomeTitle,
                             subtitle: strings.settingsShowWelcomeSubtitle) {
                    // Next launch, as in Flutter: the current session carries on.
                    model.prefs.set(false, for: PreferenceKey.hasStarted)
                    navigation.showToast(strings.settingsText(key: "welcomeScheduled"), kind: .info)
                }
                .padding(.top, 10)

                section(strings.settingsFeedbackSection).padding(.top, 28)
                SettingsItem(icon: "star", title: strings.settingsRateTitle, subtitle: strings.settingsRateSubtitle) {
                    openStoreReview()
                }
                SettingsItem(icon: "envelope", title: strings.settingsSendFeedbackTitle,
                             subtitle: strings.settingsSendFeedbackSubtitle) { sendFeedback() }
                    .padding(.top, 10)
                SettingsItem(icon: "heart", title: strings.settingsSupportTitle, subtitle: strings.settingsSupportSubtitle) {
                    panel = .tipJar
                }
                    .padding(.top, 10)

                Text("\(strings.settingsVersionLabel) \(Self.versionText)")
                    .textRole(.bodySmall, color: AppColors.textSecondary)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 28)
            }
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 28, trailing: 20))
        }
        // Content stops at the status bar, as Flutter's SafeArea does.
        .clipped()
        .background(AppColors.surface)
        .toolbar(.hidden, for: .navigationBar)
        .bottomPanel(item: $panel) { panel in panelContent(panel) }
        .sheet(isPresented: $pickingTime) {
            ReminderTimePicker(initial: model.reminder.date) { picked in
                pickingTime = false
                if let picked { Task { await setReminderTime(picked) } }
            }
        }
        .fileExporter(isPresented: $exporting, document: exportDocument, contentType: .zip,
                      defaultFilename: "patterns_backup.zip") { result in
            exportDocument = nil
            switch result {
            case .success: navigation.showToast(strings.settingsText(key: "exportSucceeded"), kind: .success)
            case let .failure(error):
                if (error as? CocoaError)?.code != .userCancelled {
                    navigation.showToast(strings.settingsText(key: "exportFailed"), kind: .error)
                }
            }
        }
        .fileImporter(isPresented: $importing, allowedContentTypes: [.zip, .json]) { result in
            if case let .success(url) = result { Task { await readBackup(url) } }
        }
        .offerCodeRedemption(isPresented: $redeeming) { result in
            if case .failure = result {
                redeemWatchUntil = nil
                navigation.showToast(strings.settingsRedeemCodeFailed, kind: .error)
            }
        }
        .onChange(of: model.store.backgroundUnlockCount) {
            guard let until = redeemWatchUntil, Date() < until, model.proUnlocked else { return }
            redeemWatchUntil = nil
            navigation.showToast(strings.proPaywallUnlockedBody, kind: .success)
        }
    }

    // MARK: Layout

    private func header(_ strings: Strings) -> some View {
        HStack(spacing: 4) {
            Button { navigation.pop() } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(AppColors.textPrimary)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel(strings.backAction)
            Text(strings.settingsTitle)
                .font(.custom(AppFont.sans, size: 28, relativeTo: .title).weight(.heavy))
                .tracking(-0.5)
                .foregroundStyle(AppColors.textPrimary)
                .accessibilityAddTraits(.isHeader)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func section(_ title: String) -> some View {
        Text(title)
            .textRole(.titleMedium, weight: .heavy, color: AppColors.textPrimary)
            .accessibilityAddTraits(.isHeader)
            .padding(.bottom, 12)
    }

    @ViewBuilder
    private func panelContent(_ panel: SettingsPanel) -> some View {
        let strings = model.strings
        switch panel {
        case .paywall:
            PaywallSheet(entryPoint: .settings)
        case .tipJar:
            TipJarSheet()
        case .language:
            LanguagePanel(current: model.language) { language in
                self.panel = nil
                model.setLanguage(language)
                if model.reminder.enabled {
                    let reminder = model.reminder, strings = model.strings
                    Task { try? await Reminders.scheduleDaily(hour: reminder.hour, minute: reminder.minute, strings: strings) }
                }
            }
        case .export:
            PanelBody(title: strings.settingsText(key: "exportPromptTitle"), message: strings.settingsText(key: "exportPromptBody")) {
                Button(strings.settingsText(key: "exportBackupAction")) {
                    self.panel = nil
                    Task { await prepareExport() }
                }
                .buttonStyle(PrimaryButtonStyle(fullWidth: true))
            }
        case .importPrompt:
            PanelBody(title: strings.settingsText(key: "importPromptTitle"), message: strings.settingsText(key: "importPromptBody")) {
                Button(strings.settingsText(key: "chooseBackupAction")) {
                    self.panel = nil
                    importing = true
                }
                .buttonStyle(PrimaryButtonStyle(fullWidth: true))
            }
        case let .importPreview(backup):
            PanelBody(title: strings.settingsText(key: "importPreviewTitle"), message: strings.settingsText(key: "importPreviewIntro")) {
                BackupCountList(lines: backup.summary.lines(strings))
                    .padding(.bottom, 8)
                PanelActions(secondaryTitle: strings.cancelAction, primaryTitle: strings.settingsText(key: "replaceAction"),
                             onSecondary: { self.panel = nil },
                             onPrimary: {
                                 self.panel = nil
                                 Task { await restore(backup) }
                             })
            }
        case .wipe:
            PanelBody(title: strings.settingsText(key: "wipePromptTitle"), message: strings.settingsText(key: "wipePromptBody")) {
                PanelActions(secondaryTitle: strings.cancelAction, primaryTitle: strings.settingsText(key: "wipeAction"),
                             onSecondary: { self.panel = nil },
                             onPrimary: {
                                 self.panel = nil
                                 Task { await wipe() }
                             })
            }
        case .privacy:
            PrivacyPanel {
                openPrivacyPolicy()
            }
        }
    }

    // MARK: Backup

    private func prepareExport() async {
        let database = model.database, materials = model.materials
        do {
            let data = try await Task.detached(priority: .userInitiated) {
                try BackupCodec.exportBundle(database, materials: materials)
            }.value
            exportDocument = BackupDocument(data: data)
            exporting = true
        } catch {
            navigation.showToast(model.strings.settingsText(key: "exportFailed"), kind: .error)
        }
    }

    private func readBackup(_ url: URL) async {
        let strings = model.strings
        let scoped = url.startAccessingSecurityScopedResource()
        defer { if scoped { url.stopAccessingSecurityScopedResource() } }
        guard let data = try? Data(contentsOf: url) else {
            navigation.showToast(strings.settingsText(key: "backupUnreadable"), kind: .error)
            return
        }
        let isZip = url.pathExtension.lowercased() == "zip"
        do {
            let summary = try await Task.detached(priority: .userInitiated) {
                if isZip { return try BackupCodec.previewBundle(data) }
                guard let text = String(data: data, encoding: .utf8) else { throw BackupFormatError("Backup is not UTF-8 text.") }
                return try BackupCodec.preview(json: text)
            }.value
            panel = .importPreview(PendingBackup(data: data, isZip: isZip, summary: summary))
        } catch is BackupFormatError {
            navigation.showToast(strings.settingsText(key: "backupInvalid"), kind: .error)
        } catch {
            navigation.showToast(strings.settingsText(key: "importFailed"), kind: .error)
        }
    }

    /// `_restorePurchases`: says what actually happened, not just that a
    /// restore started.
    private func restorePurchases() async {
        let strings = model.strings
        navigation.showToast(strings.proRestoreChecking, kind: .info)
        switch await model.store.restore() {
        case .restored: navigation.showToast(strings.proRestoreSucceeded, kind: .success)
        case .notFound: navigation.showToast(strings.proPaywallRestoreNotFound, kind: .info)
        case .failed: navigation.showToast(strings.proPaywallRestoreFailed, kind: .error)
        case .cancelled: navigation.dismissToast()
        }
    }

    private func restore(_ backup: PendingBackup) async {
        let strings = model.strings
        let database = model.database, materials = model.materials
        do {
            try await Task.detached(priority: .userInitiated) {
                if backup.isZip {
                    try BackupCodec.importBundle(backup.data, into: database, materials: materials)
                } else {
                    guard let text = String(data: backup.data, encoding: .utf8) else { throw BackupFormatError("Backup is not UTF-8 text.") }
                    try BackupCodec.importJSON(text, into: database)
                }
            }.value
            model.dataDidChange()
            navigation.showToast(strings.settingsText(key: "importSucceeded"), kind: .success)
        } catch is BackupFormatError {
            navigation.showToast(strings.settingsText(key: "backupInvalid"), kind: .error)
        } catch {
            navigation.showToast(strings.settingsText(key: "importFailed"), kind: .error)
        }
    }

    private func wipe() async {
        let strings = model.strings
        do {
            try await model.wipeAllData()
            navigation.showToast(strings.settingsText(key: "wipeSucceeded"), kind: .success)
        } catch {
            navigation.showToast(strings.settingsText(key: "wipeFailed"), kind: .error)
        }
    }

    // MARK: Reminders

    private func setReminderEnabled(_ enabled: Bool) async {
        let strings = model.strings
        guard enabled else {
            Reminders.cancelDaily()
            model.setReminderEnabled(false)
            navigation.showToast(strings.settingsText(key: "reminderOff"), kind: .success)
            return
        }
        guard await Reminders.requestPermission() else {
            navigation.showToast(strings.settingsText(key: "notificationsUnavailable"), kind: .info)
            return
        }
        do {
            try await Reminders.scheduleDaily(hour: model.reminder.hour, minute: model.reminder.minute, strings: strings)
            model.setReminderEnabled(true)
            navigation.showToast(strings.settingsText(key: "reminderOn"), kind: .success)
        } catch {
            Reminders.cancelDaily()
            navigation.showToast(strings.settingsText(key: "reminderChangeFailed"), kind: .error)
        }
    }

    private func setReminderTime(_ date: Date) async {
        let strings = model.strings
        let parts = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = parts.hour ?? Reminders.defaultHour, minute = parts.minute ?? Reminders.defaultMinute
        let previous = model.reminder
        do {
            if previous.enabled {
                try await Reminders.scheduleDaily(hour: hour, minute: minute, strings: strings)
            }
            model.setReminderTime(hour: hour, minute: minute)
            navigation.showToast(strings.settingsReminderSetFor(time: strings.dates.time(model.reminder.date)), kind: .success)
        } catch {
            if previous.enabled {
                try? await Reminders.scheduleDaily(hour: previous.hour, minute: previous.minute, strings: strings)
            }
            navigation.showToast(strings.settingsText(key: "reminderChangeFailed"), kind: .error)
        }
    }

    // MARK: App lock

    private func setAppLock(_ enabled: Bool) async {
        let strings = model.strings
        guard enabled else {
            model.setAppLockEnabled(false)
            navigation.showToast(strings.settingsText(key: "appLockDisabled"), kind: .success)
            return
        }
        let context = LAContext()
        var supportError: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &supportError) else {
            navigation.showToast(strings.settingsText(key: "deviceLockUnavailable"), kind: .error)
            return
        }
        do {
            guard try await context.evaluatePolicy(.deviceOwnerAuthentication,
                                                   localizedReason: strings.settingsText(key: "appLockReason")) else { return }
            model.setAppLockEnabled(true)
            navigation.showToast(strings.settingsText(key: "appLockEnabled"), kind: .success)
        } catch let error as LAError {
            switch error.code {
            case .userCancel, .systemCancel, .appCancel, .userFallback, .notInteractive:
                break // The toggle simply stays off.
            case .biometryLockout:
                navigation.showToast(strings.settingsText(key: "appLockBiometricLockout"), kind: .error)
            case .passcodeNotSet, .biometryNotEnrolled, .biometryNotAvailable:
                navigation.showToast(strings.settingsText(key: "deviceLockUnavailable"), kind: .error)
            default:
                navigation.showToast(strings.settingsText(key: "appLockEnableFailed"), kind: .error)
            }
        } catch {
            navigation.showToast(strings.settingsText(key: "appLockEnableFailed"), kind: .error)
        }
    }

    // MARK: Links

    private static let appStoreID = "6762611172"
    private static let supportEmail = "aftaab@aftaab.dev"

    private func openStoreReview() {
        guard let url = URL(string: "https://apps.apple.com/app/id\(Self.appStoreID)?action=write-review") else { return }
        openURL(url) { opened in
            // Flutter shows this English text too; it has no ARB string yet.
            if !opened { navigation.showToast("Couldn’t open the store. Please try again.", kind: .error) }
        }
    }

    private func sendFeedback() {
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = Self.supportEmail
        components.queryItems = [
            URLQueryItem(name: "subject", value: "Patterns feedback"),
            URLQueryItem(name: "body", value: "Hi,\n\nMy feedback about Patterns:\n\n"),
        ]
        guard let url = components.url else { return }
        openURL(url) { opened in
            if !opened { navigation.showToast("Couldn’t open email. You can write to \(Self.supportEmail).", kind: .error) }
        }
    }

    private func openPrivacyPolicy() {
        guard let url = URL(string: "https://patternsocd.com/privacy") else { return }
        openURL(url) { opened in
            if !opened { navigation.showToast(model.strings.settingsText(key: "privacyPolicyFailed"), kind: .error) }
        }
    }

    /// "2.0.0 (100)", so support requests can name the exact build.
    static var versionText: String {
        let info = Bundle.main.infoDictionary
        let version = info?["CFBundleShortVersionString"] as? String ?? ""
        let build = info?["CFBundleVersion"] as? String ?? ""
        return build.isEmpty ? version : "\(version) (\(build))"
    }
}

// MARK: - Panels

private enum SettingsPanel: Identifiable {
    case language, export, importPrompt, wipe, privacy, paywall, tipJar
    case importPreview(PendingBackup)

    var id: String {
        switch self {
        case .language: "language"
        case .export: "export"
        case .importPrompt: "import"
        case .wipe: "wipe"
        case .privacy: "privacy"
        case .paywall: "paywall"
        case .tipJar: "tipJar"
        case .importPreview: "preview"
        }
    }
}

private struct PendingBackup: Sendable {
    let data: Data
    let isZip: Bool
    let summary: BackupSummary
}

private extension BackupSummary {
    /// The lines `_showImportPreview` lists, with the Pro tool tables summed
    /// into one "recovery" count.
    func lines(_ strings: Strings) -> [String] {
        let recovery = [
            "exposure_hierarchies", "exposure_steps", "response_prevention_logs", "urge_surf_sessions",
            "program_enrollments", "program_task_progress", "behavioral_experiments", "exposure_reflections",
            "action_plans", "implementation_intentions", "uncertainty_log", "exposure_materials",
        ].reduce(0) { $0 + count($1) }
        return [
            strings.settingsBackupJournalCount(count: count("journal")),
            strings.settingsBackupOcdCount(count: count("ocd")),
            strings.settingsBackupDelayCount(count: count("delay_sessions")),
            strings.settingsBackupErpPlanCount(count: count("erp_exercise_plans")),
            strings.settingsBackupErpPracticeCount(count: count("erp_exercise_sessions")),
            strings.settingsBackupRecoveryCount(count: recovery),
            strings.settingsBackupSelfCheckCount(count: count("ybocs_assessments")),
        ]
    }
}

/// A heading, a muted paragraph, then actions: the shape of every Settings
/// confirmation panel.
private struct PanelBody<Actions: View>: View {
    let title: String
    let message: String
    @ViewBuilder var actions: Actions

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                .accessibilityAddTraits(.isHeader)
            Text(message)
                .textRole(.bodyMedium, color: AppColors.textSecondary)
                .padding(.top, 10)
            VStack(alignment: .leading, spacing: 12) { actions }
                .padding(.top, 20)
        }
    }
}

private struct BackupCountList: View {
    let lines: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(lines, id: \.self) { line in
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Circle().fill(AppColors.textSecondary).frame(width: 5, height: 5)
                        .alignmentGuide(.firstTextBaseline) { $0[.bottom] + 4 }
                        .accessibilityHidden(true)
                    Text(line).textRole(.bodyMedium, color: AppColors.textPrimary)
                }
            }
        }
    }
}

private struct PrivacyPanel: View {
    let onPolicy: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 12) {
            Text(strings.privacySafetyTitle)
                .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                .accessibilityAddTraits(.isHeader)
            ForEach([strings.privacyLocalContent, strings.privacyPurchases, strings.privacyExports,
                     strings.privacyAnalytics, strings.privacyClinicalBoundary], id: \.self) { paragraph in
                Text(paragraph).textRole(.bodyMedium, color: AppColors.textSecondary)
            }
            Button(strings.viewPrivacyPolicyAction, action: onPolicy)
                .buttonStyle(SecondaryButtonStyle(fullWidth: true))
                .padding(.top, 8)
        }
    }
}

/// `showAppLanguagePicker`: every language by its own name, current ticked.
private struct LanguagePanel: View {
    let current: AppLanguage
    let onSelect: (AppLanguage) -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 0) {
            Text(strings.languageTitle)
                .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, 12)
            ForEach(AppLanguage.pickerOrder, id: \.self) { language in
                Button { onSelect(language) } label: {
                    HStack {
                        Text(language == .system ? strings.systemDefault : language.nativeName)
                            .textRole(.bodyLarge, weight: language == current ? .bold : nil,
                                      color: language == current ? AppColors.accent : AppColors.textPrimary)
                        Spacer()
                        if language == current {
                            Image(systemName: "checkmark").foregroundStyle(AppColors.accent)
                        }
                    }
                    .frame(minHeight: 48)
                    .contentShape(.rect)
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(language == current ? .isSelected : [])
            }
        }
    }
}

/// Flutter's time picker dialog, as a wheel in a panel.
private struct ReminderTimePicker: View {
    let initial: Date
    let onFinish: (Date?) -> Void
    @State private var time: Date
    @Environment(AppModel.self) private var model
    @State private var height: CGFloat = 360

    init(initial: Date, onFinish: @escaping (Date?) -> Void) {
        self.initial = initial
        self.onFinish = onFinish
        _time = State(initialValue: initial)
    }

    var body: some View {
        let strings = model.strings
        VStack(alignment: .leading, spacing: 12) {
            Text(strings.settingsReminderTimeTitle)
                .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                .accessibilityAddTraits(.isHeader)
            DatePicker(strings.settingsReminderTimeTitle, selection: $time, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(maxWidth: .infinity)
            PanelActions(secondaryTitle: strings.cancelAction, primaryTitle: strings.doneAction,
                         onSecondary: { onFinish(nil) }, onPrimary: { onFinish(time) })
        }
        .padding(EdgeInsets(top: 28, leading: 24, bottom: 12, trailing: 24))
        .fixedSize(horizontal: false, vertical: true)
        .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height = $0 }
        .presentationDetents([.height(height)])
        .presentationBackground(AppColors.card)
    }
}

// MARK: - Rows

/// `_SettingsItem`: icon, title and subtitle in a soft card, with a chevron.
private struct SettingsItem: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(AppColors.accent)
                    .frame(width: 26)
                SettingsLabels(title: title, subtitle: subtitle)
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding(18)
            .frame(minHeight: 44)
            .softSurface(radius: 22)
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityHint(subtitle)
        .accessibilityAddTraits(.isButton)
    }
}

/// `_SettingsSwitchItem`.
private struct SettingsSwitchItem: View {
    let icon: String
    let title: String
    let subtitle: String
    let value: Bool
    let onChange: (Bool) -> Void

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(AppColors.accent)
                .frame(width: 26)
                .accessibilityHidden(true)
            SettingsLabels(title: title, subtitle: subtitle)
            Toggle(title, isOn: Binding(get: { value }, set: { onChange($0) }))
                .labelsHidden()
                .tint(AppColors.accent)
        }
        .padding(18)
        .frame(minHeight: 44)
        .softSurface(radius: 22)
        .contentShape(.rect)
        .onTapGesture { onChange(!value) }
        .accessibilityElement(children: .combine)
        .accessibilityHint(subtitle)
    }
}

private struct SettingsLabels: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).textRole(.titleMedium, weight: .heavy, color: AppColors.textPrimary)
            Text(subtitle)
                .font(.custom(AppFont.sans, size: 13, relativeTo: .footnote))
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
    }
}

/// `_AppearancePicker`: System, Light and Dark as one segmented control.
private struct AppearancePicker: View {
    let value: AppAppearance
    let onChange: (AppAppearance) -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        let options: [(AppAppearance, String, String)] = [
            (.system, "circle.lefthalf.filled", strings.appearanceSystem),
            (.light, "sun.max", strings.appearanceLight),
            (.dark, "moon", strings.appearanceDark),
        ]
        let layout = typeSize >= .xxxLarge ? AnyLayout(VStackLayout(spacing: 4)) : AnyLayout(HStackLayout(spacing: 4))
        layout {
            ForEach(options, id: \.0) { option, icon, label in
                let selected = option == value
                Button { onChange(option) } label: {
                    HStack(spacing: 6) {
                        Image(systemName: icon).font(.system(size: 15)).accessibilityHidden(true)
                        Text(label).font(.custom(AppFont.sans, size: 14, relativeTo: .callout).weight(.bold))
                    }
                    .foregroundStyle(selected ? AppColors.onAccent : AppColors.textPrimary)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(selected ? AppColors.accent : .clear, in: .rect(cornerRadius: 16))
                    .contentShape(.rect(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(selected ? .isSelected : [])
            }
        }
        .padding(6)
        .softSurface(radius: 22)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(strings.appearanceTitle)
    }
}

// MARK: - Support types

/// The exported zip, handed to the system save sheet.
struct BackupDocument: FileDocument {
    static let readableContentTypes: [UTType] = [.zip]
    let data: Data

    init(data: Data) { self.data = data }

    init(configuration: ReadConfiguration) throws {
        data = configuration.file.regularFileContents ?? Data()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}

extension AppLanguage {
    /// Flutter's `AppLanguage.values` order.
    static let pickerOrder: [AppLanguage] = [.system, .english, .portugueseBrazil, .german, .japanese, .spanish, .french]

    /// Each language in its own name, from `lib/l10n/app_language.dart`.
    var nativeName: String {
        switch self {
        case .system: "System Default"
        case .english: "English"
        case .portugueseBrazil: "Português (Brasil)"
        case .german: "Deutsch"
        case .japanese: "日本語"
        case .spanish: "Español"
        case .french: "Français"
        }
    }
}
