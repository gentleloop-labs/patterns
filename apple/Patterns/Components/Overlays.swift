import SwiftUI

/// `_ToastCard`: a calm floating card with an optional tinted icon.
struct ToastView: View {
    let toast: Toast

    var body: some View {
        HStack(spacing: 12) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(accent)
                    .frame(width: 30, height: 30)
                    .background(accent.opacity(0.16), in: .circle)
                    .accessibilityHidden(true)
            }
            Text(toast.message)
                .font(.custom(AppFont.sans, size: 14, relativeTo: .callout).weight(.semibold))
                .foregroundStyle(AppColors.textPrimary)
                .lineSpacing(2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, icon == nil ? 16 : 12)
        .padding([.vertical, .trailing], 12)
        .padding(.trailing, 4)
        .background(AppColors.card, in: .rect(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(AppColors.border))
        .shadow(color: .black.opacity(0.18), radius: 9, y: 6)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(toast.message)
    }

    private var icon: String? {
        switch toast.kind {
        case .success: "checkmark"
        case .error: "exclamationmark.triangle"
        case .info: "info.circle"
        case .neutral: nil
        }
    }

    private var accent: Color {
        switch toast.kind {
        case .success: AppColors.positive
        case .error: AppColors.negative
        case .info, .neutral: AppColors.accent
        }
    }
}

/// `showQuietCompletion`: a sheet the user closes with "Done for now".
struct CompletionSheet: View {
    @Environment(AppModel.self) private var model
    let kind: CompletionKind
    let onDone: () -> Void
    @State private var height: CGFloat = 320

    var body: some View {
        let strings = model.strings
        VStack(spacing: 0) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 32))
                .foregroundStyle(AppColors.textPrimary)
                .accessibilityHidden(true)
            Text(title(strings))
                .textRole(.headlineSmall, weight: .heavy, color: AppColors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.top, 16)
            Text(body(strings))
                .textRole(.bodyMedium, color: AppColors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
            Button(strings.doneForNowAction, action: onDone)
                .buttonStyle(PrimaryButtonStyle(fullWidth: true))
                .padding(.top, 24)
        }
        .padding(.horizontal, 24)
        .padding(.top, 28)
        .padding(.bottom, 12)
        .fixedSize(horizontal: false, vertical: true)
        .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height = $0 }
        .presentationDetents([.height(height)])
        .presentationBackground(AppColors.card)
        .interactiveDismissDisabled()
        .accessibilityElement(children: .contain)
        .onAppear {
            UIAccessibility.post(notification: .screenChanged,
                                 argument: strings.completionAnnouncement(title: title(strings), body: body(strings)))
        }
    }

    private func title(_ strings: Strings) -> String {
        switch kind {
        case .journal, .trackedMoment: strings.completionSavedTitle
        case .compulsionDelay, .erp: strings.completionPracticeTitle
        }
    }

    private func body(_ strings: Strings) -> String {
        switch kind {
        case .journal: strings.completionJournalBody
        case let .trackedMoment(updated): updated ? strings.completionTrackedUpdatedBody : strings.completionTrackedBody
        case .compulsionDelay: strings.completionDelayBody
        case .erp: strings.completionErpBody
        }
    }
}

/// Shows the current toast. The root view hosts one, and so does every
/// bottom panel, since a sheet covers the root's.
struct ToastHost: View {
    var bottomPadding: CGFloat = 96
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            if let toast = navigation.toast {
                ToastView(toast: toast)
                    .padding(.horizontal, 16)
                    .padding(.bottom, bottomPadding)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .id(toast.id)
                    .onTapGesture { navigation.dismissToast() }
            }
        }
        .animation(reduceMotion ? nil : .easeOut(duration: 0.22), value: navigation.toast)
    }
}

/// Flutter's centred `Dialog` cards: a dimmed backdrop that closes on tap,
/// and a card with an icon, a title, a message and one button.
struct DialogHost: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            if let dialog = navigation.dialog {
                Color.black.opacity(0.45)
                    .ignoresSafeArea()
                    .onTapGesture { navigation.dialog = nil }
                    .accessibilityHidden(true)
                    .transition(.opacity)
                DialogCard(content: content(dialog, model.strings)) { navigation.dialog = nil }
                    .padding(.horizontal, 28)
                    .padding(.vertical, 24)
                    .transition(.opacity.combined(with: .scale(scale: reduceMotion ? 1 : 0.96)))
            }
        }
        .animation(reduceMotion ? nil : .easeOut(duration: 0.2), value: navigation.dialog)
    }

    private func content(_ dialog: AppDialog, _ strings: Strings) -> DialogCard.Content {
        switch dialog {
        case let .proUnlocked(restored):
            DialogCard.Content(
                systemImage: "lock.open",
                title: restored ? strings.proPaywallWelcomeBack : strings.proPaywallAllSet,
                message: restored ? strings.proPaywallRestoredBody : strings.proPaywallUnlockedBody,
                action: strings.proPaywallContinueAction
            )
        case .tipThanks:
            DialogCard.Content(
                systemImage: "heart",
                title: strings.tipThanksTitle,
                message: strings.tipThanksBody,
                action: strings.tipThanksAction
            )
        }
    }
}

private struct DialogCard: View {
    struct Content {
        let systemImage: String
        let title: String
        let message: String
        let action: String
    }

    let content: Content
    let onClose: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                AccentIconBadge(systemImage: content.systemImage)
                Text(content.title)
                    .textRole(.titleLarge, size: 20, weight: .heavy, color: AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, 16)
                Text(content.message)
                    .textRole(.bodyMedium, color: AppColors.textSecondary)
                    .padding(.top, 8)
                Button(content.action, action: onClose)
                    .buttonStyle(PrimaryButtonStyle(fullWidth: true))
                    .padding(.top, 20)
            }
            .padding(EdgeInsets(top: 22, leading: 22, bottom: 18, trailing: 22))
            .background(AppColors.card, in: .rect(cornerRadius: 24))
            .overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(AppColors.border))
        }
        .scrollBounceBehavior(.basedOnSize)
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: 420)
        .accessibilityElement(children: .contain)
        .accessibilityAddTraits(.isModal)
        .onAppear {
            UIAccessibility.post(notification: .screenChanged, argument: content.title)
        }
    }
}

/// The 44pt tinted circle with an accent icon at the top of the Pro and tip
/// panels.
struct AccentIconBadge: View {
    let systemImage: String

    var body: some View {
        Image(systemName: systemImage)
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(AppColors.accent)
            .frame(width: 44, height: 44)
            .background(AppColors.accent.opacity(0.14), in: .circle)
            .accessibilityHidden(true)
    }
}

/// Material's default `TextButton`: accent label, 44pt tall.
struct TextLinkButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom(AppFont.sans, size: 14, relativeTo: .callout).weight(.semibold))
            .foregroundStyle(AppColors.accent.opacity(isEnabled ? 1 : 0.45))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)
            .frame(minHeight: 44)
            .contentShape(.rect)
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}
