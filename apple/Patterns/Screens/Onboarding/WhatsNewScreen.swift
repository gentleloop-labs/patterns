import SwiftUI

/// Shown once to someone updating to the native 2.0 app, before the home
/// screen. Same layout as Flutter's `WhatsNewScreen`, with the 2.0 copy.
struct WhatsNewScreen: View {
    let onShowHome: () -> Void
    let onContinue: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let features = [
            ("iphone", strings.whatsNew20NativeTitle, strings.whatsNew20NativeBody),
            ("bolt", strings.whatsNew20FastTitle, strings.whatsNew20FastBody),
            ("textformat.size", strings.whatsNew20SettingsTitle, strings.whatsNew20SettingsBody),
            ("photo.on.rectangle", strings.whatsNew20PhotosTitle, strings.whatsNew20PhotosBody),
        ]
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text(strings.whatsNew20Title)
                    .textRole(.displaySmall, color: AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, 48)
                Text(strings.whatsNew20Body)
                    .font(.body)
                    .foregroundStyle(AppColors.textSecondary)
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
                                Text(body).font(.subheadline).foregroundStyle(AppColors.textSecondary)
                            }
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                .padding(.top, 36)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 28)
            .frame(maxWidth: 560, alignment: .leading)
            .frame(maxWidth: .infinity)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 8) {
                Button(action: onShowHome) {
                    Text(strings.whatsNew20ExploreAction).frame(maxWidth: .infinity)
                }
                .buttonStyle(.accentProminent)
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
