import SwiftUI

/// Shown when the data cannot be opened safely. It never offers to reset or
/// delete anything: the user's files stay exactly as they are, so an update
/// or support can recover them.
///
/// Copy is English-only until these strings join the ARB files.
struct BootstrapFailureView: View {
    let failure: AppBootstrap.Failure
    let retry: () -> Void

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
                Button("Try again", action: retry)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
            }
            Link("Get help", destination: URL(string: "https://patternsocd.com")!)
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.surface)
    }

    private var title: String {
        switch failure {
        case .newerData: "This data needs a newer Patterns"
        case .unreadable: "Patterns could not open your data"
        }
    }

    private var message: String {
        switch failure {
        case .newerData:
            "Your entries were saved by a newer version of Patterns. Update the app from the App Store to open them. Nothing has been changed or deleted."
        case .unreadable:
            "Your entries are still on this iPhone and have not been changed. Try again. If this keeps happening, get help at patternsocd.com."
        }
    }
}
