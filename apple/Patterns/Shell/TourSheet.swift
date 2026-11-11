import SwiftUI

/// One step of the tab tour: the tab it describes (nil for the closing
/// card), its copy, and an optional call to action.
struct TourStep {
    let tab: AppTab?
    let title: String
    let points: [String]
    var cta: String?
}

/// The tab tour as a native sheet: one page per tab, swiped or stepped
/// through, switching the tab behind it so the screen shows what the page
/// describes. Replaces Flutter's spotlight overlay.
struct TourSheet: View {
    let steps: [TourStep]
    /// Called when a page appears, to switch to its tab.
    let onShow: (TourStep) -> Void
    /// Called when the tour ends; `runCta` is true when the closing call to
    /// action was chosen.
    let onFinish: (_ runCta: Bool) -> Void

    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var index = 0
    @State private var finished = false

    var body: some View {
        let strings = model.strings
        let isLast = index == steps.count - 1
        NavigationStack {
            TabView(selection: $index) {
                ForEach(steps.indices, id: \.self) { i in
                    page(steps[i]).tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12) {
                    if let cta = steps[index].cta {
                        Button { finish(runCta: true) } label: {
                            Text(cta).frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.accentProminent)
                        .controlSize(.large)
                    } else {
                        Button {
                            withAnimation { index += 1 }
                        } label: {
                            Text(strings.shellText(key: "next")).frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.accentProminent)
                        .controlSize(.large)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
            }
            .navigationTitle(strings.tourProgress(current: index + 1, total: steps.count))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(isLast && steps[index].cta == nil ? strings.doneAction : strings.shellText(key: "skip")) {
                        finish(runCta: false)
                    }
                }
            }
        }
        .presentationDetents([.height(330), .medium])
        .presentationBackgroundInteraction(.disabled)
        .interactiveDismissDisabled(false)
        .onAppear { onShow(steps[0]) }
        .onChange(of: index) { _, value in onShow(steps[value]) }
        .onDisappear { if !finished { onFinish(false) } }
    }

    private func page(_ step: TourStep) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Label {
                    Text(step.title)
                } icon: {
                    Image(systemName: step.tab?.systemImage ?? "checkmark.seal")
                        .foregroundStyle(AppColors.accent)
                }
                .font(.title2.weight(.bold))
                .accessibilityAddTraits(.isHeader)
                ForEach(step.points, id: \.self) { point in
                    Text(point)
                        .font(.body)
                        .foregroundStyle(AppColors.textSecondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
    }

    private func finish(runCta: Bool) {
        finished = true
        onFinish(runCta)
        dismiss()
    }
}
