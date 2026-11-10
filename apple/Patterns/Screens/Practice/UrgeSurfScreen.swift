import PatternsCore
import SwiftUI

/// `UrgeSurfScreen` from `lib/mobile/screens/urge_surf_screen.dart`: start
/// a surf and see past ones. A Pro tool.
struct UrgeSurfScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var sessions: Loadable<[UrgeSurfSession]> = .loading

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.urgeSurfText(key: key) }
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "urgeSurf")
            Section(text("historyTitle")) {
                switch sessions {
                case .loading:
                    ProgressView().frame(maxWidth: .infinity)
                case .failed:
                    Text(text("loadError")).foregroundStyle(.secondary)
                case let .loaded(items) where items.isEmpty:
                    Text(text("emptyHistory")).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                case let .loaded(items):
                    ForEach(items, id: \.id) { SurfRow(session: $0) }
                }
            }
            .listRowBackground(AppColors.card)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(text("title"))
        .safeAreaInset(edge: .bottom) {
            Button { navigation.push(.urgeSurfFlow(record: true)) } label: {
                Label(text("startAction"), systemImage: "water.waves").frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
        .liveQuery(model.database, into: $sessions) { db in try UrgeSurfSession.all().fetchAll(db) }
    }
}

private struct SurfRow: View {
    let session: UrgeSurfSession
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let trigger = session.trigger.isEmpty ? strings.urgeSurfText(key: "triggerFallback") : session.trigger
        let duration = strings.urgeSurfRecordedDuration(minutes: session.durationSeconds / 60, seconds: session.durationSeconds % 60)
        let summary = strings.urgeSurfHistorySummary(initial: session.initialUrge, peak: session.peakUrge,
                                                     finalLevel: session.finalUrge, duration: duration)
        let date = session.datetime.date().map(strings.dates.monthDay) ?? ""
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(trigger).font(.headline)
                Spacer()
                Text(date).font(.footnote).foregroundStyle(Color(.secondaryLabel))
            }
            Text(summary).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.urgeSurfSessionSemantics(trigger: trigger, date: date, summary: summary))
    }
}

/// `UrgeSurfFlow`: name the trigger, rate the urge, watch it for one to
/// five minutes while noting where it is, then reflect. From the free
/// support screen it runs without recording (`record: false`).
struct UrgeSurfFlow: View {
    let record: Bool

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    private enum Phase { case setup, surfing, reflection }
    @State private var phase = Phase.setup
    @State private var trigger = ""
    @State private var note = ""
    @State private var initialUrge: Double = 6
    @State private var currentUrge: Double = 6
    @State private var finalUrge: Double = 4
    @State private var peakUrge = 6
    @State private var plannedSeconds = 180
    @State private var startedAt: Date?
    @State private var endsAt: Date?
    @State private var actualSeconds = 0
    @State private var saving = false
    @State private var finishHaptic = 0

    var body: some View {
        Group {
            switch phase {
            case .setup: setup
            case .surfing: surfing
            case .reflection: reflection
            }
        }
        .animation(.default, value: phase)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(phase != .setup)
        .sensoryFeedback(.success, trigger: finishHaptic)
    }

    private func text(_ key: String) -> String { model.strings.urgeSurfText(key: key) }

    // MARK: Phases

    private var setup: some View {
        let strings = model.strings
        return Form {
            Section(text("triggerLabel")) {
                TextField(text("triggerLabel"), text: $trigger, prompt: Text(text("triggerHint")), axis: .vertical)
                    .lineLimit(1...3)
                    .listRowBackground(AppColors.card)
            }
            ScaleSliderSection(label: text("initialUrgeLabel"), value: $initialUrge) { strings.urgeSurfRating(value: $0) }
            Section(text("durationQuestion")) {
                Picker(text("durationQuestion"), selection: $plannedSeconds) {
                    ForEach([60, 180, 300], id: \.self) { Text(strings.urgeSurfDuration(minutes: $0 / 60)).tag($0) }
                }
                .pickerStyle(.segmented)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
        }
        .appListBackground()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(text("setupTitle"))
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button(action: begin) {
                Text(text("begin")).frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
    }

    private var surfing: some View {
        let strings = model.strings
        return Form {
            Section {
            } header: {
                VStack(spacing: 18) {
                    Text(text("surfingBody"))
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                        .multilineTextAlignment(.center)
                    if let startedAt, let endsAt {
                        CountdownRing(startedAt: startedAt, endsAt: endsAt)
                    }
                }
                .frame(maxWidth: .infinity)
                .textCase(nil)
                .padding(.bottom, 8)
            }
            ScaleSliderSection(label: text("currentUrgeLabel"), value: $currentUrge) { strings.urgeSurfRating(value: $0) }
                .onChange(of: currentUrge) { _, value in peakUrge = max(peakUrge, Int(value.rounded())) }
        }
        .appListBackground()
        .navigationTitle(text("surfingTitle"))
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button { finish(completed: false) } label: {
                Text(text("doneAction")).frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
        .task(id: endsAt) {
            guard let endsAt else { return }
            try? await Task.sleep(until: .now + .seconds(max(0, endsAt.timeIntervalSinceNow)), clock: .continuous)
            if !Task.isCancelled, phase == .surfing { finish(completed: true) }
        }
    }

    private var reflection: some View {
        let strings = model.strings
        return Form {
            Section(text("waveTitle")) {
                Text(strings.urgeSurfWaveSummary(initial: Int(initialUrge.rounded()), peak: peakUrge))
                    .font(.subheadline)
                    .listRowBackground(AppColors.card)
            }
            ScaleSliderSection(label: text("finalUrgeLabel"), value: $finalUrge) { strings.urgeSurfRating(value: $0) }
            Section(text("noteLabel")) {
                TextField(text("noteLabel"), text: $note, prompt: Text(text("noteHint")), axis: .vertical)
                    .lineLimit(2...5)
                    .listRowBackground(AppColors.card)
            }
        }
        .appListBackground()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(text("reflectionTitle"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(text(record ? "saveAction" : "finishAction"), action: save)
                    .fontWeight(.semibold)
                    .disabled(saving)
            }
        }
    }

    // MARK: Actions

    private func begin() {
        currentUrge = initialUrge
        peakUrge = Int(initialUrge.rounded())
        finalUrge = initialUrge
        let now = Date()
        startedAt = now
        endsAt = now.addingTimeInterval(TimeInterval(plannedSeconds))
        phase = .surfing
    }

    private func finish(completed: Bool) {
        guard phase == .surfing else { return }
        let elapsed = startedAt.map { Int(Date().timeIntervalSince($0).rounded()) } ?? 0
        actualSeconds = completed ? plannedSeconds : min(max(elapsed, 0), plannedSeconds)
        startedAt = nil
        endsAt = nil
        finishHaptic += 1
        phase = .reflection
        if completed {
            UIAccessibility.post(notification: .announcement, argument: text("timerComplete"))
        }
    }

    private func save() {
        saving = true
        if record {
            let now = DartTimestamp.now()
            let trimmedNote = note.trimmingCharacters(in: .whitespacesAndNewlines)
            let session = UrgeSurfSession(
                datetime: now, trigger: trigger.trimmingCharacters(in: .whitespacesAndNewlines),
                initialUrge: Int(initialUrge.rounded()), peakUrge: peakUrge, finalUrge: Int(finalUrge.rounded()),
                // Flutter records the planned time when nothing elapsed.
                durationSeconds: actualSeconds == 0 ? plannedSeconds : actualSeconds,
                note: trimmedNote.isEmpty ? nil : trimmedNote, createdAt: now
            )
            do {
                try model.database.insertUrgeSurfSession(session)
            } catch {
                saving = false
                navigation.showToast(text("saveError"), kind: .error)
                return
            }
        }
        navigation.pop()
        navigation.showToast(text(record ? "saveSuccess" : "finishSuccess"), kind: .success)
    }
}
