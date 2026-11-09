import SwiftUI

/// Flutter's `ElevatedButton` theme: filled accent, 54pt tall, radius 18,
/// Manrope bold 15.
struct PrimaryButtonStyle: ButtonStyle {
    var fullWidth = false
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom(AppFont.sans, size: 15, relativeTo: .body).weight(.bold))
            .tracking(-0.1)
            .foregroundStyle(AppColors.onAccent)
            .padding(.horizontal, 22)
            .frame(minHeight: 54)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(AppColors.accent.opacity(isEnabled ? 1 : 0.45), in: .rect(cornerRadius: AppRadius.control))
            .opacity(configuration.isPressed ? 0.85 : 1)
            .contentShape(.rect(cornerRadius: AppRadius.control))
    }
}

/// Flutter's `OutlinedButton` theme: hairline border, primary text.
struct SecondaryButtonStyle: ButtonStyle {
    var fullWidth = false
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom(AppFont.sans, size: 15, relativeTo: .body).weight(.bold))
            .tracking(-0.1)
            .foregroundStyle(AppColors.textPrimary.opacity(isEnabled ? 1 : 0.45))
            .padding(.horizontal, 22)
            .frame(minHeight: 54)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .overlay(RoundedRectangle(cornerRadius: AppRadius.control).strokeBorder(AppColors.border))
            .opacity(configuration.isPressed ? 0.7 : 1)
            .contentShape(.rect(cornerRadius: AppRadius.control))
    }
}

/// A raised card: Flutter's `cardTheme` (radius 24, card fill, hairline).
struct CardBackground: ViewModifier {
    var padding: CGFloat = 20

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(AppColors.card, in: .rect(cornerRadius: AppRadius.card))
            .overlay(RoundedRectangle(cornerRadius: AppRadius.card).strokeBorder(AppColors.border, lineWidth: 1))
    }
}

extension View {
    func card(padding: CGFloat = 20) -> some View { modifier(CardBackground(padding: padding)) }
}

/// The compact `ElevatedButton` the Today cards use: 44pt tall, smaller
/// radius and padding than the full-width primary button.
struct CompactPrimaryButtonStyle: ButtonStyle {
    var radius: CGFloat = 14
    var horizontalPadding: CGFloat = 16
    var fullWidth = false
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom(AppFont.sans, size: 15, relativeTo: .body).weight(.bold))
            .foregroundStyle(AppColors.onAccent)
            .multilineTextAlignment(.center)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, 8)
            .frame(minHeight: 44)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(AppColors.accent.opacity(isEnabled ? 1 : 0.45), in: .rect(cornerRadius: radius))
            .opacity(configuration.isPressed ? 0.85 : 1)
            .contentShape(.rect(cornerRadius: radius))
    }
}

extension Font {
    /// Manrope at a Flutter point size, scaling with Dynamic Type.
    static func sans(_ size: CGFloat, _ weight: Font.Weight = .regular, relativeTo style: Font.TextStyle = .body) -> Font {
        .custom(AppFont.sans, size: size, relativeTo: style).weight(weight)
    }
}
