import SwiftUI

/// `_ToastCard` as a system-style banner: a material capsule with a
/// tinted symbol, dropping in from the top like iOS's own status banners.
struct ToastView: View {
    let toast: Toast

    var body: some View {
        HStack(spacing: 10) {
            if let icon {
                Image(systemName: icon)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(accent)
                    .accessibilityHidden(true)
            }
            Text(toast.message)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color(.label))
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .background(.regularMaterial, in: .capsule)
        .shadow(color: .black.opacity(0.12), radius: 12, y: 6)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(toast.message)
    }

    private var icon: String? {
        switch toast.kind {
        case .success: "checkmark.circle.fill"
        case .error: "exclamationmark.triangle.fill"
        case .info: "info.circle.fill"
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
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 44))
                .foregroundStyle(AppColors.positive)
                .accessibilityHidden(true)
            Text(title(strings))
                .font(.title2.weight(.bold))
                .multilineTextAlignment(.center)
                .padding(.top, 14)
            Text(body(strings))
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
            Button(action: onDone) {
                Text(strings.doneForNowAction).frame(maxWidth: .infinity)
            }
            .buttonStyle(.accentProminent)
            .controlSize(.large)
            .padding(.top, 24)
        }
        .padding(.horizontal, 24)
        .padding(.top, 32)
        .padding(.bottom, 12)
        .fixedSize(horizontal: false, vertical: true)
        .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height = $0 }
        .presentationDetents([.height(height)])
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

/// Shows the current toast at the top. The root view hosts one, and so does
/// every sheet, since a sheet covers the root's.
struct ToastHost: View {
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            if let toast = navigation.toast {
                ToastView(toast: toast)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .id(toast.id)
                    .onTapGesture { navigation.dismissToast() }
            }
        }
        .animation(reduceMotion ? nil : .easeOut(duration: 0.22), value: navigation.toast)
    }
}

/// Flutter's centred confirmation dialogs as system alerts.
struct AppDialogAlert: ViewModifier {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation

    func body(content: Content) -> some View {
        let strings = model.strings
        let dialog = navigation.dialog
        content.alert(dialog.map { title($0, strings) } ?? "",
                      isPresented: Binding(get: { navigation.dialog != nil }, set: { if !$0 { navigation.dialog = nil } }),
                      presenting: dialog) { dialog in
            Button(action(dialog, strings)) { navigation.dialog = nil }
        } message: { dialog in
            Text(message(dialog, strings))
        }
    }

    private func title(_ dialog: AppDialog, _ strings: Strings) -> String {
        switch dialog {
        case let .proUnlocked(restored): restored ? strings.proPaywallWelcomeBack : strings.proPaywallAllSet
        case .tipThanks: strings.tipThanksTitle
        }
    }

    private func message(_ dialog: AppDialog, _ strings: Strings) -> String {
        switch dialog {
        case let .proUnlocked(restored): restored ? strings.proPaywallRestoredBody : strings.proPaywallUnlockedBody
        case .tipThanks: strings.tipThanksBody
        }
    }

    private func action(_ dialog: AppDialog, _ strings: Strings) -> String {
        switch dialog {
        case .proUnlocked: strings.proPaywallContinueAction
        case .tipThanks: strings.tipThanksAction
        }
    }
}
