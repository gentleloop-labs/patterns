import PatternsCore
import SwiftUI

/// Opens a saved plan by id for `ErpPracticeFlow`.
struct ErpPracticeLoader: View {
    let planID: Int64
    @Environment(AppModel.self) private var model
    @State private var plan: ErpExercisePlan?

    var body: some View {
        Group {
            if let plan {
                ErpPracticeFlow(plan: plan)
            } else {
                ProgressView()
            }
        }
        .task {
            plan = try? model.database.queue.read { try ErpExercisePlan.fetchOne($0, key: planID) }
        }
    }
}

/// `ErpPlanPracticeFlow`: review the plan, rate the anxiety, sit through the
/// timer while holding the commitment, then reflect. Stopping early is
/// always allowed.
struct ErpPracticeFlow: View {
    let plan: ErpExercisePlan
    /// First-run mode: no notification ask at the start and a save leads to
    /// the first-run result.
    var firstRun = false

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.scenePhase) private var scenePhase

    private enum Phase { case setup, countdown, reflection }
    @State private var phase = Phase.setup
    @State private var anxietyBefore: Double = 5
    @State private var anxietyAfter: Double = 5
    @State private var startedAt: Date?
    @State private var endsAt: Date?
    @State private var notificationScheduled = false
    @State private var confirmingStop = false
    @State private var finishHaptic = 0
    @State private var outcome: DelayOutcome?
    @State private var whatHappened = ""
    @State private var learning = ""
    @State private var completed = false
    @State private var actualSeconds = 0
    @State private var saving = false

    private var title: String {
        ErpTemplate.displayTitle(exerciseID: plan.exerciseId, stored: plan.exerciseTitle, model.strings)
    }

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
        .onChange(of: scenePhase) { _, newPhase in handleScenePhase(newPhase) }
        .onDisappear { if phase == .countdown { cancelNotification() } }
    }

    // MARK: Setup

    private var setup: some View {
        let strings = model.strings
        return Form {
            PlanReviewSection(plan: plan)
            ScaleSliderSection(label: strings.erpFlowText(key: "anxietyBefore"), value: $anxietyBefore) {
                strings.erpIntensityValue(value: $0)
            }
            Section {
                LabeledContent(strings.erpFlowText(key: "duration"),
                               value: CountdownRing.format(TimeInterval(plan.defaultSeconds)))
                    .listRowBackground(AppColors.card)
            }
        }
        .appListBackground()
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button(action: begin) {
                Text(strings.erpFlowText(key: "start")).frame(maxWidth: .infinity)
            }
            .buttonStyle(.accentProminent)
            .controlSize(.large)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
    }

    // MARK: Countdown

    private var countdown: some View {
        let strings = model.strings
        return ScrollView {
            VStack(spacing: 24) {
                if let startedAt, let endsAt {
                    CountdownRing(startedAt: startedAt, endsAt: endsAt, caption: strings.erpFlowText(key: "countdownCue"))
                        .padding(.top, 24)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(strings.erpFlowText(key: "resisting"))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppColors.accent)
                    Text(plan.preventionCommitment)
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(AppColors.card, in: .rect(cornerRadius: 14))
                Text(strings.erpFlowText(key: "countdownBody"))
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 20)
        }
        .background(AppColors.surface)
        .safeAreaInset(edge: .bottom) {
            Button(role: .destructive) { confirmingStop = true } label: {
                Text(strings.erpFlowText(key: "stopEarly")).frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .alert(strings.erpFlowText(key: "stopTitle"), isPresented: $confirmingStop) {
                Button(strings.erpFlowText(key: "keepGoing"), role: .cancel) {}
                Button(strings.erpFlowText(key: "stop"), role: .destructive) { finishTimer(completed: false) }
            } message: {
                Text(strings.erpFlowText(key: "stopBody"))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
        .navigationTitle(title)
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
                VStack(alignment: .leading, spacing: 6) {
                    Text(strings.erpReflectionStatus(status: completed ? "completed" : "early"))
                        .font(.title3.weight(.semibold))
                    Text(strings.erpFlowText(key: "reflectionBody"))
                        .font(.subheadline)
                        .foregroundStyle(AppColors.textSecondary)
                }
                .padding(.vertical, 4)
                .listRowBackground(AppColors.card)
            }
            PlanReviewSection(plan: plan)
            ScaleSliderSection(label: strings.erpFlowText(key: "anxietyAfter"), value: $anxietyAfter) {
                strings.erpIntensityValue(value: $0)
            }
            Section(strings.erpFlowText(key: "outcomeQuestion")) {
                // A checkmark list: these labels are too long for a
                // segmented control.
                Picker(strings.erpFlowText(key: "outcomeQuestion"), selection: $outcome) {
                    ForEach(DelayOutcome.allCases, id: \.self) { value in
                        Text(strings.erpOutcome(outcome: value.wireName)).tag(DelayOutcome?.some(value))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
                .listRowBackground(AppColors.card)
            }
            Section(strings.erpFlowText(key: "whatHappened")) {
                TextField(strings.erpFlowText(key: "whatHappened"), text: $whatHappened,
                          prompt: Text(strings.erpFlowText(key: "whatHappenedHint")), axis: .vertical)
                    .lineLimit(3...6)
                    .listRowBackground(AppColors.card)
            }
            Section(strings.erpFlowText(key: "learning")) {
                TextField(strings.erpFlowText(key: "learning"), text: $learning,
                          prompt: Text(strings.erpFlowText(key: "learningHint")), axis: .vertical)
                    .lineLimit(3...6)
                    .listRowBackground(AppColors.card)
            }
        }
        .appListBackground()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(strings.erpFlowText(key: "reflectionTitle"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(strings.erpFlowText(key: saving ? "saving" : "save"), action: save)
                    .fontWeight(.semibold)
                    .disabled(saving)
            }
        }
    }

    // MARK: Actions

    private func begin() {
        model.events.erpSessionStarted()
        anxietyAfter = anxietyBefore
        let now = Date()
        startedAt = now
        endsAt = now.addingTimeInterval(TimeInterval(plan.defaultSeconds))
        notificationScheduled = false
        if !firstRun { Task { _ = await Reminders.requestPermission() } }
        phase = .countdown
    }

    private func finishTimer(completed: Bool, haptic: Bool = true) {
        guard phase == .countdown else { return }
        let elapsed = startedAt.map { Int(Date().timeIntervalSince($0)) } ?? 0
        actualSeconds = completed ? plan.defaultSeconds : min(max(elapsed, 0), plan.defaultSeconds)
        self.completed = completed
        startedAt = nil
        endsAt = nil
        cancelNotification()
        if completed && haptic { finishHaptic += 1 }
        phase = .reflection
    }

    private func handleScenePhase(_ newPhase: ScenePhase) {
        guard phase == .countdown, let endsAt else { return }
        switch newPhase {
        case .active:
            if Date() >= endsAt {
                finishTimer(completed: true, haptic: !notificationScheduled)
            } else {
                cancelNotification()
            }
        case .inactive, .background:
            let strings = model.strings
            Task {
                notificationScheduled = await Reminders.schedulePracticeTimer(
                    id: Reminders.erpTimerID, endsAt: endsAt,
                    title: strings.erpWindowCompleteTitle, body: strings.erpWindowCompleteBody
                )
            }
        @unknown default:
            break
        }
    }

    private func cancelNotification() {
        notificationScheduled = false
        Reminders.cancelPracticeTimer(id: Reminders.erpTimerID)
    }

    private func save() {
        let strings = model.strings
        guard let outcome else {
            navigation.showToast(strings.erpFlowText(key: "outcomeValidation"), kind: .info)
            return
        }
        saving = true
        let session = ErpExerciseSession(
            planId: plan.id, exerciseId: plan.exerciseId, exerciseTitle: plan.exerciseTitle,
            triggerOrExposure: plan.triggerOrExposure, fearPrediction: plan.fearPrediction,
            preventionCommitment: plan.preventionCommitment, plannedSeconds: plan.defaultSeconds,
            actualSeconds: actualSeconds, completed: completed,
            anxietyBefore: Int(anxietyBefore.rounded()), anxietyAfter: Int(anxietyAfter.rounded()),
            outcome: outcome,
            whatHappened: whatHappened.trimmingCharacters(in: .whitespacesAndNewlines),
            learning: learning.trimmingCharacters(in: .whitespacesAndNewlines),
            createdAt: DartTimestamp.now()
        )
        do {
            try model.database.insertErpSession(session)
        } catch {
            saving = false
            navigation.showToast(strings.erpFlowText(key: "saveError"), kind: .error)
            return
        }
        model.prefs.recordMeaningfulAction(.guidedErp)
        model.events.erpSessionSaved(ranToCompletion: completed)
        model.prefs.recordReviewPracticeCompleted()
        if firstRun {
            navigation.finishFirstRun(.erp)
        } else {
            navigation.completeActivity(.erp)
        }
    }
}

/// `_PlanReviewCard`: the exposure, the prediction (when there is one) and
/// the commitment.
private struct PlanReviewSection: View {
    let plan: ErpExercisePlan
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        Section {
            line(strings.erpFlowText(key: "exposure"), plan.triggerOrExposure)
            if !plan.fearPrediction.isEmpty {
                line(strings.erpFlowText(key: "prediction"), plan.fearPrediction)
            }
            line(strings.erpFlowText(key: "commitment"), plan.preventionCommitment)
        }
        .listRowBackground(AppColors.card)
    }

    private func line(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(AppColors.textSecondary)
            Text(value)
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
    }
}
