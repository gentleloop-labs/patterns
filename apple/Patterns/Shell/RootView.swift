import PatternsCore
import SwiftUI

/// Mirrors `MobileShell`: welcome and first-run for new installs, otherwise
/// the main tabs. Everything sits behind the privacy gate.
struct RootView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        PrivacyGate {
            Group {
                if model.hasStarted {
                    MainShell()
                } else {
                    WelcomePlaceholder()
                }
            }
            .background(AppColors.surface.ignoresSafeArea())
        }
        .onReceive(NotificationCenter.default.publisher(for: NSLocale.currentLocaleDidChangeNotification)) { _ in
            model.refreshSystemLanguage()
        }
    }
}

/// The five bottom tabs, in Flutter's order and with its saved-tab key.
enum AppTab: String, CaseIterable, Identifiable {
    case home, journal, track, erp, insights
    var id: String { rawValue }
}

struct MainShell: View {
    @Environment(AppModel.self) private var model
    @State private var selection: AppTab = .home

    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppTab.allCases) { tab in
                PlaceholderScreen(title: title(tab))
                    .tabItem { Label(title(tab), systemImage: icon(tab)) }
                    .tag(tab)
            }
        }
        .tint(AppColors.accent)
        .onAppear {
            // `mobileSelectedTab` stores the Dart enum name.
            if let saved = model.prefs.string(PreferenceKey.mobileSelectedTab).flatMap(AppTab.init(rawValue:)) {
                selection = saved
            }
        }
        .onChange(of: selection) { _, tab in
            model.prefs.set(tab.rawValue, for: PreferenceKey.mobileSelectedTab)
        }
    }

    private func title(_ tab: AppTab) -> String {
        switch tab {
        case .home: model.strings.navToday
        case .journal: model.strings.navJournal
        case .track: model.strings.navTrack
        case .erp: model.strings.navRecovery
        case .insights: model.strings.navInsights
        }
    }

    private func icon(_ tab: AppTab) -> String {
        switch tab {
        case .home: "sun.max"
        case .journal: "book.closed"
        case .track: "waveform.path.ecg"
        case .erp: "figure.walk"
        case .insights: "chart.line.uptrend.xyaxis"
        }
    }
}

private struct PlaceholderScreen: View {
    let title: String

    var body: some View {
        NavigationStack {
            Text(title)
                .textRole(.headlineLarge)
                .foregroundStyle(AppColors.textPrimary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppColors.surface)
        }
    }
}

private struct WelcomePlaceholder: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        VStack(spacing: 24) {
            Text(model.strings.appTitle)
                .textRole(.displaySmall)
                .foregroundStyle(AppColors.textPrimary)
            Button(model.strings.unlockAction) { model.markStarted() }
                .buttonStyle(PrimaryButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
