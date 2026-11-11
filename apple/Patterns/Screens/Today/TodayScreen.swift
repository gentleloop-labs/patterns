import PatternsCore
import SwiftUI

/// `TodayScreen` from `lib/mobile/screens/journal_screen.dart`.
///
/// Before any real activity it is the calm first-run layout (one suggested
/// step, three choices, an optional self-check). After that it becomes the
/// full home: progress, the next step, practice and quick actions.
struct TodayScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    @State private var snapshot: Loadable<ActivitySnapshot> = .loading
    /// Bumped when the Pro card is hidden, so the body re-reads the pref.
    @State private var proCardRevision = 0

    var body: some View {
        let strings = model.strings
        let data = snapshot.value ?? ActivitySnapshot()
        let streak = RecoveryInsights.metrics(data).practiceStreakDays
        let showStreak = data.hasActivity && !model.calmInsightsEnabled && streak > 0
        List {
            if data.hasActivity {
                established(data)
            } else {
                firstRun(data)
            }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(20)
        .appListBackground()
        .navigationTitle(greeting(strings))
        .toolbar {
            if showStreak {
                ToolbarItem(placement: .topBarTrailing) {
                    Label("\(streak)", systemImage: "flame.fill")
                        .labelStyle(.titleAndIcon)
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(AppColors.accent)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(strings.recoveryMetricsDayStreak(days: streak))
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(strings.settingsTitle, systemImage: "gearshape") { navigation.push(.settings) }
            }
        }
        .liveQuery(model.database, into: $snapshot) { db in try ActivitySnapshot.fetch(db) }
    }

    private func greeting(_ strings: Strings) -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return strings.todayGreetingMorning }
        if hour < 17 { return strings.todayGreetingAfternoon }
        return strings.todayGreetingEvening
    }

    // MARK: Layouts

    /// The encouragement line sits above the first card, under the title.
    private var encouragement: some View {
        Text(model.strings.todayEncouragement)
            .font(.subheadline)
            .foregroundStyle(AppColors.textSecondary)
            .textCase(nil)
            .padding(.leading, -4)
    }

    @ViewBuilder
    private func established(_ data: ActivitySnapshot) -> some View {
        let strings = model.strings
        Section {
            if model.calmInsightsEnabled {
                CalmActivityRow(summary: RecoveryInsights.calmInsights(data)) { navigation.select(.insights) }
            } else {
                HomeScoreRow(summary: RecoveryInsights.dashboard(data),
                             enoughData: RecoveryInsights.hasEnoughForProgress(data)) {
                    navigation.select(.insights)
                }
            }
        } header: {
            encouragement
        }
        .listRowBackground(AppColors.card)

        let step = RecoveryInsights.nextStep(
            isPro: model.proUnlocked,
            hasYbocs: !data.ybocsAssessments.isEmpty,
            hasHierarchy: !data.exposureSteps.isEmpty,
            practicedToday: RecoveryInsights.practicedToday(data)
        )
        Section(strings.todayNextStep) {
            NextStepRow(copy: NextStepCopy(step, strings)) { openNextStep(step) }
            if showProCard {
                ProProgressionRow(onTap: { navigation.presentPaywall(.todayNextStep) }, onDismiss: hideProCard)
            }
        }
        .listRowBackground(AppColors.card)

        Section {
            ContinuePracticeRow(recentDelay: data.latestDelay) {
                if data.latestDelay == nil { navigation.select(.erp) } else { navigation.push(.compulsionDelay) }
            }
        } header: {
            HStack {
                Text(strings.todayContinuePractice)
                Spacer()
                Button(strings.todaySeeAllAction) { navigation.select(.erp) }
                    .font(.subheadline.weight(.semibold))
                    .textCase(nil)
            }
        }
        .listRowBackground(AppColors.card)

        Section(strings.todayQuickActions) {
            ActionRow(systemImage: "square.and.pencil", title: strings.navJournal, subtitle: strings.todayJournalBody,
                      action: openJournal)
            ActionRow(systemImage: "scope", title: strings.todayStartErp, subtitle: strings.todayBuildToleranceBody) {
                navigation.select(.erp)
            }
            ActionRow(systemImage: "square.3.layers.3d", title: strings.todayExposureTools,
                      subtitle: strings.todayExposureToolsBody) { navigation.select(.erp) }
            ActionRow(systemImage: "chart.bar", title: strings.navInsights, subtitle: strings.todayInsightsBody) {
                navigation.select(.insights)
            }
        }
        .listRowBackground(AppColors.card)

        Section {
            DailyCheckInRow(checkedIn: data.journals.contains { $0.date == JournalEntry.dayKey(for: Date()) },
                            onTap: openJournal)
        }
        .listRowBackground(AppColors.card)
    }

    @ViewBuilder
    private func firstRun(_ data: ActivitySnapshot) -> some View {
        let strings = model.strings
        let primary = firstRunPrimary(strings)
        Section {
            NextStepRow(copy: primary.copy, action: primary.action)
        } header: {
            encouragement
        }
        .listRowBackground(AppColors.card)

        Section(strings.todayChooseActivity) {
            ActionRow(systemImage: "square.and.pencil", title: strings.todayWriteSomethingTitle,
                      subtitle: strings.todayWriteSomethingBody) {
                navigation.push(.ocdEvent(entryID: nil, type: .obsession))
            }
            ActionRow(systemImage: "hourglass", title: strings.todayDelayUrgeTitle,
                      subtitle: strings.todayDelayUrgeBody) { navigation.push(.compulsionDelay) }
            ActionRow(systemImage: "leaf", title: strings.todayPracticeErpTitle,
                      subtitle: strings.todayPracticeErpBody) { navigation.select(.erp) }
        }
        .listRowBackground(AppColors.card)

        Section {
            if data.ybocsAssessments.isEmpty {
                ActionRow(systemImage: "list.clipboard", title: strings.todaySelfCheckTitle,
                          subtitle: strings.todaySelfCheckDuration) { openNextStep(.selfCheck) }
            }
        } footer: {
            Label(strings.todayInsightsPlaceholder, systemImage: "chart.xyaxis.line")
                .font(.footnote)
                .padding(.top, 4)
        }
        .listRowBackground(AppColors.card)
    }

    /// The first-run suggestion echoes what the user picked on the welcome
    /// screen.
    private func firstRunPrimary(_ strings: Strings) -> (copy: NextStepCopy, action: () -> Void) {
        switch model.prefs.string(PreferenceKey.firstRunPath).flatMap(FirstRunPath.init(rawValue:)) {
        case .journal:
            (NextStepCopy(title: strings.todayFirstJournalTitle, subtitle: strings.todayFirstJournalBody,
                          cta: strings.journalNewEntryAction),
             { navigation.push(.ocdEvent(entryID: nil, type: .obsession)) })
        case .erp:
            (NextStepCopy(title: strings.todayFirstErpTitle, subtitle: strings.todayFirstErpBody,
                          cta: strings.todayStartPracticeAction),
             { navigation.select(.erp) })
        default:
            (NextStepCopy(title: strings.todayFirstDelayTitle, subtitle: strings.todayFirstDelayBody,
                          cta: strings.todayStartDelayAction),
             { navigation.push(.compulsionDelay) })
        }
    }

    // MARK: Actions

    private var showProCard: Bool {
        _ = proCardRevision
        let dismissedUntil = model.prefs.int(PreferenceKey.proCardDismissedUntil) ?? 0
        return !model.proUnlocked
            && (model.prefs.int(PreferenceKey.meaningfulActionCount) ?? 0) >= 2
            && Int(Date().timeIntervalSince1970 * 1000) >= dismissedUntil
    }

    private func hideProCard() {
        let until = Date().addingTimeInterval(7 * 24 * 60 * 60)
        model.prefs.set(Int(until.timeIntervalSince1970 * 1000), for: PreferenceKey.proCardDismissedUntil)
        proCardRevision += 1
    }

    private func openJournal() {
        navigation.push(.journalEntry(day: JournalEntry.dayKey(for: Date())))
    }

    /// `_openNextStep`. Pro-only steps are only suggested to Pro users; the
    /// paywall guard is defensive, as in Flutter.
    private func openNextStep(_ step: RecoveryStep) {
        switch step {
        case .selfCheck: navigation.push(.selfCheck)
        case .buildHierarchy:
            if navigation.requirePro(model.proUnlocked, .exposureHierarchy) { navigation.push(.exposureHierarchy) }
        case .dailyPractice: navigation.push(.erpExercises)
        case .reflect:
            if navigation.requirePro(model.proUnlocked, .reflectionJournal) { navigation.push(.exposureReflection) }
        case .journal: openJournal()
        }
    }
}

/// `FirstRunPath` from `lib/mobile/first_run.dart`, stored by name under
/// `firstRunPath`.
enum FirstRunPath: String, CaseIterable {
    case urge, journal, erp, selfcheck, explore
}

// MARK: - Rows

/// A tappable list row: icon, title, an explanation and a chevron, the
/// shape of a navigation row.
private struct ActionRow: View {
    let systemImage: String
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundStyle(AppColors.accent)
                    .frame(width: 30)
                    .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(Color(.label))
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(AppColors.textSecondary)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
                    .accessibilityHidden(true)
            }
            .padding(.vertical, 4)
            .contentShape(.rect)
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint(subtitle)
    }
}

private struct UsesLargeText {
    /// Flutter's `_usesLargeText`: text scale of 1.5 or more.
    static func check(_ size: DynamicTypeSize) -> Bool { size >= .accessibility1 }
}

private struct CalmActivityRow: View {
    let summary: CalmInsightsSummary
    let onTap: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let facts = [
            summary.journalCount > 0 ? strings.calmJournalActivity(count: summary.journalCount) : nil,
            summary.trackedMomentCount > 0 ? strings.calmTrackedActivity(count: summary.trackedMomentCount) : nil,
            summary.delayCount > 0 ? strings.calmDelayActivity(count: summary.delayCount) : nil,
            summary.erpPracticeCount > 0 ? strings.calmErpActivity(count: summary.erpPracticeCount) : nil,
            summary.exposureCount > 0 ? strings.calmExposureActivity(count: summary.exposureCount) : nil,
        ].compactMap { $0 }
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 14) {
                VStack(alignment: .leading, spacing: 8) {
                    Label(strings.calmRecentActivityTitle, systemImage: "leaf")
                        .font(.headline)
                        .foregroundStyle(Color(.label))
                    if facts.isEmpty {
                        Text(strings.calmNoRecentActivity)
                            .foregroundStyle(AppColors.textSecondary)
                    } else {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(facts, id: \.self) { fact in
                                Text(fact).foregroundStyle(AppColors.textSecondary)
                            }
                        }
                        .font(.subheadline)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
            }
            .multilineTextAlignment(.leading)
            .padding(.vertical, 6)
            .contentShape(.rect)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.calmRecentActivityTitle)
        .accessibilityValue(facts.isEmpty ? strings.calmNoRecentActivity : facts.joined(separator: ", "))
        .accessibilityAddTraits(.isButton)
    }
}

private struct HomeScoreRow: View {
    let summary: RecoveryDashboard
    let enoughData: Bool
    let onTap: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        Button(action: onTap) {
            Group {
                if enoughData { scored(strings) } else { placeholder(strings) }
            }
            .contentShape(.rect)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(enoughData
            ? strings.todayScoreA11y(score: summary.recoveryScore, label: label(strings))
            : strings.todayPracticeProgress)
        .accessibilityHint(strings.todayInsightsBody)
        .accessibilityAddTraits(.isButton)
    }

    private func eyebrow(_ strings: Strings) -> some View {
        Text(strings.todayPracticeProgress)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(AppColors.accent)
    }

    private func scored(_ strings: Strings) -> some View {
        let details = VStack(alignment: .leading, spacing: 0) {
            eyebrow(strings)
            Text(summary.hasAnyData ? strings.todaySteadyPractice : strings.todayStartGently)
                .font(.headline)
                .foregroundStyle(Color(.label))
                .padding(.top, 6)
            Text(summary.hasAnyData ? strings.todayPracticeActiveBody : strings.todayPracticeEmptyBody)
                .font(.footnote)
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 2)
            Text(deltaText(strings))
                .font(.footnote.weight(.semibold))
                .foregroundStyle(AppColors.accent)
                .padding(.top, 8)
        }
        let ring = ScoreRing(score: summary.recoveryScore, label: label(strings))
        return VStack(alignment: .leading, spacing: 14) {
            if UsesLargeText.check(typeSize) {
                VStack(alignment: .leading, spacing: 16) { ring; details }
            } else {
                HStack(spacing: 18) {
                    ring
                    details.frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(Color(.tertiaryLabel))
                }
            }
            Text(strings.todayProgressDisclaimer)
                .font(.caption)
                .foregroundStyle(AppColors.textSecondary)
        }
        .multilineTextAlignment(.leading)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func placeholder(_ strings: Strings) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            eyebrow(strings)
            Text(strings.todayProgressStartedTitle)
                .font(.headline)
                .foregroundStyle(Color(.label))
                .padding(.top, 6)
            Text(strings.todayProgressPendingBody)
                .font(.footnote)
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 2)
        }
        .multilineTextAlignment(.leading)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func label(_ strings: Strings) -> String {
        let score = summary.recoveryScore
        if !summary.hasAnyData { return strings.todayScoreNew }
        if score >= 80 { return strings.todayScoreStrong }
        if score >= 60 { return strings.todayScoreSteady }
        if score >= 40 { return strings.todayScoreBuilding }
        return strings.todayScoreStarting
    }

    private func deltaText(_ strings: Strings) -> String {
        if !summary.hasAnyData { return strings.todayBeginCheckIn }
        let rounded = Int(summary.scoreDelta.value.rounded())
        if rounded == 0 { return strings.todayNoChange }
        return rounded > 0 ? strings.todayPointsUp(points: abs(rounded)) : strings.todayPointsDown(points: abs(rounded))
    }
}

/// `_HomeScoreRing`: a 108pt ring with the score and its label.
private struct ScoreRing: View {
    let score: Int
    let label: String

    var body: some View {
        ZStack {
            Circle().stroke(Color(.systemFill), lineWidth: 8)
            Circle()
                .trim(from: 0, to: CGFloat(min(max(score, 0), 100)) / 100)
                .stroke(AngularGradient(colors: [AppColors.accent, Color(red: 1, green: 0.914, blue: 0.58), AppColors.accent],
                                        center: .center),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 4) {
                Text("\(score)").font(.system(size: 31, weight: .bold, design: .rounded)).foregroundStyle(Color(.label))
                Text(label).font(.caption2.weight(.semibold)).foregroundStyle(AppColors.accent)
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
        }
        .padding(4)
        .frame(width: 108, height: 108)
        .accessibilityHidden(true)
    }
}

struct NextStepCopy {
    let title: String
    let subtitle: String
    let cta: String

    init(title: String, subtitle: String, cta: String) {
        self.title = title; self.subtitle = subtitle; self.cta = cta
    }

    /// `_localizedNextStep`.
    init(_ step: RecoveryStep, _ strings: Strings) {
        switch step {
        case .selfCheck: self.init(title: strings.todayNextSelfCheckTitle, subtitle: strings.todayNextSelfCheckBody,
                                   cta: strings.todayNextSelfCheckAction)
        case .buildHierarchy: self.init(title: strings.todayNextHierarchyTitle, subtitle: strings.todayNextHierarchyBody,
                                        cta: strings.todayNextHierarchyAction)
        case .dailyPractice: self.init(title: strings.todayNextPracticeTitle, subtitle: strings.todayNextPracticeBody,
                                       cta: strings.todayNextPracticeAction)
        case .reflect: self.init(title: strings.todayNextReflectTitle, subtitle: strings.todayNextReflectBody,
                                 cta: strings.todayNextReflectAction)
        case .journal: self.init(title: strings.todayNextJournalTitle, subtitle: strings.todayNextJournalBody,
                                 cta: strings.todayNextJournalAction)
        }
    }
}

private struct NextStepRow: View {
    let copy: NextStepCopy
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(copy.title)
                .font(.title3.weight(.semibold))
            Text(copy.subtitle)
                .font(.subheadline)
                .foregroundStyle(AppColors.textSecondary)
            Button(copy.cta, action: action)
                .buttonStyle(.accentProminent)
                .buttonBorderShape(.capsule)
                .padding(.top, 10)
                // The whole row is the button for VoiceOver.
                .accessibilityHidden(true)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(.rect)
        .onTapGesture(perform: action)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(copy.title)
        .accessibilityHint(copy.subtitle)
        .accessibilityAddTraits(.isButton)
        .accessibilityAction(.default, action)
    }
}

private struct ProProgressionRow: View {
    let onTap: () -> Void
    let onDismiss: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        HStack(spacing: 12) {
            Button(action: onTap) {
                Label {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(strings.todayProTitle).font(.subheadline.weight(.semibold)).foregroundStyle(Color(.label))
                        Text(strings.todayProBody).font(.footnote).foregroundStyle(AppColors.textSecondary)
                    }
                    .multilineTextAlignment(.leading)
                } icon: {
                    Image(systemName: "sparkles").foregroundStyle(AppColors.accent)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(.rect)
            }
            .buttonStyle(.plain)
            Button(strings.todayHideSevenDays, systemImage: "xmark", action: onDismiss)
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)
                .foregroundStyle(Color(.tertiaryLabel))
        }
        .swipeActions {
            Button(strings.todayHideSevenDays, action: onDismiss)
        }
    }
}

private struct ContinuePracticeRow: View {
    let recentDelay: DelaySession?
    let onResume: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        let session = recentDelay
        // With no session yet, Flutter shows an illustrative half-full timer.
        let progress = session.map { $0.plannedSeconds > 0 ? min(max(Double($0.actualSeconds) / Double($0.plannedSeconds), 0), 1) : 0 } ?? 0.58
        let elapsed = session.map { Self.format($0.actualSeconds) } ?? "2:30"
        let planned = session.map { Self.format($0.plannedSeconds) } ?? "5:00"
        let timerLabel = strings.todayTimerA11y(elapsed: elapsed, planned: planned)
        let large = UsesLargeText.check(typeSize)

        let graphic = ZStack {
            Circle().stroke(Color(.systemFill), lineWidth: 5)
            Circle().trim(from: 0, to: progress)
                .stroke(AppColors.accent, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Image(systemName: "clock").font(.system(size: 20)).foregroundStyle(AppColors.accent)
        }
        .padding(2.5)
        .frame(width: 60, height: 60)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(timerLabel)

        let bar = ProgressView(value: progress)
        let timeText = Text("\(elapsed) / \(planned)")
            .font(.caption.monospacedDigit())
            .foregroundStyle(AppColors.textSecondary)
            .fixedSize()

        let details = VStack(alignment: .leading, spacing: 0) {
            Text(session == nil ? strings.todayStartErp : strings.todayCompulsionDelay)
                .font(.headline)
            Text(session == nil ? strings.todayBuildToleranceBody : strings.todayResistUrgeBody)
                .font(.footnote)
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 2)
            Group {
                if large {
                    VStack(alignment: .leading, spacing: 8) { bar; timeText }
                } else {
                    HStack(spacing: 8) { bar; timeText }
                }
            }
            // The ring already reads the timer; a second, 14pt-tall copy
            // here would be a duplicate stop with a tiny hit area.
            .accessibilityHidden(true)
            .padding(.top, 10)
        }
        let action = Button(session == nil ? strings.todayStartAction : strings.todayResumeAction, action: onResume)
            .buttonStyle(.accentProminent)
            .buttonBorderShape(.capsule)

        Group {
            if large {
                VStack(alignment: .leading, spacing: 14) {
                    HStack(alignment: .top, spacing: 16) { graphic; details }
                    action
                }
            } else {
                HStack(spacing: 16) {
                    graphic
                    details.frame(maxWidth: .infinity, alignment: .leading)
                    action
                }
            }
        }
        .padding(.vertical, 6)
    }

    static func format(_ seconds: Int) -> String {
        "\(seconds / 60):" + String(format: "%02d", seconds % 60)
    }
}

private struct DailyCheckInRow: View {
    let checkedIn: Bool
    let onTap: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        let large = UsesLargeText.check(typeSize)
        let details = VStack(alignment: .leading, spacing: 4) {
            Text(checkedIn ? strings.todayDailyCheckInComplete : strings.todayDailyCheckIn)
                .font(.headline)
            Text(checkedIn ? strings.todayDailyCompleteBody : strings.todayDailyBody)
                .font(.footnote)
                .foregroundStyle(AppColors.textSecondary)
        }
        let action = Button(checkedIn ? strings.todayOpenAction : strings.todayCheckInAction, action: onTap)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        Group {
            if large {
                VStack(alignment: .leading, spacing: 14) { details; action }
            } else {
                HStack(spacing: 14) {
                    Image(systemName: "leaf.fill")
                        .foregroundStyle(AppColors.positive)
                        .frame(width: 44, height: 44)
                        .background(AppColors.positive.opacity(0.12), in: .circle)
                        .accessibilityHidden(true)
                    details.frame(maxWidth: .infinity, alignment: .leading)
                    action
                }
            }
        }
        .padding(.vertical, 6)
    }
}
