import SwiftUI

/// `EmergencyToolkitScreen` from `lib/mobile/screens/emergency_toolkit_screen.dart`:
/// quick, calming actions for a high-distress moment. Always free.
struct EmergencyToolkitScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.emergencyToolkitText(key: key) }
        List {
            SectionIntroSection(id: "emergencyToolkit")
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text(text("pauseTitle"))
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    Text(text("pauseBody"))
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                }
                .padding(.vertical, 6)
                .listRowBackground(AppColors.accent.opacity(0.12))
            } footer: {
                Text(text("boundary"))
                    .font(.footnote)
                    .padding(.top, 6)
            }
            Section {
                row("wind", text("breathe"), text("breatheSubtitle")) { navigation.push(.breathing) }
                row("hourglass", text("delay"), text("delaySubtitle")) { navigation.push(.compulsionDelay) }
                // Flutter opens urge surfing here without recording, free.
                row("water.waves", text("surf"), text("surfSubtitle")) { navigation.push(.recoveryTool(.urgeSurfing)) }
                row("leaf", text("coping"), text("copingSubtitle")) { navigation.push(.copingLibrary) }
            }
            .listRowBackground(AppColors.card)
            Section(text("remindersTitle")) {
                ForEach(["reminderThought", "reminderUrge", "reminderUncertainty"], id: \.self) { key in
                    Text(text(key))
                        .font(.custom(AppFont.display, size: 18, relativeTo: .body))
                        .padding(.vertical, 6)
                }
            }
            .listRowBackground(AppColors.card)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(text("title"))
    }

    private func row(_ icon: String, _ title: String, _ subtitle: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(AppColors.accent)
                    .frame(width: 30)
                    .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.body.weight(.semibold)).foregroundStyle(Color(.label))
                    Text(subtitle).font(.footnote).foregroundStyle(Color(.secondaryLabel))
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
                    .accessibilityHidden(true)
            }
            .padding(.vertical, 4)
            .contentShape(.rect)
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint(subtitle)
    }
}

/// `BreathingScreen`: box breathing, four seconds per phase, with a circle
/// that grows on the in-breath and settles on the out-breath.
struct BreathingScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var index = 0

    private static let phases: [(key: String, big: Bool)] = [
        ("breatheIn", true), ("hold", true), ("breatheOut", false), ("hold", false),
    ]

    var body: some View {
        let strings = model.strings
        let phase = Self.phases[index]
        let label = strings.emergencyToolkitText(key: phase.key)
        VStack(spacing: 40) {
            Spacer()
            ZStack {
                Circle()
                    .fill(AppColors.accent.opacity(0.16))
                    .overlay(Circle().strokeBorder(AppColors.accent, lineWidth: 2))
                    .frame(width: phase.big ? 240 : 130, height: phase.big ? 240 : 130)
                    .animation(reduceMotion ? nil : .easeInOut(duration: 4), value: phase.big)
                Text(label)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(AppColors.accent)
                    .contentTransition(.opacity)
            }
            .frame(width: 260, height: 260)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(label)
            Text(strings.emergencyToolkitText(key: "breathingHint"))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.surface)
        .navigationTitle(strings.emergencyToolkitText(key: "breathe"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(4))
                guard !Task.isCancelled else { return }
                index = (index + 1) % Self.phases.count
                UIAccessibility.post(notification: .announcement,
                                     argument: strings.emergencyToolkitText(key: Self.phases[index].key))
            }
        }
    }
}

/// `CopingLibraryScreen`. Flutter keeps this copy in English only (it has
/// no ARB entries yet), so it is English here too until it is translated.
struct CopingLibraryScreen: View {
    private struct Strategy: Hashable {
        let title: String
        let body: String
    }

    private static let categories: [(label: String, strategies: [Strategy])] = [
        ("During urges", [
            Strategy(title: "Deep breathing",
                     body: "Slow your exhale. Breathe in for 4, out for 6. A longer out-breath tells your body it is safe to settle."),
            Strategy(title: "Grounding (5-4-3-2-1)",
                     body: "Name 5 things you can see, 4 you can feel, 3 you can hear, 2 you can smell, and 1 you can taste. Bring yourself back to right now."),
            Strategy(title: "Urge surfing",
                     body: "Picture the urge as a wave. Watch it rise, crest, and fall on its own. You do not have to act. It always passes."),
            Strategy(title: "Acceptance statements",
                     body: "Try: \"This is just an intrusive thought. I can let it be here without responding to it.\""),
            Strategy(title: "Mindful observation",
                     body: "Watch the thought like a cloud drifting past. Notice it, label it \"a thought\", and let it move along."),
        ]),
        ("During anxiety", [
            Strategy(title: "Progressive muscle relaxation",
                     body: "Tense each muscle group for about 5 seconds, then release, from your feet up to your face. Notice the contrast as you let go."),
            Strategy(title: "Mindfulness",
                     body: "Rest your attention on your breath. When your mind wanders, gently and without judgement bring it back."),
            Strategy(title: "Self-compassion",
                     body: "Speak to yourself the way you would to a good friend: \"This is hard, and I am doing my best.\""),
            Strategy(title: "Go for a walk",
                     body: "Take a slow walk and let your attention rest on each step and the air on your skin. Movement helps anxiety move through."),
        ]),
    ]

    var body: some View {
        List {
            Section {
            } header: {
                Text(verbatim: "Healthy ways to ride out a hard moment.")
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "copingLibrary")
            ForEach(Self.categories, id: \.label) { category in
                Section {
                    ForEach(category.strategies, id: \.self) { strategy in
                        DisclosureGroup {
                            Text(verbatim: strategy.body)
                                .font(.subheadline)
                                .foregroundStyle(Color(.secondaryLabel))
                                .padding(.vertical, 4)
                        } label: {
                            Text(verbatim: strategy.title).font(.body.weight(.semibold))
                        }
                    }
                } header: {
                    Text(verbatim: category.label)
                }
                .listRowBackground(AppColors.card)
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(Text(verbatim: "Coping Library"))
    }
}
