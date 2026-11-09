import SwiftUI

/// Where each tab segment sits, so the tour can spotlight it.
struct TabAnchorKey: PreferenceKey {
    static let defaultValue: [AppTab: Anchor<CGRect>] = [:]
    static func reduce(value: inout [AppTab: Anchor<CGRect>], nextValue: () -> [AppTab: Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}

/// One step of the tab tour: the tab to spotlight (nil for the closing
/// card), its copy, and an optional call to action.
struct TourStep {
    let tab: AppTab?
    let title: String
    let points: [String]
    var cta: String?
}

/// `showSpotlightTour` from `lib/mobile/widgets/spotlight_tour.dart`: dims
/// the screen, cuts a rounded hole around each tab in turn and explains it.
struct SpotlightTour: View {
    let steps: [TourStep]
    let anchors: [AppTab: Anchor<CGRect>]
    /// Called when a step appears, to switch to its tab.
    let onShow: (TourStep) -> Void
    /// Called when the tour ends; `runCta` is true when the closing call to
    /// action was chosen.
    let onFinish: (_ runCta: Bool) -> Void

    @Environment(AppModel.self) private var model
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var index = 0

    var body: some View {
        GeometryReader { proxy in
            let step = steps[index]
            let rect = step.tab.flatMap { anchors[$0] }.map { proxy[$0] }
            ZStack {
                Scrim(hole: rect.map { holeRect($0, in: proxy.size) })
                    .contentShape(.rect)
                    .onTapGesture {}
                    .accessibilityHidden(true)
                bubble(step)
                    .frame(maxWidth: 440)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity,
                           alignment: rect == nil ? .center : (rect!.midY < proxy.size.height / 2 ? .top : .bottom))
                    .padding(.top, rect.map { $0.midY < proxy.size.height / 2 ? $0.maxY + 14 : 0 } ?? 0)
                    .padding(.bottom, rect.map { $0.midY >= proxy.size.height / 2 ? proxy.size.height - $0.minY + 14 : 0 } ?? 0)
                    .id(index)
                    .transition(reduceMotion ? .identity : .opacity.combined(with: .offset(y: 8)))
            }
        }
        .ignoresSafeArea()
        .accessibilityAddTraits(.isModal)
        .onAppear { onShow(steps[0]) }
    }

    private func holeRect(_ rect: CGRect, in size: CGSize) -> CGRect {
        // Keep the cut-out on screen so an edge tab's ring is not clipped.
        let m: CGFloat = 5
        let r = rect.insetBy(dx: -6, dy: -6)
        let minX = min(max(r.minX, m), size.width - m), maxX = min(max(r.maxX, m), size.width - m)
        let minY = min(max(r.minY, m), size.height - m), maxY = min(max(r.maxY, m), size.height - m)
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }

    private func bubble(_ step: TourStep) -> some View {
        let strings = model.strings
        let isLast = index == steps.count - 1
        return ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(strings.tourProgress(current: index + 1, total: steps.count))
                        .font(.sans(11, .black, relativeTo: .caption))
                        .tracking(0.5)
                        .foregroundStyle(AppColors.accent)
                    Spacer()
                    if !isLast || step.cta != nil {
                        Button(strings.shellText(key: "skip")) { finish(runCta: false) }
                            .buttonStyle(TextLinkButtonStyle())
                    }
                }
                Text(step.title)
                    .font(.sans(17, .heavy, relativeTo: .headline))
                    .foregroundStyle(AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.top, 6)
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(step.points, id: \.self) { point in
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            Circle().fill(AppColors.textSecondary).frame(width: 4, height: 4)
                                .alignmentGuide(.firstTextBaseline) { $0[.bottom] + 5 }
                                .accessibilityHidden(true)
                            Text(point)
                                .font(.sans(13.5, relativeTo: .footnote))
                                .foregroundStyle(AppColors.textSecondary)
                        }
                    }
                }
                .padding(.top, 8)
                HStack {
                    Spacer()
                    Button(step.cta ?? (isLast ? strings.doneAction : strings.shellText(key: "next"))) {
                        if step.cta != nil { finish(runCta: true) } else { next() }
                    }
                    .buttonStyle(CompactPrimaryButtonStyle(horizontalPadding: 18))
                }
                .padding(.top, 14)
            }
            .padding(EdgeInsets(top: 14, leading: 18, bottom: 12, trailing: 18))
            .background(AppColors.card, in: .rect(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(AppColors.border))
            .shadow(color: .black.opacity(0.4), radius: 14, y: 14)
        }
        .scrollBounceBehavior(.basedOnSize)
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement(children: .contain)
        .onAppear { UIAccessibility.post(notification: .screenChanged, argument: step.title) }
    }

    private func next() {
        guard index < steps.count - 1 else { return finish(runCta: false) }
        withAnimation(reduceMotion ? nil : .easeOut(duration: 0.25)) { index += 1 }
        onShow(steps[index])
    }

    private func finish(runCta: Bool) { onFinish(runCta) }
}

/// `_SpotlightPainter`: 82% black with a rounded hole and an accent ring.
private struct Scrim: View {
    let hole: CGRect?

    var body: some View {
        Canvas { context, size in
            var path = Path(CGRect(origin: .zero, size: size))
            if let hole {
                path.addPath(Path(roundedRect: hole, cornerRadius: 16))
            }
            context.fill(path, with: .color(.black.opacity(0.82)), style: FillStyle(eoFill: true))
            if let hole {
                context.stroke(Path(roundedRect: hole, cornerRadius: 16),
                               with: .color(AppColors.accent.opacity(0.55)), lineWidth: 1.5)
            }
        }
    }
}
