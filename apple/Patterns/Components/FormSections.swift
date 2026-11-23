import PatternsCore
import SwiftUI

/// `SectionIntro` from `lib/widgets/section_intro.dart`: a one-time note at
/// the top of a tool, gone for good after "Got it". Same `sectionSeen_<id>`
/// flag as Flutter, so a note dismissed there stays dismissed.
struct SectionIntroSection: View {
    let id: String
    @Environment(AppModel.self) private var model
    @State private var seen = true

    var body: some View {
        Group {
            if !seen, let copy = copy(model.strings) {
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Label(copy.title, systemImage: "lightbulb")
                            .font(.headline)
                            .foregroundStyle(AppColors.accent)
                        ForEach(copy.points, id: \.self) { point in
                            Text(point)
                                .font(.subheadline)
                                .foregroundStyle(AppColors.textSecondary)
                        }
                        Button(model.strings.shellText(key: "gotIt"), action: dismiss)
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            .padding(.top, 6)
                    }
                    .padding(.vertical, 6)
                    .listRowBackground(AppColors.card)
                }
            }
        }
        .onAppear { seen = model.prefs.bool(PreferenceKey.sectionSeen(id)) ?? false }
    }

    private func dismiss() {
        model.prefs.set(true, for: PreferenceKey.sectionSeen(id))
        withAnimation { seen = true }
    }

    /// `localizedSectionIntro` for the tool sections.
    private func copy(_ strings: Strings) -> (title: String, points: [String])? {
        let tools = [
            "guidedErp": "guidedErp", "compulsionDelay": "compulsionDelay", "emergencyToolkit": "emergencyToolkit",
            "copingLibrary": "copingLibrary", "exposureHierarchy": "exposureHierarchy",
            "recoveryMetrics": "recoveryMetrics", "urgeSurf": "urgeSurfing", "responsePrevention": "responsePrevention",
            "structuredPrograms": "structuredPrograms", "behavioralExperiments": "behavioralExperiments",
            "exposureReflection": "reflectionJournal", "actionPlanner": "actionPlanner",
            "implementationIntentions": "implementationIntentions", "uncertaintyTraining": "uncertaintyTraining",
            "exposureMaterials": "exposureMaterials",
        ]
        guard let tool = tools[id] else { return nil }
        return (strings.recoveryToolTitle(tool: tool), [strings.recoveryToolSubtitle(tool: tool)])
    }
}

/// A 0 to 10 rating in a form section: label, the value in its colour,
/// and a stepped slider that VoiceOver adjusts one point at a time.
struct ScaleSliderSection: View {
    let label: String
    @Binding var value: Double
    /// The spoken value, e.g. "Urge 5 out of 10".
    let accessibilityValue: (Int) -> String
    @Environment(AppModel.self) private var model

    var body: some View {
        let rounded = Int(value.rounded())
        Section {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(label)
                    Spacer()
                    Text(model.strings.trackerDistressShortValue(value: rounded))
                        .font(.title3.weight(.bold).monospacedDigit())
                        .foregroundStyle(distressColor(rounded))
                        .contentTransition(.numericText(value: value))
                        .animation(.snappy, value: rounded)
                }
                .accessibilityHidden(true)
                Slider(value: $value, in: 0...10, step: 1)
                    .accessibilityLabel(label)
                    .accessibilityValue(accessibilityValue(rounded))
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment: if rounded < 10 { value = Double(rounded + 1) }
                        case .decrement: if rounded > 0 { value = Double(rounded - 1) }
                        @unknown default: break
                        }
                    }
            }
            .padding(.vertical, 4)
            .listRowBackground(AppColors.card)
        }
    }
}
