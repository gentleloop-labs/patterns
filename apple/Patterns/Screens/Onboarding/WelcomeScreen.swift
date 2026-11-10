import PatternsCore
import SwiftUI

/// `WelcomeScreen` from `lib/mobile/screens/onboarding_screen.dart`: two
/// calm screens in a navigation stack. The first states the promise and
/// privacy; the second asks what would help right now and routes straight
/// into that activity.
struct WelcomeScreen: View {
    let onChoosePath: (FirstRunPath) -> Void
    let onImport: () -> Void

    @Environment(AppModel.self) private var model
    @State private var choosing = false

    var body: some View {
        NavigationStack {
            PromiseView(onGetStarted: { choosing = true }, onImport: onImport)
                .toolbar(.hidden, for: .navigationBar)
                .navigationDestination(isPresented: $choosing) {
                    ChoicesView(onChoose: onChoosePath)
                }
        }
    }
}

// MARK: - S1: promise and privacy

private struct PromiseView: View {
    let onGetStarted: () -> Void
    let onImport: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        ScrollView {
            VStack(spacing: 0) {
                SignalHero()
                    .padding(.top, 36)
                Text(strings.onboardingHeadline)
                    .font(.custom(AppFont.display, size: 34, relativeTo: .largeTitle).weight(.semibold))
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, 28)
                Text(strings.onboardingIntroduction)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                Label {
                    Text(strings.onboardingPrivacy)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } icon: {
                    Image(systemName: "lock.fill").foregroundStyle(AppColors.accent)
                }
                .padding(16)
                .background(AppColors.card, in: .rect(cornerRadius: 14))
                .padding(.top, 28)
            }
            .padding(.horizontal, 28)
            .frame(maxWidth: 560)
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 6) {
                Button(action: onGetStarted) {
                    Text(strings.getStartedAction).frame(maxWidth: .infinity)
                }
                .buttonStyle(.accentProminent)
                .controlSize(.large)
                Button(strings.importExistingDataAction, action: onImport)
                    .padding(.vertical, 8)
                Text(strings.onboardingSafetyFootnote)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 28)
            .padding(.top, 12)
            .background(AppColors.surface)
        }
        .background(AppColors.surface.ignoresSafeArea())
    }
}

// MARK: - S2: what would help right now?

private struct ChoicesView: View {
    let onChoose: (FirstRunPath) -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let choices: [(FirstRunPath, String, String, String)] = [
            (.urge, "hourglass", strings.onboardingUrgeTitle, strings.onboardingUrgeSubtitle),
            (.journal, "square.and.pencil", strings.onboardingJournalTitle, strings.onboardingJournalSubtitle),
            (.erp, "leaf", strings.onboardingErpTitle, strings.onboardingErpSubtitle),
            (.selfcheck, "list.clipboard", strings.onboardingSelfCheckTitle, strings.onboardingSelfCheckSubtitle),
            (.explore, "safari", strings.onboardingExploreTitle, strings.onboardingExploreSubtitle),
        ]
        List {
            Section {
                ForEach(choices, id: \.0) { path, icon, title, subtitle in
                    Button { onChoose(path) } label: {
                        HStack(spacing: 14) {
                            Image(systemName: icon)
                                .font(.title3)
                                .foregroundStyle(AppColors.accent)
                                .frame(width: 30)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(title).font(.body.weight(.semibold)).foregroundStyle(Color(.label))
                                Text(subtitle).font(.footnote).foregroundStyle(Color(.secondaryLabel))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Image(systemName: "chevron.right")
                                .font(.footnote.weight(.semibold))
                                .foregroundStyle(Color(.tertiaryLabel))
                        }
                        .padding(.vertical, 6)
                        .contentShape(.rect)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(title)
                    .accessibilityHint(subtitle)
                    .accessibilityAddTraits(.isButton)
                    .listRowBackground(AppColors.card)
                }
            } header: {
                Text(strings.onboardingPickOne)
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            } footer: {
                Text(strings.onboardingSafetyFootnote)
                    .padding(.top, 8)
            }
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(strings.onboardingQuestion)
    }
}

/// `_Hero`: concentric rings, a small signal line and a filled accent disc
/// with a feather.
private struct SignalHero: View {
    var body: some View {
        let size: CGFloat = 172
        ZStack {
            Canvas { context, canvasSize in
                let center = CGPoint(x: canvasSize.width / 2, y: canvasSize.height / 2)
                for fraction in [0.287, 0.394, 0.497] {
                    let r = canvasSize.width * fraction
                    context.stroke(Path(ellipseIn: CGRect(x: center.x - r, y: center.y - r, width: r * 2, height: r * 2)),
                                   with: .color(AppColors.accent.opacity(0.26)), lineWidth: 1.4)
                }
                var line = Path()
                var dots: [CGPoint] = []
                for i in 0..<5 {
                    let p = CGPoint(x: canvasSize.width * (0.16 + Double(i) * 0.17), y: center.y + sin(Double(i) * 1.2) * 22)
                    if i == 0 { line.move(to: p) } else { line.addLine(to: p) }
                    dots.append(p)
                }
                context.stroke(line, with: .color(AppColors.accent.opacity(0.34)),
                               style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
                for p in dots {
                    context.fill(Path(ellipseIn: CGRect(x: p.x - 3, y: p.y - 3, width: 6, height: 6)),
                                 with: .color(AppColors.accent))
                }
            }
            Circle()
                .fill(LinearGradient(colors: [AppColors.accent, AppColors.accent.opacity(0.62)],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size * 0.447, height: size * 0.447)
                .shadow(color: AppColors.accent.opacity(0.28), radius: 12, y: 10)
                .overlay {
                    Image(systemName: "leaf")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundStyle(Color(red: 0x17 / 255, green: 0x13 / 255, blue: 0x0A / 255))
                }
        }
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }
}
