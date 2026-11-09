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
