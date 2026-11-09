import SwiftUI

/// `WhatsNewScreen` from `lib/mobile/main_shell.dart`: shown once to an
/// upgraded user before the home screen.
struct WhatsNewScreen: View {
    let onShowHome: () -> Void
    let onContinue: () -> Void
    @Environment(AppModel.self) private var model
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        let strings = model.strings
        let features = [
            ("checkmark.circle", strings.whatsNewLanguagesTitle, strings.whatsNewLanguagesBody),
            ("square.3.layers.3d", strings.whatsNewPrivateTitle, strings.whatsNewPrivateBody),
            ("heart", strings.whatsNewReportsTitle, strings.whatsNewReportsBody),
        ]
        ScrollView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 22))
                        .foregroundStyle(AppColors.accent)
                        .frame(width: 54, height: 54)
                        .background(AppColors.accent.opacity(0.16), in: .circle)
                        .accessibilityHidden(true)
                    Text(strings.whatsNewTitle)
                        .font(.custom(AppFont.display, size: 35, relativeTo: .largeTitle).weight(.bold))
                        .tracking(-0.8)
                        .foregroundStyle(AppColors.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                        .padding(.top, 24)
                    Text(strings.whatsNewBody)
                        .font(.sans(15, relativeTo: .body))
                        .foregroundStyle(AppColors.textSecondary)
                        .padding(.top, 12)
                }
                .padding(22)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColors.card, in: .rect(cornerRadius: 30))
                .overlay(RoundedRectangle(cornerRadius: 30).strokeBorder(AppColors.border))
                .shadow(color: .black.opacity(scheme == .dark ? 0.35 : 0.12), radius: 15, y: 16)

                VStack(spacing: 10) {
                    ForEach(features, id: \.1) { icon, title, body in
                        HStack(spacing: 14) {
                            Image(systemName: icon)
                                .font(.system(size: 19))
                                .foregroundStyle(AppColors.accent)
                                .frame(width: 42, height: 42)
                                .background(AppColors.accent.opacity(0.14), in: .rect(cornerRadius: 14))
                                .accessibilityHidden(true)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(title).font(.sans(15, .heavy, relativeTo: .subheadline))
                                    .foregroundStyle(AppColors.textPrimary)
                                Text(body).font(.sans(12.5, relativeTo: .footnote))
                                    .foregroundStyle(AppColors.textSecondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(16)
                        .background(AppColors.card, in: .rect(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(AppColors.border))
                        .accessibilityElement(children: .combine)
                    }
                }
                .padding(.top, 18)

                Button(strings.whatsNewExploreAction, action: onShowHome)
                    .buttonStyle(PrimaryButtonStyle(fullWidth: true))
                    .padding(.top, 22)
                Button(strings.continueToPatternsAction, action: onContinue)
                    .buttonStyle(TextLinkButtonStyle())
                    .padding(.top, 10)
                Text(strings.whatsNewNotificationNote)
                    .font(.sans(12, relativeTo: .caption))
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 18)
            }
            .padding(EdgeInsets(top: 28, leading: 22, bottom: 28, trailing: 22))
        }
        .background(AppColors.surface.ignoresSafeArea())
    }
}
