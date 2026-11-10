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

    @State private var sheet: SettingsSheet?
    @State private var prompt: SettingsPrompt?
    @State private var exportDocument: BackupDocument?
    @State private var exporting = false
    @State private var importing = false
    @State private var redeeming = false
    /// Offer-code redemptions report nothing back; the unlock arrives later
    /// as a transaction. Flutter listened for 10 minutes.
    @State private var redeemWatchUntil: Date?

    var body: some View {
        let strings = model.strings
        Form {
            Section(strings.appearanceTitle) {
                Picker(strings.appearanceTitle, selection: Binding(get: { model.appearance }, set: { model.setAppearance($0) })) {
                    Text(strings.appearanceSystem).tag(AppAppearance.system)
                    Text(strings.appearanceLight).tag(AppAppearance.light)
                    Text(strings.appearanceDark).tag(AppAppearance.dark)
                }
                .pickerStyle(.segmented)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            Section {
                Picker(selection: Binding(get: { model.language }, set: setLanguage)) {
                    ForEach(AppLanguage.pickerOrder, id: \.self) { language in
                        Text(language == .system ? strings.systemDefault : language.nativeName).tag(language)
                    }
                } label: {
                    Label(strings.languageTitle, systemImage: "character.bubble")
                }
                .pickerStyle(.navigationLink)
                Toggle(isOn: Binding(get: { model.calmInsightsEnabled }, set: { model.setCalmInsights($0) })) {
                    RowLabel(strings.calmInsightsTitle, subtitle: strings.calmInsightsSubtitle, icon: "leaf")
                }
            }
            .listRowBackground(AppColors.card)

            Section(strings.settingsDataSection) {
                Button { prompt = .export } label: {
                    RowLabel(strings.settingsExportDataTitle, subtitle: strings.settingsExportDataSubtitle, icon: "square.and.arrow.up")
                }
                Button { sheet = .report } label: {
                    RowLabel(strings.exportReportTitle, subtitle: strings.exportReportDescription, icon: "doc.richtext")
                }
                Button { prompt = .importPrompt } label: {
                    RowLabel(strings.settingsImportDataTitle, subtitle: strings.settingsImportDataSubtitle, icon: "square.and.arrow.down")
                }
            }
            .listRowBackground(AppColors.card)

            Section(strings.settingsRemindersSection) {
                Toggle(isOn: Binding(get: { model.reminder.enabled }, set: { enabled in Task { await setReminderEnabled(enabled) } })) {
                    RowLabel(strings.settingsDailyReminderTitle,
                             subtitle: model.reminder.enabled ? nil : strings.settingsDailyReminderOff, icon: "bell")
                }
                if model.reminder.enabled {
                    DatePicker(selection: Binding(get: { model.reminder.date }, set: { date in Task { await setReminderTime(date) } }),
                               displayedComponents: .hourAndMinute) {
                        Label(strings.settingsReminderTimeTitle, systemImage: "clock")
                    }
                    .environment(\.locale, strings.locale)
                }
            }
            .listRowBackground(AppColors.card)

            Section(strings.settingsPrivacySection) {
                Button { sheet = .privacy } label: {
                    RowLabel(strings.privacySafetyTitle, subtitle: strings.settingsPrivacySafetySubtitle, icon: "hand.raised")
                }
                Toggle(isOn: Binding(get: { model.usageAnalyticsEnabled }, set: { model.setUsageAnalytics($0) })) {
                    RowLabel(strings.settingsAnalyticsTitle, subtitle: strings.settingsAnalyticsSubtitle, icon: "chart.bar")
                }
                Toggle(isOn: Binding(get: { model.appLockEnabled }, set: { enabled in Task { await setAppLock(enabled) } })) {
                    RowLabel(strings.settingsAppLockTitle, subtitle: strings.settingsAppLockSubtitle, icon: "faceid")
                }
                Button(role: .destructive) { prompt = .wipe } label: {
                    RowLabel(strings.settingsWipeTitle, subtitle: strings.settingsWipeSubtitle, icon: "trash", destructive: true)
                }
            }
            .listRowBackground(AppColors.card)

            Section(strings.settingsProSection) {
                if model.proUnlocked {
                    RowLabel(strings.settingsProActiveTitle, subtitle: strings.settingsProActiveSubtitle, icon: "checkmark.seal.fill")
                } else {
                    Button { sheet = .paywall } label: {
                        RowLabel(strings.settingsUnlockProTitle, subtitle: strings.settingsUnlockProSubtitle, icon: "lock.open")
                    }
                    Button {
                        redeemWatchUntil = Date().addingTimeInterval(10 * 60)
                        redeeming = true
                    } label: {
                        RowLabel(strings.settingsRedeemCodeTitle, subtitle: strings.settingsRedeemCodeSubtitle, icon: "gift")
                    }
                }
                Button { Task { await restorePurchases() } } label: {
                    RowLabel(strings.settingsRestorePurchasesTitle, subtitle: strings.settingsRestorePurchasesSubtitle,
                             icon: "arrow.clockwise")
                }
            }
            .listRowBackground(AppColors.card)

            Section(strings.settingsHelpSection) {
                Button {
                    model.prefs.set(false, for: PreferenceKey.tabTourSeen)
                    navigation.requestTour()
                } label: {
                    RowLabel(strings.settingsReplayTourTitle, subtitle: strings.settingsReplayTourSubtitle, icon: "map")
                }
                Button {
                    // Next launch, as in Flutter: the current session carries on.
                    model.prefs.set(false, for: PreferenceKey.hasStarted)
                    navigation.showToast(strings.settingsText(key: "welcomeScheduled"), kind: .info)
                } label: {
                    RowLabel(strings.settingsShowWelcomeTitle, subtitle: strings.settingsShowWelcomeSubtitle, icon: "sparkles")
                }
            }
            .listRowBackground(AppColors.card)

            Section {
                Button(action: openStoreReview) {
                    RowLabel(strings.settingsRateTitle, subtitle: strings.settingsRateSubtitle, icon: "star")
                }
                Button(action: sendFeedback) {
                    RowLabel(strings.settingsSendFeedbackTitle, subtitle: strings.settingsSendFeedbackSubtitle, icon: "envelope")
                }
                Button { sheet = .tipJar } label: {
                    RowLabel(strings.settingsSupportTitle, subtitle: strings.settingsSupportSubtitle, icon: "heart")
                }
            } header: {
                Text(strings.settingsFeedbackSection)
            } footer: {
                Text("\(strings.settingsVersionLabel) \(Self.versionText)")
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
            }
            .listRowBackground(AppColors.card)
        }
        .appListBackground()
        .navigationTitle(strings.settingsTitle)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $sheet) { sheet in
            switch sheet {
            case .paywall: PaywallSheet(entryPoint: .settings)
            case .tipJar: TipJarSheet()
            case .privacy: PrivacySheet(onPolicy: openPrivacyPolicy)
            case .report: ExportReportSheet()
            }
        }
        .alert(prompt.map { title(for: $0, strings) } ?? "",
               isPresented: Binding(get: { prompt != nil }, set: { if !$0 { prompt = nil } }),
               presenting: prompt) { prompt in
            promptActions(prompt, strings)
        } message: { prompt in
            Text(message(for: prompt, strings))
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

    // MARK: Prompts

    private func title(for prompt: SettingsPrompt, _ strings: Strings) -> String {
        switch prompt {
        case .export: strings.settingsText(key: "exportPromptTitle")
        case .importPrompt: strings.settingsText(key: "importPromptTitle")
        case .importPreview: strings.settingsText(key: "importPreviewTitle")
        case .wipe: strings.settingsText(key: "wipePromptTitle")
        }
    }

    private func message(for prompt: SettingsPrompt, _ strings: Strings) -> String {
        switch prompt {
        case .export: strings.settingsText(key: "exportPromptBody")
        case .importPrompt: strings.settingsText(key: "importPromptBody")
        case let .importPreview(backup):
            ([strings.settingsText(key: "importPreviewIntro")] + backup.summary.lines(strings)).joined(separator: "\n")
        case .wipe: strings.settingsText(key: "wipePromptBody")
        }
    }

    @ViewBuilder
    private func promptActions(_ prompt: SettingsPrompt, _ strings: Strings) -> some View {
        switch prompt {
        case .export:
            Button(strings.settingsText(key: "exportBackupAction")) { Task { await prepareExport() } }
        case .importPrompt:
            Button(strings.settingsText(key: "chooseBackupAction")) { importing = true }
        case let .importPreview(backup):
            Button(strings.settingsText(key: "replaceAction"), role: .destructive) { Task { await restore(backup) } }
        case .wipe:
            Button(strings.settingsText(key: "wipeAction"), role: .destructive) { Task { await wipe() } }
        }
        Button(strings.cancelAction, role: .cancel) {}
    }

    private func setLanguage(_ language: AppLanguage) {
        model.setLanguage(language)
        if model.reminder.enabled {
            let reminder = model.reminder, strings = model.strings
            Task { try? await Reminders.scheduleDaily(hour: reminder.hour, minute: reminder.minute, strings: strings) }
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
            prompt = .importPreview(PendingBackup(data: data, isZip: isZip, summary: summary))
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

// MARK: - Sheets and prompts

private enum SettingsSheet: String, Identifiable {
    case paywall, tipJar, privacy, report
    var id: String { rawValue }
}

private enum SettingsPrompt {
    case export, importPrompt, wipe
    case importPreview(PendingBackup)
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

/// Privacy and safety notes in a native sheet.
private struct PrivacySheet: View {
    let onPolicy: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let strings = model.strings
        NavigationStack {
            List {
                ForEach([strings.privacyLocalContent, strings.privacyPurchases, strings.privacyExports,
                         strings.privacyAnalytics, strings.privacyClinicalBoundary], id: \.self) { paragraph in
                    Text(paragraph)
                        .font(.body)
                        .padding(.vertical, 4)
                        .listRowBackground(AppColors.card)
                }
                Section {
                    Button(strings.viewPrivacyPolicyAction, action: onPolicy)
                        .listRowBackground(AppColors.card)
                }
            }
            .appListBackground()
            .navigationTitle(strings.privacySafetyTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(strings.doneAction) { dismiss() }
                }
            }
        }
    }
}

/// A wheel time picker in a native sheet with Cancel and Done.
struct ReminderTimePicker: View {
    let initial: Date
    var title: String?
    let onFinish: (Date?) -> Void
    @State private var time: Date
    @Environment(AppModel.self) private var model

    init(initial: Date, title: String? = nil, onFinish: @escaping (Date?) -> Void) {
        self.initial = initial
        self.title = title
        self.onFinish = onFinish
        _time = State(initialValue: initial)
    }

    var body: some View {
        let strings = model.strings
        NavigationStack {
            DatePicker(strings.settingsReminderTimeTitle, selection: $time, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .environment(\.locale, strings.locale)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle(title ?? strings.settingsReminderTimeTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(strings.cancelAction) { onFinish(nil) }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(strings.doneAction) { onFinish(time) }
                            .fontWeight(.semibold)
                    }
                }
        }
        .presentationDetents([.height(340)])
    }
}

// MARK: - Rows

/// A settings row: icon, title and an optional explanation underneath.
private struct RowLabel: View {
    let title: String
    let subtitle: String?
    let icon: String
    var destructive = false

    init(_ title: String, subtitle: String?, icon: String, destructive: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.destructive = destructive
    }

    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .foregroundStyle(destructive ? Color.red : Color.primary)
                if let subtitle {
                    // Not `.secondary`: inside a button that resolves
                    // against the gold tint.
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(Color(.secondaryLabel))
                }
            }
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(destructive ? Color.red : AppColors.accent)
        }
        .padding(.vertical, 2)
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
