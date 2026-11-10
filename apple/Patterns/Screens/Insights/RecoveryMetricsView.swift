import PatternsCore
import SwiftUI

/// `RecoveryMetricsSection` from `lib/mobile/screens/recovery_metrics_screen.dart`:
/// the Pro metrics at the foot of Insights, or a teaser with the paywall.
struct RecoveryMetricsSection: View {
    let snapshot: ActivitySnapshot
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    var body: some View {
        let strings = model.strings
        if model.proUnlocked {
            RecoveryMetricsRows(snapshot: snapshot, header: strings.recoveryMetricsTitle)
        } else {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Image(systemName: "flame").font(.title2).foregroundStyle(AppColors.accent)
                    Text(strings.recoveryMetricsTeaserTitle).font(.headline)
                    Text(model.calmInsightsEnabled ? strings.recoveryMetricsCalmTeaserBody : strings.recoveryMetricsDetailedTeaserBody)
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                    Button(strings.recoveryMetricsUnlockPro) { navigation.presentPaywall(.recoveryMetrics) }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .padding(.top, 4)
                }
                .padding(.vertical, 6)
            } header: {
                HStack(spacing: 6) {
                    Text(strings.recoveryMetricsTitle)
                    Image(systemName: "lock.fill").font(.caption).foregroundStyle(AppColors.accent)
                        .accessibilityLabel(strings.recoveryProBadge)
                }
            }
            .listRowBackground(AppColors.card)
        }
    }
}

/// `RecoveryMetricsView`: streak, counts, average urge drop and this week.
/// Calm insights hides the streak and the week strip.
struct RecoveryMetricsRows: View {
    let snapshot: ActivitySnapshot
    var header: String?
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let metrics = RecoveryInsights.metrics(snapshot)
        let calm = model.calmInsightsEnabled
        Section {
            if !metrics.hasAnyData {
                VStack(alignment: .leading, spacing: 4) {
                    Text(strings.recoveryMetricsEmptyTitle).font(.headline)
                    Text(calm ? strings.recoveryMetricsCalmEmptyBody : strings.recoveryMetricsDetailedEmptyBody)
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                }
                .padding(.vertical, 4)
            } else {
                if !calm {
                    Label(strings.recoveryMetricsDayStreak(days: metrics.practiceStreakDays), systemImage: "flame.fill")
                        .font(.headline)
                        .labelStyle(AccentLabel())
                }
                metric("stairs", strings.recoveryMetricsExposuresDone, strings.dates.integer(metrics.exposuresCompleted))
                metric("figure.mind.and.body", strings.recoveryMetricsSessionsPracticed, strings.dates.integer(metrics.sessionsPracticed))
                metric("arrow.down.right", strings.recoveryMetricsAverageUrgeDrop, strings.dates.oneDecimal(metrics.avgUrgeReduction))
                if !calm {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(strings.recoveryMetricsThisWeek).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                        HStack(spacing: 8) {
                            ForEach(Array(metrics.weeklyActivity.enumerated()), id: \.offset) { offset, active in
                                let day = Calendar.current.date(byAdding: .day, value: offset - 6, to: Date()) ?? Date()
                                VStack(spacing: 4) {
                                    Circle()
                                        .fill(active ? AppColors.accent : Color(.systemFill))
                                        .frame(width: 26, height: 26)
                                    Text(strings.dates.shortWeekday(day)).font(.caption2).foregroundStyle(Color(.secondaryLabel))
                                }
                                .frame(maxWidth: .infinity)
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel(strings.dates.shortWeekday(day))
                                .accessibilityAddTraits(active ? .isSelected : [])
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        } header: {
            if let header { Text(header) }
        }
        .listRowBackground(AppColors.card)
    }

    private func metric(_ icon: String, _ label: String, _ value: String) -> some View {
        HStack {
            Label(label, systemImage: icon).labelStyle(AccentLabel())
            Spacer()
            Text(value).font(.title3.weight(.bold).monospacedDigit())
        }
        .accessibilityElement(children: .combine)
    }
}

/// An accent-coloured icon with a label-coloured title.
private struct AccentLabel: LabelStyle {
    func makeBody(configuration: LabelStyleConfiguration) -> some View {
        HStack(spacing: 10) {
            configuration.icon.foregroundStyle(AppColors.accent)
            configuration.title
        }
    }
}

/// `RecoveryMetricsScreen`: the same view on its own, from the Practice hub.
struct RecoveryMetricsScreen: View {
    @Environment(AppModel.self) private var model
    @State private var snapshot: Loadable<ActivitySnapshot> = .loading

    var body: some View {
        List {
            SectionIntroSection(id: "recoveryMetrics")
            if let data = snapshot.value {
                RecoveryMetricsRows(snapshot: data)
            } else {
                ProgressView().frame(maxWidth: .infinity).listRowBackground(Color.clear)
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(model.strings.recoveryMetricsTitle)
        .liveQuery(model.database, into: $snapshot) { db in try ActivitySnapshot.fetch(db) }
    }
}
