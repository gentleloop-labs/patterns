import PatternsCore
import SwiftUI

/// Shown when the data cannot be opened safely. It never offers to reset or
/// delete anything: the user's files stay exactly as they are, so an update
/// or support can recover them.
///
/// There is no `AppModel` here, so the copy comes straight from the saved
/// language setting.
struct BootstrapFailureView: View {
    let failure: AppBootstrap.Failure
    let retry: () -> Void

    private let strings: Strings = {
        let prefs = FlutterPreferences()
        let language = prefs.string(PreferenceKey.appLanguage).flatMap(AppLanguage.init(rawValue:)) ?? .english
        return Strings.load(locale: LocaleResolver.effectiveLocale(language: language))
    }()

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "externaldrive.badge.exclamationmark")
                .font(.system(size: 40))
                .foregroundStyle(AppColors.accent)
                .accessibilityHidden(true)
            Text(title)
                .textRole(.headlineMedium)
                .foregroundStyle(AppColors.textPrimary)
                .multilineTextAlignment(.center)
            Text(message)
                .textRole(.bodyMedium)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
            if case .unreadable = failure {
                Button(strings.dataErrorText(key: "retry"), action: retry)
                    .buttonStyle(.accentProminent)
                    .controlSize(.large)
            }
            Link(strings.dataErrorText(key: "help"), destination: URL(string: "https://patternsocd.com")!)
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.surface)
    }

    private var title: String {
        switch failure {
        case .newerData: strings.dataErrorText(key: "newerTitle")
        case .unreadable: strings.dataErrorText(key: "unreadableTitle")
        }
    }

    private var message: String {
        switch failure {
        case .newerData: strings.dataErrorText(key: "newerBody")
        case .unreadable: strings.dataErrorText(key: "unreadableBody")
        }
    }
}
