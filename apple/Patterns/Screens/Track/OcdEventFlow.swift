import PatternsCore
import SwiftUI

/// `OcdEventFlow`: log a new obsession or compulsion, or edit one.
struct OcdEventFlow: View {
    let entryID: Int64?
    let initialType: OcdType
    /// The first-run path: a save leads to the first-run result screen
    /// instead of the usual completion sheet.
    var firstRun = false

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dynamicTypeSize) private var typeSize

    @State private var existing: OcdEntry?
    @State private var type: OcdType = .obsession
    @State private var content = ""
    @State private var action = ""
    @State private var response = ""
    @State private var distress: Double = 5
    @State private var saving = false
    @State private var loaded = false

    private var isEditing: Bool { entryID != nil }

    var body: some View {
        let strings = model.strings
        VStack(spacing: 0) {
            HStack(spacing: 4) {
                Button { navigation.pop() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(AppColors.textPrimary)
                        .frame(width: 44, height: 44)
                }
                .accessibilityLabel(strings.backAction)
                Text(isEditing ? strings.trackerEditTitle : strings.trackerAddTitle)
                    .textRole(.titleLarge, weight: .heavy, color: AppColors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 16))

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    typeToggle(strings)
                    FlowField(text: $content,
                              label: type == .obsession ? strings.trackerThoughtLabel : strings.trackerUrgeLabel,
                              hint: type == .obsession ? strings.trackerThoughtHint : strings.trackerUrgeHint,
                              minLines: 4)
                        .padding(.top, 22)
                    FlowField(text: $action, label: strings.trackerActionLabel, hint: strings.trackerActionHint, minLines: 3)
                        .padding(.top, 16)
                    FlowField(text: $response, label: strings.trackerResponseLabel, hint: strings.trackerResponseHint, minLines: 3)
                        .padding(.top, 16)
                    DistressCard(value: $distress)
                        .padding(.top, 22)
                    Button(saving ? strings.trackerSavingAction : isEditing ? strings.trackerUpdateAction : strings.trackerSaveAction) {
                        save()
                    }
                    .buttonStyle(PrimaryButtonStyle(fullWidth: true))
                    .disabled(saving || (isEditing && !loaded))
                    .padding(.top, 28)
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 28, trailing: 20))
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .background(AppColors.surface)
        .toolbar(.hidden, for: .navigationBar)
        .task { load() }
    }

    private func typeToggle(_ strings: Strings) -> some View {
        let layout = typeSize >= .xxxLarge ? AnyLayout(VStackLayout(spacing: 0)) : AnyLayout(HStackLayout(spacing: 0))
        return layout {
            TrackerChip(label: strings.trackerTypeObsession, selected: type == .obsession) { type = .obsession }
            TrackerChip(label: strings.trackerTypeCompulsion, selected: type == .compulsion) { type = .compulsion }
        }
        .padding(5)
        .softSurface(radius: 24)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(strings.trackerTypeGroupLabel)
    }

    private func load() {
        guard !loaded else { return }
        defer { loaded = true }
        type = initialType
        guard let entryID, let entry = try? model.database.queue.read({ try OcdEntry.fetchOne($0, key: entryID) }) else { return }
        existing = entry
        type = entry.type ?? initialType
        content = entry.content
        action = entry.actionTaken ?? ""
        response = entry.response
        distress = Double(entry.distressLevel)
    }

    private func save() {
        let strings = model.strings
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedContent.isEmpty else {
            navigation.showToast(strings.trackerContentRequired, kind: .info)
            return
        }
        saving = true
        let now = DartTimestamp.now()
        let trimmedAction = action.trimmingCharacters(in: .whitespacesAndNewlines)
        let entry = OcdEntry(
            id: existing?.id,
            type: type,
            datetime: existing?.datetime ?? now,
            content: trimmedContent,
            distressLevel: Int(distress.rounded()),
            response: response.trimmingCharacters(in: .whitespacesAndNewlines),
            actionTaken: trimmedAction.isEmpty ? nil : trimmedAction,
            createdAt: existing?.createdAt ?? now
        )
        do {
            if isEditing {
                try model.database.updateOcdEntry(entry)
            } else {
                _ = try model.database.insertOcdEntry(entry)
            }
        } catch {
            saving = false
            navigation.showToast(isEditing ? strings.trackerUpdateError : strings.trackerSaveError, kind: .error)
            return
        }
        model.prefs.recordReviewOcdSaved()
        saving = false
        if firstRun {
            navigation.finishFirstRun(.journal)
        } else {
            navigation.completeActivity(.trackedMoment(updated: isEditing))
        }
    }
}

/// `_FlowField`: a label above a filled, growing text field.
private struct FlowField: View {
    @Binding var text: String
    let label: String
    let hint: String
    let minLines: Int
    @FocusState private var focused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            Text(label)
                .textRole(.titleSmall, weight: .heavy, color: AppColors.textPrimary)
                .accessibilityHidden(true)
            TextField("", text: $text, prompt: Text(hint).foregroundStyle(AppColors.textSecondary.opacity(0.7)), axis: .vertical)
                .lineLimit(minLines...(minLines + 2))
                .textRole(.bodyLarge, color: AppColors.textPrimary)
                .focused($focused)
                .padding(16)
                .background(AppColors.input, in: .rect(cornerRadius: 18))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(focused ? AppColors.accent : AppColors.border, lineWidth: focused ? 1.5 : 1)
                )
                .contentShape(.rect)
                .onTapGesture { focused = true }
                .accessibilityLabel(label)
        }
    }
}

/// `_DistressCard`: a 0 to 10 slider with the value shown in its colour.
private struct DistressCard: View {
    @Binding var value: Double
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let rounded = Int(value.rounded())
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text(strings.trackerDistressLabel)
                    .textRole(.titleSmall, weight: .heavy, color: AppColors.textPrimary)
                Text(strings.trackerDistressShortValue(value: rounded))
                    .font(.custom(AppFont.sans, size: 22, relativeTo: .title2).weight(.black))
                    .foregroundStyle(distressColor(rounded))
                    .contentTransition(.numericText(value: value))
            }
            .accessibilityHidden(true)
            Slider(value: $value, in: 0...10, step: 1)
                .tint(AppColors.accent)
                .accessibilityLabel(strings.trackerDistressLabel)
                .accessibilityValue(strings.trackerDistressValue(value: rounded))
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment: if rounded < 10 { value = Double(rounded + 1) }
                    case .decrement: if rounded > 0 { value = Double(rounded - 1) }
                    @unknown default: break
                    }
                }
        }
        .padding(18)
        .softSurface(radius: 22)
    }
}
