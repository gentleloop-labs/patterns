import LocalAuthentication
import SwiftUI

/// App lock and app-switcher privacy cover, ported from `_PrivacyScreen` in
/// `lib/mobile/main_shell.dart`:
///
/// - Content is covered whenever the app is not active, so it never shows in
///   the app switcher.
/// - With app lock on, the app relocks only after a real trip to the
///   background, not when the Face ID prompt itself makes the app inactive.
///   (Reacting to the prompt was the cause of an infinite prompt loop.)
/// - Authentication allows the device passcode, like `local_auth`'s default.
struct PrivacyGate<Content: View>: View {
    @Environment(AppModel.self) private var model
    @Environment(\.scenePhase) private var scenePhase
    @ViewBuilder var content: Content

    @State private var locked = false
    @State private var didBackground = false
    @State private var authInProgress = false
    @State private var errorMessage: String?
    @State private var started = false

    var body: some View {
        let lifecycleCovered = scenePhase != .active
        let covered = lifecycleCovered || locked
        ZStack {
            content
                .accessibilityHidden(covered)
            if covered {
                PrivacyCover(
                    showUnlock: locked && !lifecycleCovered,
                    unlockBusy: authInProgress,
                    message: lifecycleCovered ? nil : errorMessage,
                    onUnlock: authenticate
                )
                .transition(.opacity)
            }
        }
        .animation(.easeOut(duration: 0.12), value: covered)
        .onAppear {
            guard !started else { return }
            started = true
            locked = model.appLockEnabled
            if locked { authenticate() }
        }
        .onChange(of: scenePhase) { _, phase in
            if authInProgress { return }
            switch phase {
            case .background:
                didBackground = true
                if model.appLockEnabled { locked = true }
            case .active:
                let shouldReauth = didBackground
                didBackground = false
                if shouldReauth, locked, model.appLockEnabled { authenticate() }
            default:
                break
            }
        }
        .onChange(of: model.appLockEnabled) { _, enabled in
            // Settings authenticates before enabling, so never re-prompt
            // here. Only clear the cover when the lock is turned off.
            if !enabled { locked = false }
        }
    }

    private func authenticate() {
        guard !authInProgress, model.appLockEnabled else { return }
        authInProgress = true
        errorMessage = nil
        let strings = model.strings
        let context = LAContext()
        var supportError: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &supportError) else {
            // No passcode or biometrics any more: turn the lock off rather
            // than trapping the user behind a cover they cannot satisfy.
            model.setAppLockEnabled(false)
            locked = false
            if supportError != nil { errorMessage = strings.appLockUnavailableDisabled }
            finishAuthentication()
            return
        }
        Task { @MainActor in
            do {
                let ok = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: strings.appUnlockReason)
                if ok { locked = false }
            } catch let error as LAError {
                switch error.code {
                case .userCancel, .systemCancel, .appCancel, .userFallback:
                    break // No fault: leave the Unlock button for a retry.
                case .biometryLockout:
                    errorMessage = strings.settingsText(key: "appLockBiometricLockout")
                case .passcodeNotSet, .biometryNotEnrolled, .biometryNotAvailable:
                    model.setAppLockEnabled(false)
                    locked = false
                    errorMessage = strings.appLockUnavailableDisabled
                default:
                    errorMessage = strings.appUnlockFailed
                }
            } catch {
                errorMessage = strings.appUnlockFailed
            }
            finishAuthentication()
        }
    }

    /// Clears the in-flight flag on the next run loop, after the `active`
    /// phase change the prompt triggers, so that change cannot re-prompt.
    private func finishAuthentication() {
        DispatchQueue.main.async { authInProgress = false }
    }
}

private struct PrivacyCover: View {
    @Environment(AppModel.self) private var model
    let showUnlock: Bool
    let unlockBusy: Bool
    let message: String?
    let onUnlock: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "lock.fill")
                .font(.system(size: 44))
                .foregroundStyle(AppColors.textSecondary)
                .accessibilityElement()
                .accessibilityLabel(model.strings.privacyScreenLabel)
            if showUnlock {
                Button(unlockBusy ? model.strings.unlockingAction : model.strings.unlockAction, action: onUnlock)
                    .buttonStyle(.accentProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                    .disabled(unlockBusy)
                    .padding(.top, 24)
            }
            if let message {
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.top, 16)
                    .accessibilityAddTraits(.updatesFrequently)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.surface)
    }
}
