import PatternsCore
import SwiftUI

/// `UncertaintyTrainingScreen` from `lib/mobile/screens/uncertainty_training_screen.dart`:
/// three short exercises for making room for "maybe". Pro.
struct UncertaintyTrainingScreen: View {
    /// `uncertaintyExercises` ids.
    static let exercises = ["maybe", "unanswered", "resist"]

    @Environment(AppModel.self) private var model
    @State private var logs: Loadable<[UncertaintyLog]> = .loading

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.uncertaintyTrainingText(key: key) }
        let calm = model.calmInsightsEnabled
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "uncertaintyTraining")
            Section {
                if case .failed = logs {
                    Text(text("loadError")).foregroundStyle(.secondary)
                }
                ForEach(Self.exercises, id: \.self) { exercise in
                    let title = strings.uncertaintyExerciseTitle(exercise: exercise)
                    let intro = strings.uncertaintyExerciseIntro(exercise: exercise)
                    // Calm insights hides the practice counts.
                    let count = calm ? nil : (logs.value ?? []).filter { $0.exerciseId == exercise }.count
                    NavigationLink(value: Route.uncertaintyPractice(exercise: exercise)) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(alignment: .firstTextBaseline) {
                                Text(title).font(.headline)
                                Spacer()
                                if let count, count > 0 {
                                    Text(strings.uncertaintyPracticeCount(count: count))
                                        .font(.footnote.weight(.semibold))
                                        .foregroundStyle(AppColors.accent)
                                }
                            }
                            Text(intro).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                        }
                        .padding(.vertical, 4)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(count.map { strings.uncertaintyExerciseSummaryWithCount(title: title, intro: intro, count: $0) }
                        ?? strings.uncertaintyExerciseSummary(title: title, intro: intro))
                    .accessibilityAddTraits(.isButton)
                }
            }
            .listRowBackground(AppColors.card)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(text("title"))
        .liveQuery(model.database, into: $logs) { db in try UncertaintyLog.all().fetchAll(db) }
    }
}

/// `UncertaintyPracticeScreen`: the exercise, why it helps, its prompt, and
/// how willing you were to let uncertainty stay.
struct UncertaintyPracticeScreen: View {
    let exercise: String
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var willingness: Double = 5
    @State private var note = ""
    @State private var saving = false

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.uncertaintyTrainingText(key: key) }
        Form {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text(strings.uncertaintyExerciseIntro(exercise: exercise)).font(.body)
                    Text(text("whyLabel"))
                        .font(.caption.weight(.semibold))
                        .textCase(.uppercase)
                        .foregroundStyle(AppColors.accent)
                        .padding(.top, 4)
                    Text(strings.uncertaintyExerciseWhy(exercise: exercise))
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(AppColors.card)
            Section {
                Text(strings.uncertaintyExercisePrompt(exercise: exercise))
                    .font(.custom(AppFont.display, size: 19, relativeTo: .body))
                    .padding(.vertical, 6)
            }
            .listRowBackground(AppColors.accent.opacity(0.12))
            ScaleSliderSection(label: text("willingnessLabel"), value: $willingness) {
                strings.uncertaintyWillingness(value: $0)
            }
            Section(text("noteLabel")) {
                TextField(text("noteLabel"), text: $note, prompt: Text(text("noteHint")), axis: .vertical)
                    .lineLimit(2...5)
                    .listRowBackground(AppColors.card)
            }
        }
        .appListBackground()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(strings.uncertaintyExerciseTitle(exercise: exercise))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(text("saveAction"), action: log)
                    .fontWeight(.semibold)
                    .disabled(saving)
            }
        }
    }

    private func log() {
        let strings = model.strings
        saving = true
        let now = DartTimestamp.now()
        let trimmed = note.trimmingCharacters(in: .whitespacesAndNewlines)
        do {
            try model.database.insertUncertaintyLog(UncertaintyLog(
                datetime: now, exerciseId: exercise, willingness: Int(willingness.rounded()),
                note: trimmed.isEmpty ? nil : trimmed, createdAt: now
            ))
        } catch {
            saving = false
            navigation.showToast(strings.uncertaintyTrainingText(key: "saveError"), kind: .error)
            return
        }
        navigation.pop()
        navigation.showToast(strings.uncertaintyTrainingText(key: "saveSuccess"), kind: .success)
    }
}
