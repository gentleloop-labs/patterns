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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text(strings.todayEncouragement)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                if data.hasActivity {
                    established(data)
                } else {
                    firstRun(data)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 24, trailing: 20))
        }
        .background(AppColors.surface)
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

    @ViewBuilder
    private func established(_ data: ActivitySnapshot) -> some View {
        let strings = model.strings
        let calm = model.calmInsightsEnabled
        Group {
            if calm {
                CalmActivityCard(summary: RecoveryInsights.calmInsights(data)) { navigation.select(.insights) }
            } else {
                HomeScoreCard(summary: RecoveryInsights.dashboard(data),
                              enoughData: RecoveryInsights.hasEnoughForProgress(data)) {
                    navigation.select(.insights)
                }
            }
        }
        .padding(.top, 18)

        let step = RecoveryInsights.nextStep(
            isPro: model.proUnlocked,
            hasYbocs: !data.ybocsAssessments.isEmpty,
            hasHierarchy: !data.exposureSteps.isEmpty,
            practicedToday: RecoveryInsights.practicedToday(data)
        )
        NextStepCard(copy: NextStepCopy(step, strings)) { openNextStep(step) }
            .padding(.top, 16)
        if showProCard {
            ProProgressionCard(onTap: { navigation.presentPaywall(.todayNextStep) }, onDismiss: hideProCard)
                .padding(.top, 12)
        }

        HomeSectionHeader(title: strings.todayContinuePractice, actionLabel: strings.todaySeeAllAction) {
            navigation.select(.erp)
        }
        .padding(.top, 20)
        ContinuePracticeCard(recentDelay: data.latestDelay) {
            if data.latestDelay == nil { navigation.select(.erp) } else { navigation.push(.compulsionDelay) }
        }
        .padding(.top, 10)

        HomeSectionHeader(title: strings.todayQuickActions)
            .padding(.top, 22)
        QuickActionGrid(
            onJournal: openJournal,
            onErp: { navigation.select(.erp) },
            onExposureTools: { navigation.select(.erp) },
            onInsights: { navigation.select(.insights) }
        )
        .padding(.top, 10)
        DailyCheckInCard(checkedIn: data.journals.contains { $0.date == JournalEntry.dayKey(for: Date()) },
                         onTap: openJournal)
            .padding(.top, 14)
    }

    @ViewBuilder
    private func firstRun(_ data: ActivitySnapshot) -> some View {
        let strings = model.strings
        let primary = firstRunPrimary(strings)
        NextStepCard(copy: primary.copy, action: primary.action)
            .padding(.top, 18)
        HomeSectionHeader(title: strings.todayChooseActivity)
            .padding(.top, 22)
        VStack(spacing: 10) {
            QuickActionTile(systemImage: "square.and.pencil", title: strings.todayWriteSomethingTitle,
                            subtitle: strings.todayWriteSomethingBody) {
                navigation.push(.ocdEvent(entryID: nil, type: .obsession))
            }
            QuickActionTile(systemImage: "hourglass", title: strings.todayDelayUrgeTitle,
                            subtitle: strings.todayDelayUrgeBody) { navigation.push(.compulsionDelay) }
            QuickActionTile(systemImage: "leaf", title: strings.todayPracticeErpTitle,
                            subtitle: strings.todayPracticeErpBody) { navigation.select(.erp) }
        }
        .padding(.top, 10)
        if data.ybocsAssessments.isEmpty {
            SelfCheckRow { openNextStep(.selfCheck) }
                .padding(.top, 18)
        }
        InsightsPlaceholder()
            .padding(.top, 18)
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

// MARK: - Cards

/// `_homeCardDecoration`: card fill, hairline and a soft drop shadow.
private struct HomeCard: ViewModifier {
    var radius: CGFloat
    @Environment(\.colorScheme) private var scheme

    func body(content: Content) -> some View {
        content
            .background(AppColors.card, in: .rect(cornerRadius: radius))
            .overlay(RoundedRectangle(cornerRadius: radius).strokeBorder(AppColors.border))
            .shadow(color: .black.opacity(scheme == .dark ? 0.28 : 0.08), radius: 12, y: 12)
    }
}

private extension View {
    func homeCard(radius: CGFloat = 20) -> some View { modifier(HomeCard(radius: radius)) }
}

private struct UsesLargeText {
    /// Flutter's `_usesLargeText`: text scale of 1.5 or more.
    static func check(_ size: DynamicTypeSize) -> Bool { size >= .accessibility1 }
}

private struct CalmActivityCard: View {
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
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: "leaf").foregroundStyle(AppColors.accent)
                    Text(strings.calmRecentActivityTitle)
                        .textRole(.titleMedium, weight: .heavy, color: AppColors.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right").foregroundStyle(AppColors.textSecondary)
                }
                if facts.isEmpty {
                    Text(strings.calmNoRecentActivity).textRole(.bodyMedium, color: AppColors.textPrimary)
                } else {
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(facts, id: \.self) { fact in
                            HStack(alignment: .firstTextBaseline, spacing: 8) {
                                Circle().fill(AppColors.textPrimary).frame(width: 5, height: 5)
                                    .alignmentGuide(.firstTextBaseline) { $0[.bottom] + 4 }
                                Text(fact).textRole(.bodyMedium, color: AppColors.textPrimary)
                            }
                        }
                    }
                }
            }
            .multilineTextAlignment(.leading)
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppColors.card, in: .rect(cornerRadius: 24))
        }
        .buttonStyle(PressScaleStyle(scale: 0.98))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.calmRecentActivityTitle)
        .accessibilityValue(facts.isEmpty ? strings.calmNoRecentActivity : facts.joined(separator: ", "))
        .accessibilityAddTraits(.isButton)
    }
}

private struct HomeScoreCard: View {
    let summary: RecoveryDashboard
    let enoughData: Bool
    let onTap: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        Button(action: onTap) {
            if enoughData { scored(strings) } else { placeholder(strings) }
        }
        .buttonStyle(PressScaleStyle(scale: 0.98))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(enoughData
            ? strings.todayScoreA11y(score: summary.recoveryScore, label: label(strings))
            : strings.todayPracticeProgress)
        .accessibilityHint(strings.todayInsightsBody)
        .accessibilityAddTraits(.isButton)
    }

    private func eyebrow(_ strings: Strings) -> some View {
        Text(strings.todayPracticeProgress.uppercased(with: strings.locale))
            .font(.sans(11, .black, relativeTo: .caption))
            .tracking(0.6)
            .foregroundStyle(AppColors.accent)
    }

    private func scored(_ strings: Strings) -> some View {
        let details = VStack(alignment: .leading, spacing: 0) {
            eyebrow(strings)
            Text(summary.hasAnyData ? strings.todaySteadyPractice : strings.todayStartGently)
                .font(.sans(18, .heavy, relativeTo: .headline))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.top, 12)
            Text(summary.hasAnyData ? strings.todayPracticeActiveBody : strings.todayPracticeEmptyBody)
                .font(.sans(13, relativeTo: .footnote))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 6)
            Text(deltaText(strings))
                .font(.sans(12, .heavy, relativeTo: .caption))
                .foregroundStyle(AppColors.accent)
                .padding(.top, 14)
        }
        let ring = ScoreRing(score: summary.recoveryScore, label: label(strings))
        return VStack(alignment: .leading, spacing: 14) {
            if UsesLargeText.check(typeSize) {
                VStack(alignment: .leading, spacing: 16) { ring; details }
            } else {
                HStack(spacing: 18) {
                    ring
                    details.frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right").foregroundStyle(AppColors.textSecondary)
                }
            }
            Text(strings.todayProgressDisclaimer)
                .font(.sans(11, relativeTo: .caption2))
                .foregroundStyle(AppColors.textSecondary.opacity(0.8))
        }
        .multilineTextAlignment(.leading)
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .homeCard(radius: 22)
    }

    private func placeholder(_ strings: Strings) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            eyebrow(strings)
            Text(strings.todayProgressStartedTitle)
                .font(.sans(18, .heavy, relativeTo: .headline))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.top, 12)
            Text(strings.todayProgressPendingBody)
                .font(.sans(13, relativeTo: .footnote))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 6)
        }
        .multilineTextAlignment(.leading)
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .homeCard(radius: 22)
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
        let rounded = Int(summary.scoreDelta.rounded())
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
            Circle().stroke(AppColors.border, lineWidth: 8)
            Circle()
                .trim(from: 0, to: CGFloat(min(max(score, 0), 100)) / 100)
                .stroke(AngularGradient(colors: [AppColors.accent, Color(red: 1, green: 0.914, blue: 0.58), AppColors.accent],
                                        center: .center),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 4) {
                Text("\(score)").font(.system(size: 31, weight: .heavy)).foregroundStyle(AppColors.textPrimary)
                Text(label).font(.sans(11, .heavy)).foregroundStyle(AppColors.accent)
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

private struct NextStepCard: View {
    let copy: NextStepCopy
    let action: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.colorScheme) private var scheme
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let large = UsesLargeText.check(typeSize)
        VStack(alignment: .leading, spacing: 0) {
            Text(model.strings.todayNextStep.uppercased(with: model.strings.locale))
                .font(.sans(11, .black, relativeTo: .caption))
                .tracking(0.6)
                .foregroundStyle(AppColors.accent)
            Text(copy.title)
                .font(.sans(18, .heavy, relativeTo: .headline))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.top, 10)
            Text(copy.subtitle)
                .font(.sans(13, relativeTo: .footnote))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 6)
            Button(copy.cta, action: action)
                .buttonStyle(CompactPrimaryButtonStyle(radius: 16, horizontalPadding: large ? 12 : 18, fullWidth: large))
                .padding(.top, 14)
                // The whole card is the button for VoiceOver.
                .accessibilityHidden(true)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing),
                    in: .rect(cornerRadius: 22))
        .overlay(RoundedRectangle(cornerRadius: 22).strokeBorder(AppColors.accent.opacity(0.35)))
        .contentShape(.rect(cornerRadius: 22))
        .onTapGesture(perform: action)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(copy.title)
        .accessibilityHint(copy.subtitle)
        .accessibilityAddTraits(.isButton)
        .accessibilityAction(.default, action)
    }

    /// `nextStepCardGradientColors`.
    private var gradient: [Color] {
        if scheme == .dark {
            return [Color(red: 0x23 / 255, green: 0x20 / 255, blue: 0x0F / 255),
                    Color(red: 0x15 / 255, green: 0x14 / 255, blue: 0x0F / 255)]
        }
        let accent = UIColor(rgb: 0x8A6500), card = UIColor(rgb: 0xFFFCF6)
        return [Color(accent.blended(over: card, alpha: 0.12)), AppColors.card]
    }
}

private struct ProProgressionCard: View {
    let onTap: () -> Void
    let onDismiss: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        HStack(spacing: 12) {
            Button(action: onTap) {
                HStack(spacing: 12) {
                    Image(systemName: "leaf")
                        .font(.system(size: 18))
                        .foregroundStyle(AppColors.accent)
                        .frame(width: 42, height: 42)
                        .background(AppColors.accent.opacity(0.14), in: .circle)
                    VStack(alignment: .leading, spacing: 3) {
                        Text(strings.todayProTitle).textRole(.titleSmall, weight: .heavy, color: AppColors.textPrimary)
                        Text(strings.todayProBody)
                            .font(.sans(12.5, relativeTo: .footnote))
                            .foregroundStyle(AppColors.textSecondary)
                    }
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .buttonStyle(PressScaleStyle(scale: 0.98))
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel(strings.todayHideSevenDays)
        }
        .padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 8))
        .background(AppColors.card, in: .rect(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(AppColors.accent.opacity(0.55)))
    }
}

private struct HomeSectionHeader: View {
    let title: String
    var actionLabel: String?
    var onAction: (() -> Void)?

    var body: some View {
        HStack {
            Text(title)
                .font(.sans(17, .heavy, relativeTo: .headline))
                .foregroundStyle(AppColors.textPrimary)
                .accessibilityAddTraits(.isHeader)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let actionLabel, let onAction {
                Button(actionLabel, action: onAction)
                    .font(.sans(12, .heavy, relativeTo: .caption))
                    .foregroundStyle(AppColors.accent)
                    .frame(minWidth: 44, minHeight: 44)
            }
        }
    }
}

private struct ContinuePracticeCard: View {
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
            Circle().stroke(AppColors.border, lineWidth: 5)
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
            .tint(AppColors.accent)
            .scaleEffect(y: 1.5)
        let timeText = Text("\(elapsed) / \(planned)")
            .font(.sans(12, .bold, relativeTo: .caption))
            .foregroundStyle(AppColors.textSecondary)

        let details = VStack(alignment: .leading, spacing: 0) {
            Text(session == nil ? strings.todayStartErp : strings.todayCompulsionDelay)
                .font(.sans(16, .heavy, relativeTo: .headline))
                .foregroundStyle(AppColors.textPrimary)
            Text(session == nil ? strings.todayBuildToleranceBody : strings.todayResistUrgeBody)
                .font(.sans(12, relativeTo: .caption))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 4)
            Group {
                if large {
                    VStack(alignment: .leading, spacing: 8) { bar; timeText }
                } else {
                    HStack(spacing: 8) { bar; timeText }
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(timerLabel)
            .padding(.top, 10)
        }
        let action = Button(session == nil ? strings.todayStartAction : strings.todayResumeAction, action: onResume)
            .buttonStyle(CompactPrimaryButtonStyle(fullWidth: large))

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
        .padding(16)
        .homeCard(radius: 18)
    }

    static func format(_ seconds: Int) -> String {
        "\(seconds / 60):" + String(format: "%02d", seconds % 60)
    }
}

private struct QuickActionGrid: View {
    let onJournal: () -> Void
    let onErp: () -> Void
    let onExposureTools: () -> Void
    let onInsights: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let s = model.strings
        let journal = QuickActionTile(systemImage: "square.and.pencil", title: s.navJournal, subtitle: s.todayJournalBody, action: onJournal)
        let erp = QuickActionTile(systemImage: "scope", title: s.todayStartErp, subtitle: s.todayBuildToleranceBody, action: onErp)
        let exposure = QuickActionTile(systemImage: "square.3.layers.3d", title: s.todayExposureTools,
                                       subtitle: s.todayExposureToolsBody, action: onExposureTools)
        let insights = QuickActionTile(systemImage: "chart.bar", title: s.navInsights, subtitle: s.todayInsightsBody, action: onInsights)
        if UsesLargeText.check(typeSize) {
            VStack(spacing: 10) { journal; erp; exposure; insights }
        } else {
            Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                GridRow { journal; erp }
                GridRow { exposure; insights }
            }
        }
    }
}

private struct QuickActionTile: View {
    let systemImage: String
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: systemImage)
                    .font(.system(size: 22))
                    .foregroundStyle(AppColors.accent)
                    .frame(width: 27)
                VStack(alignment: .leading, spacing: 7) {
                    Text(title)
                        .font(.sans(14, .heavy, relativeTo: .subheadline))
                        .foregroundStyle(AppColors.textPrimary)
                    Text(subtitle)
                        .font(.sans(11.5, relativeTo: .caption))
                        .foregroundStyle(AppColors.textSecondary)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding(14)
            .frame(maxWidth: .infinity, minHeight: 98, alignment: .topLeading)
            .homeCard(radius: 16)
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityHint(subtitle)
        .accessibilityAddTraits(.isButton)
    }
}

/// `_SelfCheckRow`: the optional self-check on the first-run Today.
private struct SelfCheckRow: View {
    let action: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "list.clipboard").font(.system(size: 19)).foregroundStyle(AppColors.textSecondary)
                VStack(alignment: .leading, spacing: 4) {
                    Text(strings.todaySelfCheckTitle).font(.sans(14, .bold, relativeTo: .subheadline))
                        .foregroundStyle(AppColors.textPrimary)
                    Text(strings.todaySelfCheckDuration).font(.sans(12, relativeTo: .caption))
                        .foregroundStyle(AppColors.textSecondary)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right").font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding(14)
            .homeCard(radius: 16)
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.todaySelfCheckTitle)
        .accessibilityHint(strings.todaySelfCheckDuration)
        .accessibilityAddTraits(.isButton)
    }
}

private struct InsightsPlaceholder: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "chart.xyaxis.line").font(.system(size: 18))
                .foregroundStyle(AppColors.textSecondary.opacity(0.8))
                .accessibilityHidden(true)
            Text(model.strings.todayInsightsPlaceholder)
                .font(.sans(13, relativeTo: .footnote))
                .foregroundStyle(AppColors.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .homeCard(radius: 16)
    }
}

private struct DailyCheckInCard: View {
    let checkedIn: Bool
    let onTap: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        let large = UsesLargeText.check(typeSize)
        let details = VStack(alignment: .leading, spacing: 4) {
            Text(checkedIn ? strings.todayDailyCheckInComplete : strings.todayDailyCheckIn)
                .font(.sans(16, .heavy, relativeTo: .headline))
                .foregroundStyle(AppColors.textPrimary)
            Text(checkedIn ? strings.todayDailyCompleteBody : strings.todayDailyBody)
                .font(.sans(12, relativeTo: .caption))
                .foregroundStyle(AppColors.textSecondary)
        }
        let action = Button(checkedIn ? strings.todayOpenAction : strings.todayCheckInAction, action: onTap)
            .buttonStyle(CompactPrimaryButtonStyle(horizontalPadding: 14, fullWidth: large))
        Group {
            if large {
                VStack(alignment: .leading, spacing: 14) { details; action }
            } else {
                HStack(spacing: 14) {
                    Image(systemName: "leaf.fill")
                        .foregroundStyle(AppColors.positive)
                        .frame(width: 52, height: 52)
                        .background(AppColors.positive.opacity(0.12), in: .circle)
                        .accessibilityHidden(true)
                    details.frame(maxWidth: .infinity, alignment: .leading)
                    action
                }
            }
        }
        .padding(16)
        .homeCard(radius: 18)
    }
}
