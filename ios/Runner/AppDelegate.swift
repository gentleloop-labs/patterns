import Flutter
import StoreKit
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Lets flutter_local_notifications present the daily reminder while the app
    // is in the foreground.
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "PatternsOfferCodes") {
      OfferCodeRedeemer.register(with: registrar)
    }
  }
}

/// Presents Apple's offer-code sheet. StoreKit 2's sheet is used where available
/// because it also works with Xcode's local StoreKit testing; the redeemed
/// purchase then arrives through the in_app_purchase transaction stream.
enum OfferCodeRedeemer {
  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "patterns/offer_codes",
      binaryMessenger: registrar.messenger()
    )
    channel.setMethodCallHandler { call, result in
      guard call.method == "presentRedeemSheet" else {
        result(FlutterMethodNotImplemented)
        return
      }
      presentRedeemSheet(result)
    }
  }

  private static func presentRedeemSheet(_ result: @escaping FlutterResult) {
    guard #available(iOS 16.0, *) else {
      SKPaymentQueue.default().presentCodeRedemptionSheet()
      result(nil)
      return
    }
    let scene = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .first { $0.activationState == .foregroundActive }
    guard let scene else {
      result(FlutterError(code: "no_scene", message: "No active window scene", details: nil))
      return
    }
    Task { @MainActor in
      do {
        try await AppStore.presentOfferCodeRedeemSheet(in: scene)
        result(nil)
      } catch {
        result(FlutterError(code: "redeem_failed", message: "\(error)", details: nil))
      }
    }
  }
}
