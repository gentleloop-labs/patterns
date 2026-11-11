import PatternsCore
import SwiftUI

/// `YbocsScreen` from `lib/mobile/screens/ybocs_screen.dart`: the intro and
/// history. "Begin" opens the self-check itself full screen: a checklist,
/// one question per page (the back button steps back a question), then the
/// result. It is a self-check aid, not a diagnosis, and says so.
struct YbocsScreen: View {
    /// First-run mode: closing a saved result leads to the first-run result.
    var firstRun = false

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dynamicTypeSize) private var typeSize
    @State private var history: Loadable<[YbocsAssessment]> = .loading
    @State private var taking = false
    @State private var deleting: YbocsAssessment?

    var body: some View {
        let strings = model.strings
        let past = history.value ?? []
        List {
            // An intro paragraph as a header: a row would clip it to the
            // rounded corners.
            Section {
            } header: {
                Text(strings.ybocsText(key: "introBody"))
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            Section {
                Label {
                    Text(strings.ybocsText(key: "disclaimer")).font(.subheadline)
                } icon: {
                    Image(systemName: "info.circle").foregroundStyle(AppColors.accent)
                }
                .padding(.vertical, 4)
                .listRowBackground(AppColors.accent.opacity(0.10))
            }
            Section {
                point("checklist", strings.ybocsText(key: "spotTitle"), strings.ybocsText(key: "spotBody"))
                point("gauge.with.dots.needle.50percent", strings.ybocsText(key: "impactTitle"),
                      strings.ybocsText(key: "impactBody"))
                point("chart.bar.xaxis", strings.ybocsText(key: "resultIntroTitle"), strings.ybocsText(key: "resultIntroBody"))
            } footer: {
                // At accessibility sizes the note scrolls with the page
                // rather than filling the pinned bar.
                if typeSize.isAccessibilitySize { Text(strings.ybocsText(key: "privacyDuration")) }
            }
            .listRowBackground(AppColors.card)
            if !past.isEmpty {
                Section {
                    ForEach(past.prefix(5), id: \.id) { assessment in
                        HistoryRow(assessment: assessment)
                            .swipeActions {
                                Button(strings.ybocsText(key: "deleteAction"), systemImage: "trash") {
                                    deleting = assessment
                                }
                                .tint(.red)
                            }
                            .contextMenu {
                                Button(strings.ybocsText(key: "deleteTooltip"), systemImage: "trash", role: .destructive) {
                                    deleting = assessment
                                }
                            }
                    }
                } header: {
                    Text(strings.ybocsText(key: "historyTitle"))
                } footer: {
                    Text(strings.ybocsText(key: "historyBody"))
                }
                .listRowBackground(AppColors.card)
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(strings.ybocsText(key: "title"))
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 8) {
                Button { taking = true } label: {
                    Text(strings.ybocsText(key: past.isEmpty ? "begin" : "retakeAction")).frame(maxWidth: .infinity)
                }
                .buttonStyle(.accentProminent)
                .controlSize(.large)
                if !typeSize.isAccessibilitySize {
                    Text(strings.ybocsText(key: "privacyDuration"))
                        .font(.caption)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
        .toolbar(firstRun ? .hidden : .automatic, for: .tabBar)
        .liveQuery(model.database, into: $history) { db in try YbocsAssessment.all().fetchAll(db) }
        .fullScreenCover(isPresented: $taking) {
            YbocsFlow { saved, finished in
                taking = false
                // Closing the result leaves the self-check, as Flutter pops
                // the whole screen; closing the checklist returns here.
                guard finished else { return }
                if firstRun && saved { navigation.finishFirstRun(.selfcheck) } else { navigation.pop() }
            }
        }
        .alert(strings.ybocsText(key: "deleteTitle"), isPresented: Binding(
            get: { deleting != nil }, set: { if !$0 { deleting = nil } }
        ), presenting: deleting) { assessment in
            Button(strings.ybocsText(key: "cancel"), role: .cancel) {}
            Button(strings.ybocsText(key: "deleteAction"), role: .destructive) { delete(assessment) }
        } message: { _ in
            Text(strings.ybocsText(key: "deleteBody"))
        }
    }

    private func point(_ icon: String, _ title: String, _ body: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(AppColors.accent)
                .frame(width: 30)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.headline)
                Text(body).font(.subheadline).foregroundStyle(AppColors.textSecondary)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }

    private func delete(_ assessment: YbocsAssessment) {
        guard let id = assessment.id else { return }
        let strings = model.strings
        do {
            try model.database.deleteYbocsAssessment(id: id)
            UIAccessibility.post(notification: .announcement, argument: strings.ybocsText(key: "deleteSuccess"))
        } catch {
            navigation.showToast(strings.ybocsText(key: "deleteError"), kind: .error)
        }
    }
}

private struct HistoryRow: View {
    let assessment: YbocsAssessment
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let severity = assessment.severity ?? .forScore(assessment.totalScore)
        let label = severity.label(strings)
        let date = assessment.datetime.date().map(strings.dates.fullDate) ?? ""
        HStack(spacing: 12) {
            Circle().fill(severity.color).frame(width: 10, height: 10)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(label) · \(assessment.totalScore)/40").font(.body.weight(.semibold))
                Text(date).font(.footnote).foregroundStyle(AppColors.textSecondary)
            }
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.ybocsHistorySummary(severity: label, score: assessment.totalScore, date: date))
    }
}

extension YbocsSeverity {
    func label(_ s: Strings) -> String {
        switch self {
        case .subclinical: s.ybocsSeveritySubclinical
        case .mild: s.ybocsSeverityMild
        case .moderate: s.ybocsSeverityModerate
        case .severe: s.ybocsSeveritySevere
        case .extreme: s.ybocsSeverityExtreme
        }
    }

    func blurb(_ s: Strings) -> String { s.ybocsSeverityBlurb(severity: wireName) }

    /// `YbocsSeverityDisplay.color`.
    var color: Color {
        switch self {
        case .subclinical: Color(UIColor(rgb: 0x6FBF73))
        case .mild: Color(UIColor(rgb: 0x9CCC65))
        case .moderate: Color(UIColor(rgb: 0xF4C95D))
        case .severe: Color(UIColor(rgb: 0xFFB74D))
        case .extreme: Color(UIColor(rgb: 0xE57373))
        }
    }
}

// MARK: - The self-check

/// Answers in progress, shared by the checklist, question and result pages.
@Observable
private final class YbocsDraft {
    /// Selected symptom ids, in the order they were picked (as Dart's
    /// insertion-ordered set saves them).
    var symptoms: [String] = []
    var answers: [Int?] = Array(repeating: nil, count: YbocsContent.questions.count)
    var saved = false
    var saving = false

    func toggle(_ id: String) {
        if let index = symptoms.firstIndex(of: id) { symptoms.remove(at: index) } else { symptoms.append(id) }
    }

    func score(_ dimension: YbocsDimension) -> Int {
        zip(YbocsContent.questions, answers).reduce(0) { $0 + ($1.0.dimension == dimension ? ($1.1 ?? 0) : 0) }
    }

    var total: Int { score(.obsessions) + score(.compulsions) }

    var selectedCategories: [YbocsCategory] {
        YbocsContent.categories.filter { category in category.items.contains { symptoms.contains($0) } }
    }

    func reset() {
        symptoms = []
        answers = Array(repeating: nil, count: YbocsContent.questions.count)
        saved = false
        saving = false
    }
}

private enum YbocsStep: Hashable {
    case question(Int)
    case results
}

/// Checklist, questions and result, in its own navigation stack so the back
/// button moves between them.
private struct YbocsFlow: View {
    /// Called on close, with whether the result was saved and whether the
    /// self-check was finished (closed from the result).
    let onClose: (_ saved: Bool, _ finished: Bool) -> Void
    @Environment(AppModel.self) private var model
    @State private var draft = YbocsDraft()
    @State private var path: [YbocsStep] = []

    var body: some View {
        NavigationStack(path: $path) {
            YbocsChecklist(draft: draft, onClose: { onClose(false, false) }) { path.append(.question(0)) }
                .navigationDestination(for: YbocsStep.self) { step in
                    switch step {
                    case let .question(index):
                        YbocsQuestionPage(draft: draft, index: index) {
                            path.append(index == YbocsContent.questions.count - 1 ? .results : .question(index + 1))
                        }
                    case .results:
                        YbocsResults(draft: draft, onRetake: {
                            draft.reset()
                            path = []
                        }, onClose: { onClose(draft.saved, true) })
                    }
                }
        }
        .tint(AppColors.accent)
        .overlay(alignment: .top) { ToastHost() }
    }
}

private struct YbocsChecklist: View {
    let draft: YbocsDraft
    let onClose: () -> Void
    let onContinue: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        List {
            // An intro paragraph as a header: a row would clip it to the
            // rounded corners.
            Section {
            } header: {
                Text(strings.ybocsText(key: "checklistBody"))
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            group(.obsessions, strings.ybocsText(key: "obsessions"), strings.ybocsText(key: "obsessionsDescription"), strings)
            group(.compulsions, strings.ybocsText(key: "compulsions"), strings.ybocsText(key: "compulsionsDescription"), strings)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(strings.ybocsText(key: "checklistTitle"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(strings.closeAction, systemImage: "xmark", action: onClose)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button(action: onContinue) {
                Text(strings.ybocsSelectedCount(count: draft.symptoms.count)).frame(maxWidth: .infinity)
            }
            .buttonStyle(.accentProminent)
            .controlSize(.large)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
    }

    @ViewBuilder
    private func group(_ kind: YbocsDimension, _ title: String, _ subtitle: String, _ strings: Strings) -> some View {
        Section {
        } header: {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.title3.weight(.bold)).foregroundStyle(Color(.label))
                Text(subtitle).font(.footnote).foregroundStyle(AppColors.textSecondary)
            }
            .textCase(nil)
            .padding(.leading, -4)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isHeader)
        }
        ForEach(YbocsContent.categories.filter { $0.kind == kind }) { category in
            let count = category.items.filter { draft.symptoms.contains($0) }.count
            Section {
                ForEach(category.items, id: \.self) { item in
                    let checked = draft.symptoms.contains(item)
                    Button { draft.toggle(item) } label: {
                        HStack(alignment: .firstTextBaseline, spacing: 12) {
                            Image(systemName: checked ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(checked ? AppColors.accent : AppColors.textSecondary)
                                .font(.title3)
                            Text(strings.ybocsSymptomLabel(symptom: item))
                                .foregroundStyle(Color(.label))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .contentShape(.rect)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(strings.ybocsSymptomLabel(symptom: item))
                    .accessibilityAddTraits(checked ? [.isButton, .isSelected] : .isButton)
                }
            } header: {
                HStack {
                    Text(strings.ybocsCategoryTitle(category: category.id))
                    Spacer()
                    if count > 0 {
                        Text("\(count)")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(AppColors.accent)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(AppColors.accent.opacity(0.16), in: .capsule)
                            .accessibilityLabel(strings.ybocsCategorySelectedCount(count: count))
                    }
                }
            }
            .listRowBackground(AppColors.card)
        }
    }
}

private struct YbocsQuestionPage: View {
    let draft: YbocsDraft
    let index: Int
    let onNext: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let questions = YbocsContent.questions
        let question = questions[index]
        let progress = strings.ybocsQuestionProgress(current: index + 1, total: questions.count)
        let isLast = index == questions.count - 1
        List {
            Section {
            } header: {
                VStack(alignment: .leading, spacing: 12) {
                    ProgressView(value: Double(index + 1), total: Double(questions.count))
                        .accessibilityLabel(progress)
                    Text(question.dimension == .obsessions ? strings.ybocsText(key: "obsessions") : strings.ybocsText(key: "compulsions"))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppColors.accent)
                    Text(strings.ybocsQuestionPrompt(question: question.id))
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(Color(.label))
                        .accessibilityAddTraits(.isHeader)
                }
                .textCase(nil)
                .padding(.leading, -4)
            }
            Section {
                ForEach(0...4, id: \.self) { score in
                    let selected = draft.answers[index] == score
                    Button { draft.answers[index] = score } label: {
                        HStack(spacing: 12) {
                            Text(strings.ybocsQuestionOption(option: "\(question.id)_\(score)"))
                                .foregroundStyle(Color(.label))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if selected {
                                Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(AppColors.accent)
                            }
                        }
                        .padding(.vertical, 4)
                        .contentShape(.rect)
                    }
                    .accessibilityAddTraits(selected ? .isSelected : [])
                }
            }
            .listRowBackground(AppColors.card)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(progress)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button(action: onNext) {
                Text(strings.ybocsText(key: isLast ? "seeResults" : "next")).frame(maxWidth: .infinity)
            }
            .buttonStyle(.accentProminent)
            .controlSize(.large)
            .disabled(draft.answers[index] == nil)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
    }
}

private struct YbocsResults: View {
    let draft: YbocsDraft
    let onRetake: () -> Void
    let onClose: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    var body: some View {
        let strings = model.strings
        let total = draft.total
        let severity = YbocsSeverity.forScore(total)
        let obsessions = draft.score(.obsessions), compulsions = draft.score(.compulsions)
        let categories = draft.selectedCategories
        let hasObsessions = categories.contains { $0.kind == .obsessions } || obsessions > 0
        let hasCompulsions = categories.contains { $0.kind == .compulsions } || compulsions > 0
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        // Severity colours are too light for text on the
                        // light theme; they tint the background instead.
                        Text("\(total)")
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(.label))
                        Text("/ 40").font(.title3.weight(.semibold)).foregroundStyle(AppColors.textSecondary)
                        Spacer()
                        HStack(spacing: 6) {
                            Circle().fill(severity.color).frame(width: 8, height: 8)
                            Text(severity.label(strings))
                        }
                        .font(.subheadline.weight(.bold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemBackground).opacity(0.6), in: .capsule)
                    }
                    Text(severity.blurb(strings)).font(.subheadline)
                }
                .padding(.vertical, 6)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(strings.ybocsSeveritySummary(
                    severity: severity.label(strings),
                    score: strings.ybocsScoreOutOf(score: total, maximum: 40),
                    description: severity.blurb(strings)
                ))
                .listRowBackground(severity.color.opacity(0.22))
            }
            Section(strings.ybocsText(key: "breakdownTitle")) {
                subtotal(strings.ybocsText(key: "obsessions"), obsessions, strings)
                subtotal(strings.ybocsText(key: "compulsions"), compulsions, strings)
            }
            .listRowBackground(AppColors.card)
            Section(strings.ybocsText(key: "typesTitle")) {
                Text(typesText(hasObsessions, hasCompulsions, strings))
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
            }
            .listRowBackground(AppColors.card)
            if !categories.isEmpty {
                Section {
                    ForEach(categories) { category in
                        Text(strings.ybocsCategoryTitle(category: category.id))
                    }
                } header: {
                    Text(strings.ybocsText(key: "themesTitle"))
                } footer: {
                    Text(strings.ybocsText(key: "themesBody"))
                }
                .listRowBackground(AppColors.card)
            }
            Section(strings.ybocsText(key: "nextStepsTitle")) {
                Text(strings.ybocsText(key: "nextStepsBody")).font(.subheadline)
            }
            .listRowBackground(AppColors.card)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(strings.ybocsText(key: "resultsTitle"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(strings.doneAction, action: onClose).fontWeight(.semibold)
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 12) {
                Button(action: onRetake) {
                    Text(strings.ybocsText(key: "retake")).frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(draft.saving)
                Button(action: save) {
                    Text(strings.ybocsText(key: draft.saving ? "saving" : draft.saved ? "saved" : "saveHistory"))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.accentProminent)
                .disabled(draft.saved || draft.saving)
            }
            .controlSize(.large)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppColors.surface)
        }
    }

    private func subtotal(_ label: String, _ score: Int, _ strings: Strings) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                Spacer()
                Text("\(score)/20").font(.body.monospacedDigit().weight(.semibold))
            }
            ProgressView(value: Double(score), total: 20)
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(strings.ybocsSubtotalSummary(label: label, score: strings.ybocsScoreOutOf(score: score, maximum: 20)))
    }

    private func typesText(_ obsessions: Bool, _ compulsions: Bool, _ strings: Strings) -> String {
        switch (obsessions, compulsions) {
        case (false, false): strings.ybocsText(key: "typesNone")
        case (true, true): strings.ybocsText(key: "typesBoth")
        case (true, false): strings.ybocsText(key: "typesObsessions")
        case (false, true): strings.ybocsText(key: "typesCompulsions")
        }
    }

    private func save() {
        guard !draft.saving else { return }
        let strings = model.strings
        draft.saving = true
        let now = DartTimestamp.now()
        let total = draft.total
        let assessment = YbocsAssessment(
            datetime: now, obsessionScore: draft.score(.obsessions), compulsionScore: draft.score(.compulsions),
            totalScore: total, severity: .forScore(total), itemScores: draft.answers.map { $0 ?? 0 },
            themes: draft.selectedCategories.map(\.id), symptoms: draft.symptoms, createdAt: now
        )
        do {
            try model.database.insertYbocsAssessment(assessment)
            model.prefs.recordMeaningfulAction(.selfCheck)
            draft.saved = true
            navigation.showToast(strings.ybocsText(key: "saveSuccess"), kind: .success)
        } catch {
            navigation.showToast(strings.ybocsText(key: "saveError"), kind: .error)
        }
        draft.saving = false
    }
}

