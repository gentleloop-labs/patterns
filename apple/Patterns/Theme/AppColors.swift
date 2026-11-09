import SwiftUI
import UIKit

/// Semantic colours, ported value for value from `lib/theme/app_colors.dart`
/// (`AppColors.light` and `AppColors.dark`). Each resolves per appearance.
enum AppColors {
    static let surface = adaptive(light: 0xF7F3EA, dark: 0x141414)
    static let card = adaptive(light: 0xFFFCF6, dark: 0x1E1E1E)
    static let input = adaptive(light: 0xEEE8DC, dark: 0x252525)
    static let border = adaptive(light: 0xD8D0C2, dark: 0x343434)
    static let textPrimary = adaptive(light: 0x201D18, dark: 0xF4F0E8)
    static let textSecondary = adaptive(light: 0x6F685F, dark: 0xA9A39A)
    /// Darker on light surfaces so text and controls keep AA contrast.
    static let accent = adaptive(light: 0x8A6500, dark: 0xF4C95D)
    static let positive = adaptive(light: 0x407A52, dark: 0x7BBF91)
    static let negative = adaptive(light: 0xA13F3F, dark: 0xD26A6A)
    static let obsessionChip = adaptive(light: 0x5B4B8A, dark: 0x41356A)
    static let compulsionChip = adaptive(light: 0x8A5A18, dark: 0xB5731A)

    /// Text and icons drawn on top of `accent` (filled buttons).
    static let onAccent = adaptive(light: 0xFFFFFF, dark: 0x17130A)

    static func adaptive(light: UInt32, dark: UInt32) -> Color {
        Color(UIColor { traits in
            UIColor(rgb: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

extension UIColor {
    convenience init(rgb: UInt32, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: alpha
        )
    }
}

/// Corner radii used across the Flutter theme.
enum AppRadius {
    /// Cards and sheets.
    static let card: CGFloat = 24
    /// Buttons and text fields.
    static let control: CGFloat = 18
}
