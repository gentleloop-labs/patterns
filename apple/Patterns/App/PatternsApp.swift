import PatternsCore
import SwiftUI
import UIKit
import UserNotifications

@main
struct PatternsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @State private var launch = AppBootstrap.start()

    var body: some Scene {
        WindowGroup {
            switch launch {
            case let .success(model):
                RootView()
                    .environment(model)
                    .environment(model.navigation)
                    .preferredColorScheme(model.colorScheme)
                    .environment(\.locale, model.strings.locale)
            case let .failure(failure):
                BootstrapFailureView(failure: failure) {
                    launch = AppBootstrap.start()
                }
            }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Present the daily reminder even while the app is open, as the
        // Flutter app did.
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping @Sendable (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .list, .sound])
    }
}
