import SwiftUI

extension View {
    /// The warm brand background behind a grouped list, in place of the
    /// system grey; rows use `AppColors.card`.
    func appListBackground() -> some View {
        scrollContentBackground(.hidden)
            .background(AppColors.surface)
    }
}

/// The system's prominent (filled) button, with its label in `onAccent`
/// instead of the system's fixed white. White fails contrast on the bright
/// dark-mode gold; `onAccent` is white on the light-mode gold and near-black
/// on the dark-mode gold, so the text stays readable in both.
struct AccentProminentButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button(configuration)
            .buttonStyle(.borderedProminent)
            .foregroundStyle(AppColors.onAccent)
    }
}

extension PrimitiveButtonStyle where Self == AccentProminentButtonStyle {
    /// Use this instead of `.borderedProminent` everywhere in the app.
    static var accentProminent: AccentProminentButtonStyle { AccentProminentButtonStyle() }
}
