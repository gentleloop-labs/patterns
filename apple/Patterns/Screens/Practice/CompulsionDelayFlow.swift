import PatternsCore
import SwiftUI

/// `CompulsionDelayFlow` from `lib/mobile/screens/compulsion_delay_screen.dart`:
/// name the urge, choose how long to sit with it, ride out a calm countdown,
/// then reflect. Stopping early is always allowed and never scolded.
struct CompulsionDelayFlow: View {
    /// First-run mode: a short two-minute default, no notification ask at
    /// the start (the result screen owns that), and a save leads to the
    /// first-run result instead of the completion sheet.
    var firstRun = false

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.scenePhase) private var scenePhase

    private enum Phase { case setup, countdown, reflection }
    @State private var phase = Phase.setup

    // Setup
    @State private var compulsion = ""
    @State private var urgeBefore: Double = 5
    @State private var plannedSeconds = 5 * 60
    @State private var custom = false
    @State private var customMinutes: Double = 10
    @State private var suggestions: Loadable<[OcdEntry]> = .loading

    // Countdown
    @State private var startedAt: Date?
    @State private var endsAt: Date?
    @State private var notificationScheduled = false
    @State private var confirmingStop = false
    @State private var finishHaptic = 0

    // Reflection
    @State private var urgeAfter: Double = 5
    @State private var outcome: DelayOutcome?
    @State private var note = ""
    @State private var completed = false
    @State private var actualSeconds = 0
    @State private var saving = false

    var body: some View {
        Group {
            switch phase {
            case .setup: setup
            case .countdown: countdown
            case .reflection: reflection
            }
        }
        .animation(.default, value: phase)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(phase != .setup)
        .sensoryFeedback(.success, trigger: finishHaptic)
        .onAppear { if firstRun && phase == .setup { plannedSeconds = 2 * 60 } }
        .onChange(of: scenePhase) { _, newPhase in handleScenePhase(newPhase) }
        .onDisappear { if phase == .countdown { cancelNotification() } }
    }

    // MARK: Setup

    private var setup: some View {
        let strings = model.strings
        return Form {
            SectionIntroSection(id: "compulsionDelay")
            Section(strings.delayUrgeQuestion) {
                TextField(strings.delayUrgeQuestion, text: $compulsion, prompt: Text(strings.delayUrgeHint), axis: .vertical)
                    .lineLimit(1...3)
                if !recentCompulsions.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(recentCompulsions, id: \.self) { text in
                                let selected = compulsion.trimmingCharacters(in: .whitespaces).lowercased() == text.lowercased()
                                Button(text) { compulsion = text }
                                    .buttonStyle(.bordered)
                                    .buttonBorderShape(.capsule)
                                    .tint(selected ? AppColors.accent : .secondary)
                                    .accessibilityAddTraits(selected ? .isSelected : [])
                            }
                        }
                        .padding(.vertical, 2)
                    }
                    .scrollClipDisabled()
                }
            }
            .listRowBackground(AppColors.card)

            ScaleSliderSection(label: strings.delayUrgeBeforeLabel, value: $urgeBefore) { strings.delayUrgeValue(value: $0) }

            Section(strings.delayDurationQuestion) {
                Picker(strings.delayDurationGroupLabel, selection: durationSelection) {
                    ForEach([60, 300, 900], id: \.self) { seconds in
                        Text(strings.delayMinutes(count: seconds / 60)).tag(seconds)
                    }
                    Text(strings.delayCustomAction).tag(-1)
                }
                .adaptiveSegmented()
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                if custom {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(strings.delayCustomTitle)
                            Spacer()
                            Text(strings.delayMinutes(count: Int(customMinutes.rounded())))
                                .font(.headline.monospacedDigit())
                                .foregroundStyle(AppColors.accent)
                        }
                        .accessibilityHidden(true)
                        Slider(value: $customMinutes, in: 1...60, step: 1)
                            .accessibilityLabel(strings.delayCustomTitle)
                            .accessibilityValue(strings.delayCustomMinutesValue(count: Int(customMinutes.rounded())))
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(AppColors.card)
                }
            }
        }
        .appListBackground()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(strings.delaySetupTitle)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button(action: begin) {
                Text(strings.delayBeginAction).frame(maxWidth: .infinity)
            }
            .buttonStyle(.accentProminent)
            .controlSize(.large)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
        .liveQuery(model.database, into: $suggestions) { db in try OcdEntry.all().fetchAll(db) }
    }

    private var durationSelection: Binding<Int> {
        Binding(get: { custom ? -1 : plannedSeconds }, set: { value in
            if value == -1 {
                custom = true
            } else {
                custom = false
                plannedSeconds = value
            }
        })
    }

    /// Up to six distinct compulsions from the tracker, newest first.
    private var recentCompulsions: [String] {
        var seen = Set<String>(), out: [String] = []
        for entry in suggestions.value ?? [] where entry.type == .compulsion {
            let text = entry.content.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !text.isEmpty, seen.insert(text.lowercased()).inserted else { continue }
            out.append(text)
            if out.count == 6 { break }
        }
        return out
    }

    // MARK: Countdown

    private var countdown: some View {
        let strings = model.strings
        return VStack(spacing: 0) {
            Text(strings.delayCountdownBody)
                .font(.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 8)
            Spacer()
            if let startedAt, let endsAt {
                CountdownRing(startedAt: startedAt, endsAt: endsAt)
            }
            Spacer()
            Button(role: .destructive) { confirmingStop = true } label: {
                Text(strings.delayStopAction).frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            // An alert, not a popover: "Keep going" must always be offered.
            .alert(strings.delayStopEarlyTitle, isPresented: $confirmingStop) {
                Button(strings.delayKeepGoingAction, role: .cancel) {}
                Button(strings.delayStopAction, role: .destructive) { finishTimer(completed: false) }
            } message: {
                Text(strings.delayStopEarlyBody)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.surface)
        .navigationTitle(strings.delayCountdownTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task(id: endsAt) {
            guard let endsAt else { return }
            try? await Task.sleep(until: .now + .seconds(max(0, endsAt.timeIntervalSinceNow)), clock: .continuous)
            if !Task.isCancelled, phase == .countdown, Date() >= endsAt { finishTimer(completed: true) }
        }
    }

    // MARK: Reflection

    private var reflection: some View {
        let strings = model.strings
        return Form {
            Section {
                Text(strings.delayReflectionStatus(status: completed ? "completed" : "early"))
                    .font(.body)
                    .listRowBackground(AppColors.card)
            }
            ScaleSliderSection(label: strings.delayUrgeAfterLabel, value: $urgeAfter) { strings.delayUrgeValue(value: $0) }
            Section(strings.delayOutcomeQuestion) {
                Picker(strings.delayOutcomeGroupLabel, selection: $outcome) {
                    ForEach(DelayOutcome.allCases, id: \.self) { value in
                        Text(strings.delayOutcome(outcome: value.wireName)).tag(DelayOutcome?.some(value))
                    }
                }
                .adaptiveSegmented()
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            Section(strings.delayNoteLabel) {
                TextField(strings.delayNoteLabel, text: $note, prompt: Text(strings.delayNoteHint), axis: .vertical)
                    .lineLimit(3...6)
                    .listRowBackground(AppColors.card)
            }
        }
        .appListBackground()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(strings.delayReflectionTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(saving ? strings.delaySavingAction : strings.delaySaveAction, action: save)
                    .fontWeight(.semibold)
                    .disabled(saving)
            }
        }
    }

    // MARK: Actions

    private func begin() {
        let strings = model.strings
        guard !compulsion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            navigation.showToast(strings.delayNameUrgeValidation, kind: .info)
            return
        }
        if custom { plannedSeconds = Int(customMinutes.rounded()) * 60 }
        // Phase 5: AppEvents.logFirstCompulsionDelayStarted (the urge's text is never sent).
        urgeAfter = urgeBefore
        let now = Date()
        startedAt = now
        endsAt = now.addingTimeInterval(TimeInterval(plannedSeconds))
        notificationScheduled = false
        // First run holds the permission ask for the result screen.
        if !firstRun { Task { _ = await Reminders.requestPermission() } }
        phase = .countdown
    }

    private func finishTimer(completed: Bool, haptic: Bool = true) {
        guard phase == .countdown else { return }
        let elapsed = startedAt.map { Int(Date().timeIntervalSince($0)) } ?? 0
        actualSeconds = completed ? plannedSeconds : min(max(elapsed, 0), plannedSeconds)
        self.completed = completed
        startedAt = nil
        endsAt = nil
        cancelNotification()
        if completed && haptic { finishHaptic += 1 }
        phase = .reflection
    }

    /// Leaving the app mid-countdown schedules the "time is up" notification;
    /// coming back cancels it and catches the timer up with the clock.
    private func handleScenePhase(_ newPhase: ScenePhase) {
        guard phase == .countdown, let endsAt else { return }
        switch newPhase {
        case .active:
            if Date() >= endsAt {
                // The notification already said it; no second buzz.
                finishTimer(completed: true, haptic: !notificationScheduled)
            } else {
                cancelNotification()
            }
        case .inactive, .background:
            let strings = model.strings
            Task {
                notificationScheduled = await Reminders.schedulePracticeTimer(
                    id: Reminders.pauseTimerID, endsAt: endsAt,
                    title: strings.practiceWindowCompleteTitle, body: strings.practiceWindowCompleteBody
                )
            }
        @unknown default:
            break
        }
    }

    private func cancelNotification() {
        notificationScheduled = false
        Reminders.cancelPracticeTimer(id: Reminders.pauseTimerID)
    }

    private func save() {
        let strings = model.strings
        guard let outcome else {
            navigation.showToast(strings.delayOutcomeValidation, kind: .info)
            return
        }
        saving = true
        let trimmedNote = note.trimmingCharacters(in: .whitespacesAndNewlines)
        let session = DelaySession(
            compulsion: compulsion.trimmingCharacters(in: .whitespacesAndNewlines),
            plannedSeconds: plannedSeconds,
            actualSeconds: actualSeconds,
            completed: completed,
            urgeBefore: Int(urgeBefore.rounded()),
            urgeAfter: Int(urgeAfter.rounded()),
            outcome: outcome,
            note: trimmedNote.isEmpty ? nil : trimmedNote,
            createdAt: DartTimestamp.now()
        )
        do {
            try model.database.insertDelaySession(session)
        } catch {
            saving = false
            navigation.showToast(strings.delaySaveError, kind: .error)
            return
        }
        model.prefs.recordMeaningfulAction(.compulsionDelay)
        // Phase 5: AppEvents.logFirstCompulsionDelayCompleted.
        model.prefs.recordReviewPracticeCompleted()
        if firstRun {
            navigation.finishFirstRun(.urge)
        } else {
            navigation.completeActivity(.compulsionDelay)
        }
    }
}
