import SwiftUI

/// `WhatsNewScreen` from `lib/mobile/main_shell.dart`: shown once to an
/// upgraded user before the home screen.
struct WhatsNewScreen: View {
    let onShowHome: () -> Void
    let onContinue: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let features = [
            ("globe", strings.whatsNewLanguagesTitle, strings.whatsNewLanguagesBody),
            ("square.3.layers.3d", strings.whatsNewPrivateTitle, strings.whatsNewPrivateBody),
            ("heart", strings.whatsNewReportsTitle, strings.whatsNewReportsBody),
        ]
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text(strings.whatsNewTitle)
                    .textRole(.displaySmall, color: AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, 48)
                Text(strings.whatsNewBody)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .padding(.top, 10)
                VStack(alignment: .leading, spacing: 26) {
                    ForEach(features, id: \.1) { icon, title, body in
                        HStack(alignment: .top, spacing: 16) {
                            Image(systemName: icon)
                                .font(.title)
                                .foregroundStyle(AppColors.accent)
                                .frame(width: 44)
                                .accessibilityHidden(true)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(title).font(.headline)
                                Text(body).font(.subheadline).foregroundStyle(.secondary)
                            }
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                .padding(.top, 36)
                Text(strings.whatsNewNotificationNote)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 32)
            }
            .padding(.horizontal, 28)
            .frame(maxWidth: 560, alignment: .leading)
            .frame(maxWidth: .infinity)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 8) {
                Button(action: onShowHome) {
                    Text(strings.whatsNewExploreAction).frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                Button(strings.continueToPatternsAction, action: onContinue)
                    .padding(.vertical, 6)
            }
            .padding(.horizontal, 28)
            .padding(.top, 12)
            .background(AppColors.surface)
        }
        .background(AppColors.surface.ignoresSafeArea())
    }
}
