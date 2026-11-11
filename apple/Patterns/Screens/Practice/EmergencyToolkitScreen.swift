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
                    // Full-strength text: the grey misses 4.5:1 on the
                    // gold-tinted row.
                    Text(text("pauseBody"))
                        .font(.subheadline)
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
                row("water.waves", text("surf"), text("surfSubtitle")) { navigation.push(.urgeSurfFlow(record: false)) }
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
                    Text(subtitle).font(.footnote).foregroundStyle(AppColors.textSecondary)
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
                .foregroundStyle(AppColors.textSecondary)
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

/// `CopingLibraryScreen`: gentle strategies for urges and anxiety, each
/// opening to a short how-to. Flutter shows this copy in English only; the
/// native app has it in every language (`copingLibraryText`).
struct CopingLibraryScreen: View {
    @Environment(AppModel.self) private var model

    /// Category key, then each strategy's key prefix (`<prefix>Title`,
    /// `<prefix>Body`), in Flutter's order.
    private static let categories: [(label: String, strategies: [String])] = [
        ("duringUrges", ["breathing", "grounding", "urgeSurfing", "acceptance", "observation"]),
        ("duringAnxiety", ["relaxation", "mindfulness", "compassion", "walk"]),
    ]

    var body: some View {
        let text = { (key: String) in model.strings.copingLibraryText(key: key) }
        List {
            Section {
            } header: {
                Text(text("intro"))
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "copingLibrary")
            ForEach(Self.categories, id: \.label) { category in
                Section {
                    ForEach(category.strategies, id: \.self) { strategy in
                        DisclosureGroup {
                            Text(text(strategy + "Body"))
                                .font(.subheadline)
                                .foregroundStyle(AppColors.textSecondary)
                                .padding(.vertical, 4)
                        } label: {
                            Text(text(strategy + "Title")).font(.body.weight(.semibold))
                        }
                    }
                } header: {
                    Text(text(category.label))
                }
                .listRowBackground(AppColors.card)
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(model.strings.recoveryToolTitle(tool: "copingLibrary"))
    }
}
