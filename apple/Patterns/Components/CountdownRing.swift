import SwiftUI

/// The practice timer face, in the style of the Clock app's timer: a thin
/// ring that fills toward the end time, with the remaining time inside.
struct CountdownRing: View {
    let startedAt: Date
    let endsAt: Date
    /// A quiet line under the time.
    var caption: String?
    @Environment(AppModel.self) private var model

    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.25)) { context in
            let total = endsAt.timeIntervalSince(startedAt)
            let remaining = max(0, endsAt.timeIntervalSince(context.date))
            let progress = total > 0 ? 1 - remaining / total : 1
            let display = Self.format(remaining)
            ZStack {
                Circle().stroke(Color(.systemFill), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(AppColors.accent, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.25), value: progress)
                VStack(spacing: 6) {
                    Text(display)
                        .font(.system(size: 60, weight: .light, design: .rounded).monospacedDigit())
                        .contentTransition(.numericText(countsDown: true))
                        // Explicit, so a list header's grey never applies.
                        .foregroundStyle(Color(.label))
                    if let caption {
                        Text(caption)
                            .font(.subheadline)
                            .foregroundStyle(AppColors.textSecondary)
                    }
                }
            }
            .frame(width: 260, height: 260)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(model.strings.timerRemaining(time: display))
        }
    }

    /// `mm:ss`, rounding up so the face never shows 00:00 early.
    static func format(_ seconds: TimeInterval) -> String {
        let whole = Int(seconds.rounded(.up))
        return String(format: "%02d:%02d", whole / 60, whole % 60)
    }
}
