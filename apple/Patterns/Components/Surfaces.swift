import SwiftUI

/// `_softDecoration`: card fill with a hairline border.
struct SoftSurface: ViewModifier {
    var radius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(AppColors.card, in: .rect(cornerRadius: radius))
            .overlay(RoundedRectangle(cornerRadius: radius).strokeBorder(AppColors.border.opacity(0.9), lineWidth: 1))
    }
}

extension View {
    func softSurface(radius: CGFloat) -> some View { modifier(SoftSurface(radius: radius)) }
}

/// `PressScale`: shrinks slightly while pressed, unless Reduce Motion is on.
struct PressScaleStyle: ButtonStyle {
    var scale: CGFloat = 0.96
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(.rect)
            .scaleEffect(configuration.isPressed && !reduceMotion ? scale : 1)
            .animation(reduceMotion ? nil : .easeOut(duration: 0.13), value: configuration.isPressed)
    }
}

/// `_RoundIconButton`: a 44pt soft square with one icon.
struct RoundIconButton: View {
    let systemImage: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(AppColors.textPrimary)
                .frame(width: 44, height: 44)
                .softSurface(radius: 18)
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityLabel(label)
    }
}

/// `_Card` on the journal screens: padded soft surface, radius 24.
struct SoftCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .softSurface(radius: 24)
    }
}

/// `_EmptyState`.
struct EmptyStateView: View {
    let systemImage: String
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: systemImage)
                .font(.system(size: 32))
                .foregroundStyle(AppColors.accent.opacity(0.75))
                .accessibilityHidden(true)
            Text(title)
                .textRole(.titleMedium, weight: .heavy, color: AppColors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.top, 14)
            Text(message)
                .textRole(.bodyMedium, color: AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 42)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Bottom panels

/// `_BottomPanel`: a floating rounded card above the home indicator, used
/// for confirmations and small pickers. Presented as a sheet sized to its
/// content.
private struct BottomPanelContent<Content: View>: View {
    @ViewBuilder var content: Content
    @State private var height: CGFloat = 300

    var body: some View {
        if #available(iOS 26, *) {
            // iOS 26 already floats partial sheets as an inset rounded card,
            // so the sheet itself becomes the panel. A clear background
            // there would leave an empty glass shell around our own card.
            content
                .padding(EdgeInsets(top: 28, leading: 26, bottom: 14, trailing: 26))
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height = $0 }
                .presentationDetents([.height(height)])
                .presentationBackground(AppColors.card)
                .presentationDragIndicator(.hidden)
        } else {
            content
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColors.card, in: .rect(cornerRadius: 28))
                .overlay(RoundedRectangle(cornerRadius: 28).strokeBorder(AppColors.border))
                .padding(14)
                .fixedSize(horizontal: false, vertical: true)
                .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height = $0 }
                .presentationDetents([.height(height)])
                .presentationBackground(.clear)
                .presentationDragIndicator(.hidden)
        }
    }
}

extension View {
    func bottomPanel<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        sheet(isPresented: isPresented) { BottomPanelContent(content: content) }
    }

    func bottomPanel<Item: Identifiable, Content: View>(item: Binding<Item?>, @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        sheet(item: item) { value in BottomPanelContent { content(value) } }
    }
}

/// Two side-by-side actions that stack at large text sizes, as the Flutter
/// confirmation panels do.
struct PanelActions: View {
    let secondaryTitle: String
    let primaryTitle: String
    let onSecondary: () -> Void
    let onPrimary: () -> Void
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let layout = typeSize >= .xxLarge ? AnyLayout(VStackLayout(spacing: 12)) : AnyLayout(HStackLayout(spacing: 12))
        layout {
            Button(secondaryTitle, action: onSecondary).buttonStyle(SecondaryButtonStyle(fullWidth: true))
            Button(primaryTitle, action: onPrimary).buttonStyle(PrimaryButtonStyle(fullWidth: true))
        }
    }
}
