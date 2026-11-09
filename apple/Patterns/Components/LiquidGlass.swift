import SwiftUI

/// `LiquidGlass` from `lib/widgets/liquid_glass.dart`: a blurred, slightly
/// saturated backdrop under a translucent gradient body, with a bright rim
/// along the top edge and an optional drop shadow.
struct LiquidGlass<S: InsettableShape>: ViewModifier {
    let shape: S
    /// Accent wash folded into the body (the add button's amber glass).
    var tint: Color?
    /// Overall opacity of the body (Flutter's `opacity`).
    var opacity: Double = 1
    var saturation: Double = 1.6
    var shadow: Shadow?

    struct Shadow {
        var color: Color
        var radius: CGFloat
        var y: CGFloat
    }

    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    // The material stands in for Flutter's backdrop blur; the
                    // saturation boost matches its colour matrix.
                    shape.fill(.ultraThinMaterial).saturation(saturation)
                    shape.fill(LinearGradient(colors: bodyColors, startPoint: .top, endPoint: .bottom))
                }
            }
            .clipShape(shape)
            .overlay {
                // `_GlassRim`: top-bright, bottom-faint bevel.
                shape.strokeBorder(
                    LinearGradient(stops: [
                        .init(color: .white.opacity(0.55), location: 0),
                        .init(color: .white.opacity(0.10), location: 0.45),
                        .init(color: .white.opacity(0.04), location: 1),
                    ], startPoint: .top, endPoint: .bottom),
                    lineWidth: 1.2
                )
                .allowsHitTesting(false)
            }
            // The shadow sits outside the clip. Drawn from an opaque shape
            // masked away inside, so it never darkens the translucent body.
            .background {
                if let shadow {
                    shape.fill(Color.black)
                        .shadow(color: shadow.color, radius: shadow.radius, y: shadow.y)
                        .mask {
                            Rectangle().padding(-(shadow.radius * 3 + abs(shadow.y)))
                                .overlay(shape.blendMode(.destinationOut))
                                .compositingGroup()
                        }
                }
            }
    }

    private var bodyColors: [Color] {
        if let tint {
            [tint.opacity(0.88 * opacity), tint.opacity(0.64 * opacity)]
        } else {
            [.white.opacity(0.14 * opacity), AppColors.surface.opacity(0.40 * opacity)]
        }
    }
}

extension View {
    func liquidGlass<S: InsettableShape>(_ shape: S, tint: Color? = nil, opacity: Double = 1,
                                         saturation: Double = 1.6,
                                         shadow: LiquidGlass<S>.Shadow? = nil) -> some View {
        modifier(LiquidGlass(shape: shape, tint: tint, opacity: opacity, saturation: saturation, shadow: shadow))
    }
}

extension DynamicTypeSize {
    /// The text scale Flutter reports on iOS for this setting (body size
    /// relative to Large), for layouts that scale the way Flutter's do.
    var flutterTextScale: CGFloat {
        switch self {
        case .xSmall: 14 / 17
        case .small: 15 / 17
        case .medium: 16 / 17
        case .large: 1
        case .xLarge: 19 / 17
        case .xxLarge: 21 / 17
        case .xxxLarge: 23 / 17
        case .accessibility1: 28 / 17
        case .accessibility2: 33 / 17
        case .accessibility3: 40 / 17
        case .accessibility4: 47 / 17
        case .accessibility5: 53 / 17
        @unknown default: 1
        }
    }
}
