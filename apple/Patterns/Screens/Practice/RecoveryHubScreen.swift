import SwiftUI

/// `_RecoveryDestination` from `lib/mobile/screens/recovery_hub_screen.dart`.
/// Raw values are the Dart names the copy is keyed by.
enum RecoveryDestination: String, CaseIterable, Hashable {
    case guidedErp, ybocsSelfCheck, compulsionDelay, emergencyToolkit, copingLibrary
    case exposureHierarchy, exposureMaterials, responsePrevention, structuredPrograms
    case urgeSurfing, uncertaintyTraining, actionPlanner, behavioralExperiments
    case recoveryMetrics, reflectionJournal, implementationIntentions

    enum Stage: String, CaseIterable { case assess, plan, practice, review }

    func title(_ s: Strings) -> String { s.recoveryToolTitle(tool: rawValue) }
    func subtitle(_ s: Strings) -> String { s.recoveryToolSubtitle(tool: rawValue) }

    var systemImage: String {
        switch self {
        case .emergencyToolkit: "cross.case"
        case .copingLibrary: "leaf"
        case .compulsionDelay: "hourglass"
        case .ybocsSelfCheck: "checklist"
        case .recoveryMetrics: "flame"
        case .exposureHierarchy: "stairs"
        case .exposureMaterials: "folder"
        case .structuredPrograms: "calendar"
        case .actionPlanner: "list.bullet.rectangle"
        case .implementationIntentions: "lightbulb"
        case .guidedErp: "figure.mind.and.body"
        case .urgeSurfing: "water.waves"
        case .responsePrevention: "shield"
        case .uncertaintyTraining: "questionmark.circle"
        case .behavioralExperiments: "flask"
        case .reflectionJournal: "book"
        }
    }

    /// The paywall a locked tool opens; free tools never ask.
    var proEntryPoint: ProEntryPoint? {
        switch self {
        case .recoveryMetrics: .recoveryMetrics
        case .exposureHierarchy: .exposureHierarchy
        case .exposureMaterials: .exposureMaterials
        case .structuredPrograms: .structuredPrograms
        case .actionPlanner: .actionPlanner
        case .implementationIntentions: .implementationIntentions
        case .urgeSurfing: .urgeSurfing
        case .responsePrevention: .responsePrevention
        case .uncertaintyTraining: .uncertaintyTraining
        case .behavioralExperiments: .behavioralExperiments
        case .reflectionJournal: .reflectionJournal
        case .guidedErp, .ybocsSelfCheck, .compulsionDelay, .emergencyToolkit, .copingLibrary: nil
        }
    }

    var isPro: Bool { proEntryPoint != nil }

    /// `_sosTools`: grounding tools for a hard moment, all free.
    static let immediateHelp: [RecoveryDestination] = [.emergencyToolkit, .copingLibrary, .compulsionDelay]

    /// `_tools` in Flutter's order, grouped by journey stage.
    static func tools(in stage: Stage) -> [RecoveryDestination] {
        switch stage {
        case .assess: [.ybocsSelfCheck, .recoveryMetrics]
        case .plan: [.exposureHierarchy, .exposureMaterials, .structuredPrograms, .actionPlanner, .implementationIntentions]
        case .practice: [.guidedErp, .compulsionDelay, .urgeSurfing, .responsePrevention, .uncertaintyTraining]
        case .review: [.behavioralExperiments, .reflectionJournal]
        }
    }

    /// The route that opens this tool.
    var route: Route {
        switch self {
        case .guidedErp: .erpExercises
        case .compulsionDelay: .compulsionDelay
        case .ybocsSelfCheck: .selfCheck
        case .exposureHierarchy: .exposureHierarchy
        case .reflectionJournal: .exposureReflection
        case .emergencyToolkit: .emergencyToolkit
        case .copingLibrary: .copingLibrary
        case .urgeSurfing: .urgeSurf
        case .responsePrevention: .responsePrevention
        case .uncertaintyTraining: .uncertaintyTraining
        case .actionPlanner: .actionPlanner
        case .implementationIntentions: .implementationIntentions
        case .behavioralExperiments: .behavioralExperiments
        case .structuredPrograms: .structuredPrograms
        case .exposureMaterials: .exposureMaterials(stepID: nil, hierarchyID: nil)
        case .recoveryMetrics: .recoveryMetrics
        default: .recoveryTool(self)
        }
    }
}

/// `RecoveryHubScreen`: the Practice tab. Immediate help first, then every
/// tool grouped by where someone is in their ERP work.
struct RecoveryHubScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strings = model.strings
        List {
            Section {
                immediateHelp(strings)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            } header: {
                VStack(alignment: .leading, spacing: 14) {
                    Text(strings.recoverySubtitle)
                        .font(.subheadline)
                        .foregroundStyle(AppColors.textSecondary)
                    Label(strings.recoveryImmediateHelpTitle, systemImage: "heart.fill")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppColors.accent)
                        .accessibilityAddTraits(.isHeader)
                }
                .textCase(nil)
                .padding(.leading, -4)
                .padding(.bottom, 4)
            }

            ForEach(RecoveryDestination.Stage.allCases, id: \.self) { stage in
                Section {
                    ForEach(RecoveryDestination.tools(in: stage), id: \.self) { tool in
                        ToolRow(tool: tool, locked: tool.isPro && !model.proUnlocked) { open(tool) }
                    }
                } header: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(strings.recoveryStageTitle(stage: stage.rawValue))
                            .font(.headline)
                            .foregroundStyle(Color(.label))
                        Text(strings.recoveryStageSubtitle(stage: stage.rawValue))
                            .font(.footnote)
                            .foregroundStyle(AppColors.textSecondary)
                    }
                    .textCase(nil)
                    .padding(.leading, -4)
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isHeader)
                }
                .listRowBackground(AppColors.card)
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(strings.recoveryTitle)
    }

    private func immediateHelp(_ strings: Strings) -> some View {
        // Three cards side by side; stacked at accessibility text sizes so
        // the titles wrap instead of shrinking.
        let layout = typeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(spacing: 10)) : AnyLayout(HStackLayout(alignment: .top, spacing: 10))
        return layout {
            ForEach(RecoveryDestination.immediateHelp, id: \.self) { tool in
                Button { open(tool) } label: {
                    VStack(spacing: 8) {
                        Image(systemName: tool.systemImage)
                            .font(.title2)
                            .foregroundStyle(AppColors.accent)
                        Text(tool.title(strings))
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(Color(.label))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, minHeight: 92)
                    .padding(.horizontal, 6)
                    .background(AppColors.card, in: .rect(cornerRadius: 16))
                    .contentShape(.rect(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .accessibilityHint(strings.recoveryOpenToolHint(title: tool.title(strings)))
            }
        }
    }

    /// `_openTool`: a locked Pro tool opens its paywall instead.
    private func open(_ tool: RecoveryDestination) {
        if let entry = tool.proEntryPoint, !navigation.requirePro(model.proUnlocked, entry) { return }
        // Phase 5: AppEvents.logErpOpened for guided ERP.
        navigation.push(tool.route)
    }
}

/// `_ToolRow`: icon, title, a short explanation, a Pro badge when locked.
private struct ToolRow: View {
    let tool: RecoveryDestination
    let locked: Bool
    let action: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let title = tool.title(strings)
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: tool.systemImage)
                    .font(.title3)
                    .foregroundStyle(AppColors.accent)
                    .frame(width: 30)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(Color(.label))
                    Text(tool.subtitle(strings))
                        .font(.footnote)
                        .foregroundStyle(AppColors.textSecondary)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                if locked {
                    // Pro tools show a lock; VoiceOver hears "Patterns Pro".
                    Image(systemName: "lock.fill")
                        .font(.footnote)
                        .foregroundStyle(AppColors.accent)
                }
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
            }
            .padding(.vertical, 4)
            .contentShape(.rect)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(locked ? "\(title), \(strings.recoveryProBadge)" : title)
        .accessibilityHint(locked ? strings.recoveryLockedToolHint(title: title) : strings.recoveryOpenToolHint(title: title))
        .accessibilityAddTraits(.isButton)
    }
}
