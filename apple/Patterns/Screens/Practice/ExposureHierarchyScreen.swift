import PatternsCore
import SwiftUI

/// `ExposureHierarchyScreen` from `lib/mobile/screens/exposure_hierarchy_screen.dart`:
/// exposure ladders, each a list of steps from easiest to hardest. Pro.
struct ExposureHierarchyScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var hierarchies: Loadable<[ExposureHierarchy]> = .loading
    @State private var steps: Loadable<[ExposureStep]> = .loading
    @State private var building = false
    @State private var archiving: ExposureHierarchy?

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.exposureHierarchyText(key: key) }
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "exposureHierarchy")
            Section {
                switch hierarchies {
                case .loading:
                    ProgressView().frame(maxWidth: .infinity)
                case .failed:
                    Text(text("loadError")).foregroundStyle(.secondary)
                case let .loaded(items) where items.isEmpty:
                    VStack(alignment: .leading, spacing: 6) {
                        Image(systemName: "stairs").font(.title2).foregroundStyle(AppColors.accent)
                        Text(text("emptyTitle")).font(.headline).accessibilityAddTraits(.isHeader)
                        Text(text("emptyBody")).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                        Button(text("buildAction")) { building = true }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .padding(.top, 6)
                    }
                    .padding(.vertical, 6)
                case let .loaded(items):
                    ForEach(items, id: \.id) { hierarchy in
                        HierarchyRow(hierarchy: hierarchy,
                                     steps: (steps.value ?? []).filter { $0.hierarchyId == hierarchy.id })
                            .swipeActions {
                                Button(text("archiveAction"), systemImage: "archivebox") { archiving = hierarchy }
                                    .tint(.orange)
                            }
                            .contextMenu {
                                Button(text("archiveAction"), systemImage: "archivebox") { archiving = hierarchy }
                            }
                    }
                }
            }
            .listRowBackground(AppColors.card)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(text("title"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(text("newAction"), systemImage: "plus") { building = true }
            }
        }
        .liveQuery(model.database, into: $hierarchies) { db in try ExposureHierarchy.active().fetchAll(db) }
        .liveQuery(model.database, into: $steps) { db in try ExposureStep.all().fetchAll(db) }
        .sheet(isPresented: $building) { HierarchyBuilder() }
        .alert(text("archiveTitle"), isPresented: Binding(
            get: { archiving != nil }, set: { if !$0 { archiving = nil } }
        ), presenting: archiving) { hierarchy in
            Button(text("keepAction"), role: .cancel) {}
            Button(text("archiveAction"), role: .destructive) { archive(hierarchy) }
        } message: { _ in
            Text(text("archiveBody"))
        }
    }

    private func archive(_ hierarchy: ExposureHierarchy) {
        guard let id = hierarchy.id else { return }
        let strings = model.strings
        do {
            try model.database.archiveExposureHierarchy(id: id)
            navigation.showToast(strings.exposureHierarchyText(key: "archiveSuccess"), kind: .success)
        } catch {
            navigation.showToast(strings.exposureHierarchyText(key: "archiveError"), kind: .error)
        }
    }
}

/// "General" is stored in English; show it localized.
private func displayTheme(_ theme: String, _ strings: Strings) -> String {
    theme == "General" ? strings.exposureHierarchyText(key: "generalTheme") : theme
}

private struct HierarchyRow: View {
    let hierarchy: ExposureHierarchy
    let steps: [ExposureStep]
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let done = steps.filter { $0.status == .completed }.count
        let theme = displayTheme(hierarchy.theme, strings)
        let calm = model.calmInsightsEnabled
        let summary = calm ? theme : strings.exposureHierarchySummary(done: done, count: steps.count, theme: theme)
        if let id = hierarchy.id {
            NavigationLink(value: Route.exposureHierarchyDetail(id: id)) {
                HStack(spacing: 14) {
                    if !calm {
                        ProgressRing(value: steps.isEmpty ? 0 : Double(done) / Double(steps.count))
                    }
                    VStack(alignment: .leading, spacing: 3) {
                        Text(hierarchy.title).font(.headline)
                        Text(summary)
                            .font(.subheadline)
                            .foregroundStyle(Color(.secondaryLabel))
                            .lineLimit(2)
                    }
                }
                .padding(.vertical, 4)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(hierarchy.title)
            .accessibilityValue(summary)
            .accessibilityHint(strings.exposureHierarchyText(key: "openHierarchy"))
            .accessibilityAddTraits(.isButton)
        }
    }
}

/// `_ProgressRing`: share of steps done, with the percentage inside.
private struct ProgressRing: View {
    let value: Double
    @Environment(AppModel.self) private var model

    var body: some View {
        ZStack {
            Circle().stroke(Color(.systemFill), lineWidth: 4)
            Circle()
                .trim(from: 0, to: value)
                .stroke(AppColors.accent, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(Int((value * 100).rounded()))%")
                .font(.caption2.weight(.bold).monospacedDigit())
                .minimumScaleFactor(0.7)
                .foregroundStyle(Color(.label))
        }
        .frame(width: 46, height: 46)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(model.strings.exposureProgress(percent: Int((value * 100).rounded())))
    }
}

// MARK: - Builder

/// `ExposureHierarchyBuilderScreen` as a native sheet.
private struct HierarchyBuilder: View {
    private struct DraftStep: Identifiable {
        let id = UUID()
        var description = ""
        var difficulty: Double = 3
        var anxiety: Double = 5
    }

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var theme = ""
    @State private var steps = [DraftStep()]
    @State private var saving = false

    /// `ocdTracks` ids, mapped to their copy keys.
    private static let trackKeys = ["contamination", "checking", "harm", "relationship", "justRight"]

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.exposureHierarchyText(key: key) }
        NavigationStack {
            Form {
                Section(text("nameLabel")) {
                    TextField(text("nameLabel"), text: $title, prompt: Text(text("nameHint")))
                }
                .listRowBackground(AppColors.card)
                Section(text("themeLabel")) {
                    TextField(text("themeLabel"), text: $theme, prompt: Text(text("themeHint")))
                    // Suggestions, not a fixed list: ladders and tracks then
                    // share the same words.
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(Self.trackKeys, id: \.self) { key in
                                let label = strings.ocdTrackTheme(track: key)
                                Button(label) { theme = label }
                                    .buttonStyle(.bordered)
                                    .buttonBorderShape(.capsule)
                                    .tint(theme == label ? AppColors.accent : .secondary)
                            }
                        }
                    }
                    .scrollClipDisabled()
                }
                .listRowBackground(AppColors.card)

                ForEach(Array(steps.enumerated()), id: \.element.id) { index, _ in
                    stepSection(index, strings)
                }

                Section {
                    Button { withAnimation { steps.append(DraftStep()) } } label: {
                        Label(text("addAction"), systemImage: "plus.circle.fill")
                    }
                }
                .listRowBackground(AppColors.card)
            }
            .appListBackground()
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(text("newTitle"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(strings.cancelAction) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(text("createAction"), action: save)
                        .fontWeight(.semibold)
                        .disabled(saving)
                }
            }
        }
        .overlay(alignment: .top) { ToastHost() }
        .interactiveDismissDisabled(!title.isEmpty || steps.contains { !$0.description.isEmpty })
    }

    private func stepSection(_ index: Int, _ strings: Strings) -> some View {
        let text = { (key: String) in strings.exposureHierarchyText(key: key) }
        return Section {
            TextField(strings.exposureStepLabel(number: index + 1), text: $steps[index].description,
                      prompt: Text(text("stepHint")), axis: .vertical)
                .lineLimit(1...3)
            rating(text("difficulty"), $steps[index].difficulty, strings)
            rating(text("anxiety"), $steps[index].anxiety, strings)
        } header: {
            HStack {
                Text(strings.exposureStepLabel(number: index + 1))
                Spacer()
                Menu {
                    Button(text("moveUp"), systemImage: "arrow.up") { move(index, by: -1) }
                        .disabled(index == 0)
                    Button(text("moveDown"), systemImage: "arrow.down") { move(index, by: 1) }
                        .disabled(index == steps.count - 1)
                    Button(text("removeStep"), systemImage: "trash", role: .destructive) { remove(index) }
                } label: {
                    Image(systemName: "ellipsis.circle").font(.body)
                }
                .textCase(nil)
            }
        }
        .listRowBackground(AppColors.card)
    }

    private func rating(_ label: String, _ value: Binding<Double>, _ strings: Strings) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label).font(.subheadline)
                Spacer()
                Text(strings.exposureRating(value: Int(value.wrappedValue.rounded())))
                    .font(.subheadline.weight(.semibold).monospacedDigit())
                    .foregroundStyle(AppColors.accent)
            }
            .accessibilityHidden(true)
            Slider(value: value, in: 0...10, step: 1)
                .accessibilityLabel(label)
                .accessibilityValue(strings.exposureRating(value: Int(value.wrappedValue.rounded())))
        }
    }

    private func move(_ index: Int, by delta: Int) {
        let target = index + delta
        guard steps.indices.contains(target) else { return }
        withAnimation { steps.swapAt(index, target) }
    }

    private func remove(_ index: Int) {
        withAnimation {
            steps.remove(at: index)
            if steps.isEmpty { steps.append(DraftStep()) }
        }
    }

    private func save() {
        let strings = model.strings
        let text = { (key: String) in strings.exposureHierarchyText(key: key) }
        let name = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let themeText = theme.trimmingCharacters(in: .whitespacesAndNewlines)
        let filled = steps.filter { !$0.description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        guard !name.isEmpty else { return navigation.showToast(text("titleValidation"), kind: .info) }
        guard !filled.isEmpty else { return navigation.showToast(text("stepValidation"), kind: .info) }
        saving = true
        let now = DartTimestamp.now()
        let hierarchy = ExposureHierarchy(title: name, theme: themeText.isEmpty ? "General" : themeText,
                                          createdAt: now, updatedAt: now)
        let records = filled.enumerated().map { index, step in
            ExposureStep(hierarchyId: nil, orderIndex: index,
                         description: step.description.trimmingCharacters(in: .whitespacesAndNewlines),
                         difficulty: Int(step.difficulty.rounded()), anxietyRating: Int(step.anxiety.rounded()),
                         status: .notStarted)
        }
        do {
            try model.database.insertExposureHierarchy(hierarchy, steps: records)
        } catch {
            saving = false
            navigation.showToast(text("createError"), kind: .error)
            return
        }
        // Phase 5: AppEvents.logFirstExposureCreated(stepCount:).
        dismiss()
        navigation.showToast(text("createSuccess"), kind: .success)
    }
}

// MARK: - Climb

/// `ExposureHierarchyDetailScreen`: the steps in order, each with its
/// status and the materials linked to it.
struct ExposureHierarchyDetail: View {
    let hierarchyID: Int64
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var hierarchy: ExposureHierarchy?
    @State private var steps: Loadable<[ExposureStep]> = .loading
    @State private var materials: Loadable<[ExposureMaterial]> = .loading

    var body: some View {
        let strings = model.strings
        let items = steps.value ?? []
        let done = items.filter { $0.status == .completed }.count
        List {
            Section {
            } header: {
                HStack(alignment: .center, spacing: 14) {
                    Text(hierarchy.map { displayTheme($0.theme, strings) } ?? "")
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if !model.calmInsightsEnabled {
                        ProgressRing(value: items.isEmpty ? 0 : Double(done) / Double(items.count))
                    }
                }
                .textCase(nil)
                .padding(.leading, -4)
            }
            ForEach(Array(items.enumerated()), id: \.element.id) { index, step in
                Section {
                    ClimbStep(number: index + 1, step: step) { status in update(step, status) }
                    ForEach((materials.value ?? []).filter { $0.linkedStepId == step.id }, id: \.id) { MaterialRow(material: $0) }
                    if let stepID = step.id {
                        Button {
                            navigation.push(.exposureMaterials(stepID: stepID, hierarchyID: hierarchyID))
                        } label: {
                            Label(strings.exposureHierarchyText(key: "materialAction"), systemImage: "plus")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                }
                .listRowBackground(AppColors.card)
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(hierarchy?.title ?? "")
        .task {
            hierarchy = try? model.database.queue.read { try ExposureHierarchy.fetchOne($0, key: hierarchyID) }
        }
        .liveQuery(model.database, into: $materials) { db in try ExposureMaterial.all().fetchAll(db) }
        .liveQuery(model.database, into: $steps) { [hierarchyID] db in
            try ExposureStep.forHierarchy(hierarchyID).fetchAll(db)
        }
    }

    /// Completing a step stamps the time; any other status clears it.
    private func update(_ step: ExposureStep, _ status: ExposureStepStatus) {
        var updated = step
        updated.statusIndex = status.rawValue
        updated.completedAt = status == .completed ? DartTimestamp.now() : nil
        do {
            try model.database.updateExposureStep(updated)
        } catch {
            navigation.showToast(model.strings.exposureHierarchyText(key: "statusError"), kind: .error)
        }
    }
}

private struct ClimbStep: View {
    let number: Int
    let step: ExposureStep
    let onStatus: (ExposureStepStatus) -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let done = step.status == .completed
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    Circle().fill(done ? AppColors.accent : AppColors.accent.opacity(0.14))
                    if done {
                        Image(systemName: "checkmark").font(.caption.weight(.bold)).foregroundStyle(AppColors.onAccent)
                    } else {
                        Text("\(number)").font(.caption.weight(.bold)).foregroundStyle(AppColors.accent)
                    }
                }
                .frame(width: 26, height: 26)
                .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 4) {
                    Text(step.description).font(.body.weight(.semibold))
                    Text(strings.exposureStepMetrics(difficulty: step.difficulty, anxiety: step.anxietyRating))
                        .font(.footnote)
                        .foregroundStyle(Color(.secondaryLabel))
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(strings.exposureStepLabel(number: number))
            .accessibilityValue("\(step.description), \(strings.exposureStepMetrics(difficulty: step.difficulty, anxiety: step.anxietyRating))")
            Picker(strings.exposureStepLabel(number: number), selection: Binding(
                get: { step.status ?? .notStarted }, set: onStatus
            )) {
                Text(strings.exposureHierarchyText(key: "statusNotStarted")).tag(ExposureStepStatus.notStarted)
                Text(strings.exposureHierarchyText(key: "statusInProgress")).tag(ExposureStepStatus.inProgress)
                Text(strings.exposureHierarchyText(key: "statusDone")).tag(ExposureStepStatus.completed)
            }
            .pickerStyle(.segmented)
        }
        .padding(.vertical, 6)
    }
}
