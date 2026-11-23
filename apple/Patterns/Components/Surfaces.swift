import SwiftUI

extension View {
    /// The warm brand background behind a grouped list, in place of the
    /// system grey; rows use `AppColors.card`.
    ///
    /// The secondary level is the brand's secondary text colour: the system
    /// grey that section headers and footers use reaches only 3.3:1 on the
    /// cream surface, under the 4.5:1 that WCAG AA asks of text.
    func appListBackground() -> some View {
        scrollContentBackground(.hidden)
            .background(AppColors.surface)
            .foregroundStyle(Color(.label), AppColors.textSecondary)
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

/// Segmented normally; a menu at accessibility text sizes, where the system
/// segmented control keeps its small, fixed-size labels.
struct AdaptiveSegmentedPickerStyle: ViewModifier {
    @Environment(\.dynamicTypeSize) private var typeSize

    func body(content: Content) -> some View {
        if typeSize.isAccessibilitySize {
            // Like the segmented control, no visible label (the section
            // header names it); VoiceOver still reads it.
            content.pickerStyle(.menu).labelsHidden()
        } else {
            content.pickerStyle(.segmented)
        }
    }
}

extension View {
    /// Use this instead of `.pickerStyle(.segmented)`.
    func adaptiveSegmented() -> some View { modifier(AdaptiveSegmentedPickerStyle()) }
}

extension DynamicTypeSize {
    /// For a title with a trailing detail (a date, a duration): side by side
    /// normally, stacked at accessibility sizes so neither breaks mid-word.
    var titleDetailLayout: AnyLayout {
        isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: 2))
            : AnyLayout(HStackLayout(alignment: .firstTextBaseline))
    }
}

/// `titleDetailLayout` as a container, reading the text size itself.
struct TitleDetail<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var typeSize
    @ViewBuilder var content: Content

    var body: some View {
        typeSize.titleDetailLayout { content }
    }
}
