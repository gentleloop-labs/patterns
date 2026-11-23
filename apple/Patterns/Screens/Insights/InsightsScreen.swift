import Charts
import PatternsCore
import SwiftUI

/// `AnalyticsScreen` from `lib/mobile/screens/analytics_screen.dart`: the
/// Insights tab. Four views of the same range: overview, obsessions,
/// compulsions and ERP. Under calm insights it drops the score, deltas,
/// streaks and consistency, and keeps the plain counts.
struct InsightsScreen: View {
    private enum Tab: Hashable { case overview, thoughts, urges, erp }

    @Environment(AppModel.self) private var model
    @State private var snapshot: Loadable<ActivitySnapshot> = .loading
    @State private var range = RecoveryInsights.Range.thirty
    @State private var tab = Tab.overview
    @State private var exporting = false

    var body: some View {
        let strings = model.strings
        List {
            Section {
            } header: {
                Picker(strings.insightsTitle, selection: $tab) {
                    Text(strings.insightsOverviewTab).tag(Tab.overview)
                    Text(strings.insightsObsessionsTab).tag(Tab.thoughts)
                    Text(strings.insightsCompulsionsTab).tag(Tab.urges)
                    Text(strings.insightsErpTab).tag(Tab.erp)
                }
                .adaptiveSegmented()
                .textCase(nil)
                .padding(.horizontal, -16)
            }
            switch snapshot {
            case .loading:
                ProgressView().frame(maxWidth: .infinity).listRowBackground(Color.clear)
                    .accessibilityLabel(strings.insightsLoading)
            case .failed:
                Text(strings.insightsLoadError).foregroundStyle(AppColors.textSecondary).listRowBackground(AppColors.card)
            case let .loaded(data):
                content(data, strings)
            }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(16)
        .appListBackground()
        .navigationTitle(strings.insightsTitle)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(strings.insightsExportReport, systemImage: "square.and.arrow.up") { exporting = true }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Picker(strings.insightsChangeRange, selection: $range) {
                        Text(strings.rangeLastSevenDays).tag(RecoveryInsights.Range.seven)
                        Text(strings.rangeLastThirtyDays).tag(RecoveryInsights.Range.thirty)
                        Text(strings.rangeLastNinetyDays).tag(RecoveryInsights.Range.ninety)
                        Text(strings.rangeLastYear).tag(RecoveryInsights.Range.year)
                    }
                } label: {
                    // The range as text, so the current choice is visible.
                    HStack(spacing: 4) {
                        Text(rangeLabel(strings))
                        Image(systemName: "chevron.down").font(.caption.weight(.semibold))
                    }
                }
                .accessibilityLabel(strings.insightsChangeRange)
                .accessibilityValue(rangeLabel(strings))
            }
        }
        .liveQuery(model.database, into: $snapshot) { db in try ActivitySnapshot.fetch(db) }
        .task {
            // `analyticsLinger`: someone who stays with their progress for 20
            // seconds is at a calm, positive moment. Leaving cancels it.
            try? await Task.sleep(for: .seconds(20))
            guard !Task.isCancelled else { return }
            await model.reviews.maybeRequest(.analyticsLinger)
        }
        .sheet(isPresented: $exporting) { ExportReportSheet(initialRange: reportRange) }
    }

    /// The report opens on the range Insights is showing.
    private var reportRange: ReportRange {
        switch range {
        case .seven: .seven
        case .thirty: .thirty
        case .ninety: .ninety
        case .year: .year
        }
    }

    private func rangeLabel(_ s: Strings) -> String {
        switch range {
        case .seven: s.rangeSevenDays
        case .thirty: s.rangeThirtyDays
        case .ninety: s.rangeNinetyDays
        case .year: s.rangeYear
        }
    }

    @ViewBuilder
    private func content(_ data: ActivitySnapshot, _ strings: Strings) -> some View {
        let summary = RecoveryInsights.dashboard(data, rangeDays: range.rawValue)
        let calm = model.calmInsightsEnabled
        switch tab {
        case .overview:
            if calm {
                CalmActivitySection(summary: RecoveryInsights.calmInsights(data))
            } else {
                ScoreSection(summary: summary, enoughData: RecoveryInsights.hasEnoughForProgress(data))
            }
            MoodSection(summary: summary)
            YbocsSection(summary: summary)
            UrgeSection(summary: summary, wide: false)
            ErpSection(summary: summary, wide: false)
            if !calm { ConsistencySection(summary: summary) }
            ThemesSection(summary: summary)
            RecoveryMetricsSection(snapshot: data)
        case .thoughts:
            Section {
                KpiRow(label: strings.insightsObsessionsLogged, value: strings.dates.integer(summary.thoughts),
                       systemImage: "brain.head.profile")
                KpiRow(label: strings.insightsThemesFound, value: strings.dates.integer(summary.topThemes.count),
                       systemImage: "tag")
            }
            .listRowBackground(AppColors.card)
            YbocsSection(summary: summary)
            ThemesSection(summary: summary)
            MoodSection(summary: summary)
        case .urges:
            Section {
                KpiRow(label: strings.insightsCompulsions, value: strings.dates.integer(summary.compulsions),
                       systemImage: "scope")
                KpiRow(label: strings.insightsAverageIntensityShort,
                       value: "\(strings.dates.oneDecimal(summary.averageUrge)) \(strings.insightsOutOfTenShort)",
                       systemImage: "chart.xyaxis.line", delta: calm ? nil : summary.urgeDelta,
                       comparison: strings.insightsComparedPreviousDays(count: summary.rangeDays))
            }
            .listRowBackground(AppColors.card)
            UrgeSection(summary: summary, wide: true)
            if !calm { ConsistencySection(summary: summary) }
        case .erp:
            ErpSection(summary: summary, wide: true)
            if !calm { ConsistencySection(summary: summary) }
            RecoveryMetricsSection(snapshot: data)
        }
    }
}

// MARK: - Building blocks

/// `_CardTitle` as a section header.
private struct CardHeader: View {
    let title: String
    var body: some View {
        Text(title).accessibilityAddTraits(.isHeader)
    }
}

/// `_DeltaLabel`: the change against the previous period, coloured by
/// meaning, with the arrow following the number.
struct DeltaLabel: View {
    let delta: InsightDelta
    let comparison: String
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let value = strings.dates.oneDecimal(abs(delta.value))
        let text = delta.value > 0 ? strings.insightsDeltaIncrease(value: value, comparison: comparison)
            : delta.value < 0 ? strings.insightsDeltaDecrease(value: value, comparison: comparison)
            : strings.insightsDeltaUnchanged(comparison: comparison)
        Text(text)
            .font(.footnote.weight(.semibold))
            .foregroundStyle(color)
    }

    private var color: Color {
        switch delta.tone {
        case .positive: AppColors.positive
        case .negative: AppColors.negative
        case .neutral: AppColors.textSecondary
        }
    }
}

/// `_MiniLineChart`: a smooth line with a soft fill.
private struct TrendChart: View {
    let title: String
    let points: [DashboardPoint]
    let yRange: ClosedRange<Double>
    var color: Color = AppColors.accent
    var moodColors = false
    var showsDates = false
    var height: CGFloat = 120
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Chart(points, id: \.date) { point in
            AreaMark(x: .value("Date", point.date), yStart: .value("Base", yRange.lowerBound), yEnd: .value("Value", point.value))
                .interpolationMethod(.catmullRom)
                .foregroundStyle(color.opacity(0.10))
            LineMark(x: .value("Date", point.date), y: .value("Value", point.value))
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 2.6, lineCap: .round))
                .foregroundStyle(moodColors
                    ? AnyShapeStyle(LinearGradient(colors: [AppColors.negative, AppColors.accent, AppColors.positive],
                                                   startPoint: .bottom, endPoint: .top))
                    : AnyShapeStyle(color))
        }
        .chartYScale(domain: yRange)
        .chartYAxis(.hidden)
        .chartXAxis(showsDates ? .automatic : .hidden)
        .frame(height: height)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.insightsChartSummary(
            title: title,
            values: points.map { strings.insightsChartPoint(date: strings.dates.monthDay($0.date),
                                                           value: strings.dates.oneDecimal($0.value)) }
                .joined(separator: ", ")))
    }
}

private struct KpiRow: View {
    let label: String
    let value: String
    let systemImage: String
    var delta: InsightDelta?
    var comparison = ""

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Image(systemName: systemImage).foregroundStyle(AppColors.accent).frame(width: 26)
            VStack(alignment: .leading, spacing: 2) {
                Text(label).font(.subheadline).foregroundStyle(AppColors.textSecondary)
                Text(value).font(.title2.weight(.bold).monospacedDigit())
                if let delta { DeltaLabel(delta: delta, comparison: comparison) }
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Sections

private struct CalmActivitySection: View {
    let summary: CalmInsightsSummary
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
        Section {
            Text(facts.isEmpty ? strings.calmNoRecentActivity : facts.joined(separator: ", "))
                .font(.subheadline)
                .foregroundStyle(AppColors.textSecondary)
        } header: {
            CardHeader(title: strings.calmRecentActivityTitle)
        }
        .listRowBackground(AppColors.card)
    }
}

/// `_RecoveryScoreCard`: no number until there is enough activity.
private struct ScoreSection: View {
    let summary: RecoveryDashboard
    let enoughData: Bool
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Section {
            if enoughData {
                VStack(alignment: .leading, spacing: 6) {
                    Text(strings.dates.wholePercent(summary.recoveryScore))
                        .font(.system(.largeTitle, design: .rounded, weight: .bold).monospacedDigit())
                    DeltaLabel(delta: summary.scoreDelta, comparison: strings.insightsComparedPreviousDays(count: summary.rangeDays))
                    TrendChart(title: strings.insightsPracticeProgress, points: summary.scoreTrend, yRange: 0...100, height: 90)
                        .padding(.top, 6)
                }
                .padding(.vertical, 4)
            } else {
                Text(summary.hasAnyData ? strings.insightsScoreNeedsMoreActivity : strings.insightsScoreEmpty)
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
            }
        } header: {
            CardHeader(title: strings.insightsPracticeProgress)
        } footer: {
            if enoughData { Text(strings.insightsPracticeProgressBoundary) }
        }
        .listRowBackground(AppColors.card)
    }
}

private struct MoodSection: View {
    let summary: RecoveryDashboard
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Section {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 14) {
                    legend(strings.insightsMoodGood, AppColors.positive)
                    legend(strings.insightsMoodOkay, AppColors.accent)
                    legend(strings.insightsMoodLow, AppColors.negative)
                }
                .accessibilityHidden(true)
                TrendChart(title: strings.insightsMoodOverTime, points: summary.moodTrend, yRange: 0...10,
                           moodColors: true, showsDates: true)
            }
            .padding(.vertical, 4)
        } header: {
            CardHeader(title: strings.insightsMoodOverTime)
        }
        .listRowBackground(AppColors.card)
    }

    private func legend(_ label: String, _ color: Color) -> some View {
        HStack(spacing: 5) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(label).font(.caption).foregroundStyle(AppColors.textSecondary)
        }
    }
}

/// `_YbocsCard`: one result invites a retake; two or more draw the line.
private struct YbocsSection: View {
    let summary: RecoveryDashboard
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Section {
            if let latest = summary.latestYbocs {
                let severity = latest.severity ?? .forScore(latest.totalScore)
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text(strings.dates.integer(latest.totalScore))
                            .font(.system(.largeTitle, design: .rounded, weight: .bold).monospacedDigit())
                        Text(strings.insightsOutOfFortyShort).foregroundStyle(AppColors.textSecondary)
                        Circle().fill(severity.color).frame(width: 9, height: 9).padding(.leading, 6)
                        Text(summary.hasYbocsTrend
                             ? strings.insightsYbocsSeverityRange(severity: severity.label(strings), range: severity.rangeText)
                             : severity.label(strings))
                            .font(.subheadline.weight(.semibold))
                    }
                    if summary.hasYbocsTrend {
                        if !model.calmInsightsEnabled {
                            DeltaLabel(delta: summary.ybocsDelta,
                                       comparison: strings.insightsAcrossSelfChecks(count: summary.ybocsTrend.count))
                        }
                        TrendChart(title: strings.insightsYbocsOverTime, points: summary.ybocsTrend, yRange: 0...40,
                                   color: severity.color, showsDates: true)
                            .padding(.top, 4)
                    } else {
                        Text(strings.insightsYbocsSingleResult(severity: severity.label(strings)))
                            .font(.subheadline)
                            .foregroundStyle(AppColors.textSecondary)
                    }
                }
                .padding(.vertical, 4)
            } else {
                Text(strings.insightsYbocsEmpty).font(.subheadline).foregroundStyle(AppColors.textSecondary)
            }
        } header: {
            CardHeader(title: strings.insightsYbocsOverTime)
        } footer: {
            Text(strings.insightsYbocsBoundary)
        }
        .listRowBackground(AppColors.card)
    }
}

private struct UrgeSection: View {
    let summary: RecoveryDashboard
    let wide: Bool
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Section {
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(strings.dates.oneDecimal(summary.averageUrge))
                        .font(.system(.largeTitle, design: .rounded, weight: .bold).monospacedDigit())
                    Text(strings.insightsOutOfTenShort).foregroundStyle(AppColors.textSecondary)
                }
                if !model.calmInsightsEnabled {
                    DeltaLabel(delta: summary.urgeDelta, comparison: strings.insightsComparedPreviousDays(count: summary.rangeDays))
                }
                TrendChart(title: strings.insightsAverageUrgeIntensity, points: summary.urgeTrend, yRange: 0...10,
                           showsDates: wide, height: wide ? 140 : 90)
                    .padding(.top, 4)
            }
            .padding(.vertical, 4)
        } header: {
            CardHeader(title: strings.insightsAverageUrgeIntensity)
        }
        .listRowBackground(AppColors.card)
    }
}

private struct ErpSection: View {
    let summary: RecoveryDashboard
    let wide: Bool
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Section {
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(strings.dates.integer(summary.erpPracticeCount))
                        .font(.system(.largeTitle, design: .rounded, weight: .bold).monospacedDigit())
                    Text(strings.insightsSessions(count: summary.erpPracticeCount)).foregroundStyle(AppColors.textSecondary)
                }
                if !model.calmInsightsEnabled {
                    DeltaLabel(delta: summary.erpDelta, comparison: strings.insightsComparedPreviousDays(count: summary.rangeDays))
                }
                // `_MiniBarChart`.
                Chart(summary.erpTrend, id: \.date) { point in
                    BarMark(x: .value("Date", point.date, unit: .day), y: .value("Sessions", point.value))
                        .foregroundStyle(AppColors.accent)
                        .cornerRadius(4)
                }
                .chartYAxis(.hidden)
                .chartXAxis(wide ? .automatic : .hidden)
                .frame(height: wide ? 140 : 90)
                .padding(.top, 4)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(strings.insightsChartSummary(
                    title: strings.insightsErpPractice,
                    values: summary.erpTrend.map { strings.insightsChartPoint(date: strings.dates.monthDay($0.date),
                                                                              value: strings.dates.integer(Int($0.value))) }
                        .joined(separator: ", ")))
            }
            .padding(.vertical, 4)
        } header: {
            CardHeader(title: strings.insightsErpPractice)
        }
        .listRowBackground(AppColors.card)
    }
}

/// `_ConsistencyCard`: active days and a dot map of the last month.
private struct ConsistencySection: View {
    let summary: RecoveryDashboard
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Section {
            HStack(alignment: .center, spacing: 18) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(strings.dates.wholePercent(summary.consistencyPercent))
                        .font(.system(.largeTitle, design: .rounded, weight: .bold).monospacedDigit())
                    Text(strings.insightsActiveDays(active: summary.activeDays, total: summary.rangeDays))
                        .font(.footnote)
                        .foregroundStyle(AppColors.textSecondary)
                }
                .fixedSize()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 10), spacing: 6) {
                    ForEach(Array(summary.consistencyHeatmap.enumerated()), id: \.offset) { _, active in
                        Circle()
                            .fill(active ? AppColors.accent : Color(.systemFill))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(strings.insightsActivityMapSummary(active: summary.activeDays, total: summary.rangeDays))
            }
            .padding(.vertical, 6)
        } header: {
            CardHeader(title: strings.insightsConsistency)
        }
        .listRowBackground(AppColors.card)
    }
}

private struct ThemesSection: View {
    let summary: RecoveryDashboard
    @Environment(AppModel.self) private var model

    /// `_themeColors`.
    private static let colors: [Color] = [
        AppColors.accent, Color(UIColor(rgb: 0xA13F3F)), Color(UIColor(rgb: 0xFF9F43)),
        Color(UIColor(rgb: 0x5CA7FF)), Color(UIColor(rgb: 0x407A52)),
    ]

    var body: some View {
        let strings = model.strings
        Section {
            if summary.topThemes.isEmpty {
                Text(strings.insightsThemesEmpty).font(.subheadline).foregroundStyle(AppColors.textSecondary)
            } else {
                ForEach(Array(summary.topThemes.enumerated()), id: \.offset) { index, theme in
                    let color = Self.colors[index % Self.colors.count]
                    let percent = Int((theme.percent * 100).rounded())
                    let label = Self.label(theme.label, strings)
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Label(label, systemImage: Self.icon(theme.label))
                                .labelStyle(.titleAndIcon)
                                .foregroundStyle(Color(.label))
                            Spacer()
                            Text(strings.dates.wholePercent(percent))
                                .font(.subheadline.weight(.semibold).monospacedDigit())
                        }
                        ProgressView(value: min(max(theme.percent, 0), 1)).tint(color)
                    }
                    .padding(.vertical, 4)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(strings.insightsThemeShare(theme: label, percent: percent))
                }
            }
        } header: {
            CardHeader(title: strings.insightsTopThemes)
        }
        .listRowBackground(AppColors.card)
    }

    static func label(_ id: String, _ s: Strings) -> String {
        switch id {
        case "Contamination": s.insightsThemeContamination
        case "Harm": s.insightsThemeHarm
        case "Checking": s.insightsThemeChecking
        case "Reassurance": s.insightsThemeReassurance
        case "Health": s.insightsThemeHealth
        case "Relationship": s.insightsThemeRelationship
        case "Symmetry": s.insightsThemeSymmetry
        case "Moral": s.insightsThemeMoral
        case "Rumination": s.insightsThemeRumination
        case "Uncertainty": s.insightsThemeUncertainty
        default: s.insightsThemeOther
        }
    }

    static func icon(_ id: String) -> String {
        switch id {
        case "Contamination": "drop"
        case "Harm": "exclamationmark.triangle"
        case "Checking": "checkmark.circle"
        case "Reassurance": "bubble.left.and.bubble.right"
        case "Health": "heart.text.square"
        case "Relationship": "heart"
        case "Symmetry": "square.grid.2x2"
        case "Moral": "scalemass"
        case "Rumination": "arrow.triangle.2.circlepath"
        case "Uncertainty": "questionmark.circle"
        default: "tag"
        }
    }
}

extension YbocsSeverity {
    /// `YbocsSeverityDisplay.range`.
    var rangeText: String {
        switch self {
        case .subclinical: "0–7"
        case .mild: "8–15"
        case .moderate: "16–23"
        case .severe: "24–31"
        case .extreme: "32–40"
        }
    }
}
