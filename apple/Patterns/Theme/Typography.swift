import SwiftUI

/// Text roles named after Flutter's text theme. Display roles keep the
/// Fraunces serif as the brand voice for big headlines; everything else is
/// the system font at the matching Dynamic Type style, as native apps use.
enum AppFont {
    static let display = "Fraunces"
    static let sans = "Manrope"
}

enum TextRole {
    case displayLarge, displayMedium, displaySmall, headlineLarge
    case headlineMedium, headlineSmall, titleLarge, titleMedium, titleSmall
    case bodyLarge, bodyMedium, bodySmall
    case labelLarge, labelMedium, labelSmall

    struct Spec {
        let family: String
        let size: CGFloat
        let weight: Font.Weight
        let tracking: CGFloat
        let lineHeight: CGFloat
        let relativeTo: Font.TextStyle
    }

    var spec: Spec {
        switch self {
        case .displayLarge: Spec(family: AppFont.display, size: 56, weight: .medium, tracking: -1.2, lineHeight: 1.05, relativeTo: .largeTitle)
        case .displayMedium: Spec(family: AppFont.display, size: 44, weight: .medium, tracking: -0.9, lineHeight: 1.08, relativeTo: .largeTitle)
        case .displaySmall: Spec(family: AppFont.display, size: 34, weight: .medium, tracking: -0.6, lineHeight: 1.12, relativeTo: .largeTitle)
        case .headlineLarge: Spec(family: AppFont.display, size: 28, weight: .medium, tracking: -0.4, lineHeight: 1.18, relativeTo: .title)
        case .headlineMedium: Spec(family: AppFont.sans, size: 22, weight: .bold, tracking: -0.3, lineHeight: 1.22, relativeTo: .title2)
        case .headlineSmall: Spec(family: AppFont.sans, size: 18, weight: .bold, tracking: -0.2, lineHeight: 1.25, relativeTo: .title3)
        case .titleLarge: Spec(family: AppFont.sans, size: 17, weight: .bold, tracking: -0.2, lineHeight: 1.3, relativeTo: .headline)
        case .titleMedium: Spec(family: AppFont.sans, size: 15, weight: .semibold, tracking: -0.1, lineHeight: 1.35, relativeTo: .subheadline)
        case .titleSmall: Spec(family: AppFont.sans, size: 13, weight: .semibold, tracking: 0, lineHeight: 1.4, relativeTo: .footnote)
        case .bodyLarge: Spec(family: AppFont.sans, size: 16, weight: .regular, tracking: -0.1, lineHeight: 1.5, relativeTo: .body)
        case .bodyMedium: Spec(family: AppFont.sans, size: 14, weight: .regular, tracking: 0, lineHeight: 1.5, relativeTo: .callout)
        case .bodySmall: Spec(family: AppFont.sans, size: 12.5, weight: .regular, tracking: 0.05, lineHeight: 1.45, relativeTo: .footnote)
        case .labelLarge: Spec(family: AppFont.sans, size: 14, weight: .semibold, tracking: 0.1, lineHeight: 1.2, relativeTo: .callout)
        case .labelMedium: Spec(family: AppFont.sans, size: 12, weight: .semibold, tracking: 0.2, lineHeight: 1.2, relativeTo: .caption)
        case .labelSmall: Spec(family: AppFont.sans, size: 11, weight: .semibold, tracking: 0.4, lineHeight: 1.2, relativeTo: .caption2)
        }
    }
}

private struct TextRoleModifier: ViewModifier {
    let role: TextRole
    let weight: Font.Weight?
    let color: Color?
    @ScaledMetric private var size: CGFloat

    init(role: TextRole, size: CGFloat?, weight: Font.Weight?, color: Color?) {
        self.role = role
        self.weight = weight
        self.color = color
        _size = ScaledMetric(wrappedValue: size ?? role.spec.size, relativeTo: role.spec.relativeTo)
    }

    @ViewBuilder
    func body(content: Content) -> some View {
        let spec = role.spec
        let styled = Group {
            if spec.family == AppFont.display {
                content
                    .font(.custom(spec.family, fixedSize: size).weight(weight ?? spec.weight))
                    .tracking(spec.tracking)
                    .lineSpacing(max(0, size * (spec.lineHeight - 1.2)))
            } else {
                content.font(.system(spec.relativeTo, weight: weight ?? spec.weight))
            }
        }
        if let color {
            styled.foregroundStyle(color)
        } else {
            styled
        }
    }
}

extension View {
    /// Applies a Flutter text-theme role, scaled with Dynamic Type. `size`
    /// and `weight` mirror Flutter's `copyWith` overrides.
    func textRole(_ role: TextRole, size: CGFloat? = nil, weight: Font.Weight? = nil, color: Color? = nil) -> some View {
        modifier(TextRoleModifier(role: role, size: size, weight: weight, color: color))
    }
}
