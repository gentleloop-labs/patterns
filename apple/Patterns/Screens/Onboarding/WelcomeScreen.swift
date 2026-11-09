import PatternsCore
import SwiftUI

/// `WelcomeScreen` from `lib/mobile/screens/onboarding_screen.dart`: two
/// calm screens. The first states the promise and privacy; the second asks
/// what would help right now and routes straight into that activity.
struct WelcomeScreen: View {
    let onChoosePath: (FirstRunPath) -> Void
    let onImport: () -> Void

    @Environment(AppModel.self) private var model
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var page = 0

    var body: some View {
        let strings = model.strings
        VStack(spacing: 0) {
            HStack {
                if page == 1 {
                    Button { setPage(0) } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(AppColors.textPrimary)
                            .frame(width: 44, height: 44)
                    }
                    .accessibilityLabel(strings.backAction)
                    .transition(.opacity)
                }
                Spacer()
            }
            .frame(height: 44)

            ZStack {
                if page == 0 {
                    PromiseView(onGetStarted: { setPage(1) }, onImport: onImport)
                        .transition(slide(forward: false))
                } else {
                    ChoicesView(onChoose: onChoosePath)
                        .transition(slide(forward: true))
                }
            }
            .frame(maxHeight: .infinity)
            // Pages scroll edge to edge so card shadows are not clipped.
            .padding(.horizontal, -22)

            Text(strings.onboardingSafetyFootnote)
                .textRole(.bodySmall, color: AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
        }
        .padding(EdgeInsets(top: 12, leading: 22, bottom: 18, trailing: 22))
        .background(AppColors.surface.ignoresSafeArea())
    }

    private func setPage(_ value: Int) {
        withAnimation(reduceMotion ? nil : .easeOut(duration: 0.3)) { page = value }
    }

    private func slide(forward: Bool) -> AnyTransition {
        reduceMotion ? .identity : .asymmetric(
            insertion: .move(edge: forward ? .trailing : .leading).combined(with: .opacity),
            removal: .move(edge: forward ? .trailing : .leading).combined(with: .opacity)
        )
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
                Text(verbatim: "PATTERNS")
                    .font(.sans(12, .heavy, relativeTo: .caption))
                    .tracking(3)
                    .foregroundStyle(AppColors.accent)
                    .padding(.top, 20)
                    .accessibilityHidden(true)
                SignalHero()
                    .padding(.top, 26)
                Text(strings.onboardingHeadline)
                    .font(.custom(AppFont.display, size: 32, relativeTo: .largeTitle).weight(.semibold))
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, 30)
                Text(strings.onboardingIntroduction)
                    .textRole(.bodyLarge, color: AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 14)
                HStack(spacing: 12) {
                    Image(systemName: "lock")
                        .font(.system(size: 15))
                        .foregroundStyle(AppColors.accent)
                        .frame(width: 34, height: 34)
                        .background(AppColors.accent.opacity(0.14), in: .circle)
                        .accessibilityHidden(true)
                    Text(strings.onboardingPrivacy)
                        .font(.sans(13.5, relativeTo: .footnote))
                        .foregroundStyle(AppColors.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(15)
                .modifier(GlassCard())
                .padding(.top, 22)
                Button(strings.getStartedAction, action: onGetStarted)
                    .buttonStyle(PrimaryButtonStyle(fullWidth: true))
                    .padding(.top, 24)
                Button(strings.importExistingDataAction, action: onImport)
                    .buttonStyle(TextLinkButtonStyle())
            }
            .padding(.horizontal, 22)
        }
        .scrollBounceBehavior(.basedOnSize)
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
            (.journal, "pencil", strings.onboardingJournalTitle, strings.onboardingJournalSubtitle),
            (.erp, "leaf", strings.onboardingErpTitle, strings.onboardingErpSubtitle),
            (.selfcheck, "list.clipboard", strings.onboardingSelfCheckTitle, strings.onboardingSelfCheckSubtitle),
            (.explore, "safari", strings.onboardingExploreTitle, strings.onboardingExploreSubtitle),
        ]
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text(strings.onboardingQuestion)
                    .font(.custom(AppFont.display, size: 28, relativeTo: .largeTitle).weight(.semibold))
                    .foregroundStyle(AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                Text(strings.onboardingPickOne)
                    .textRole(.bodyMedium, color: AppColors.textSecondary)
                    .padding(.top, 8)
                VStack(spacing: 10) {
                    ForEach(choices, id: \.0) { path, icon, title, subtitle in
                        ChoiceCard(systemImage: icon, title: title, subtitle: subtitle) { onChoose(path) }
                    }
                }
                .padding(.top, 18)
            }
            .padding(.top, 6)
            .padding(.bottom, 4)
            .padding(.horizontal, 22)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

private struct ChoiceCard: View {
    let systemImage: String
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: systemImage)
                    .font(.system(size: 18))
                    .foregroundStyle(AppColors.accent)
                    .frame(width: 42, height: 42)
                    .background(AppColors.accent.opacity(0.13), in: .circle)
                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.sans(15.5, .bold, relativeTo: .subheadline))
                        .foregroundStyle(AppColors.textPrimary)
                    Text(subtitle)
                        .font(.sans(12.5, relativeTo: .footnote))
                        .foregroundStyle(AppColors.textSecondary)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding(16)
            .modifier(GlassCard())
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityHint(subtitle)
        .accessibilityAddTraits(.isButton)
    }
}

/// `_glassDecoration`: card, hairline and a soft shadow.
struct GlassCard: ViewModifier {
    @Environment(\.colorScheme) private var scheme

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppColors.card, in: .rect(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(AppColors.border))
            .shadow(color: .black.opacity(scheme == .dark ? 0.22 : 0.07), radius: 10, y: 10)
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
