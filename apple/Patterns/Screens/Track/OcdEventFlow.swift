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
        Form {
            Section {
                Picker(strings.trackerTypeGroupLabel, selection: $type) {
                    Text(strings.trackerTypeObsession).tag(OcdType.obsession)
                    Text(strings.trackerTypeCompulsion).tag(OcdType.compulsion)
                }
                .adaptiveSegmented()
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            FlowField(text: $content,
                      label: type == .obsession ? strings.trackerThoughtLabel : strings.trackerUrgeLabel,
                      hint: type == .obsession ? strings.trackerThoughtHint : strings.trackerUrgeHint,
                      minLines: 4)
            FlowField(text: $action, label: strings.trackerActionLabel, hint: strings.trackerActionHint, minLines: 3)
            FlowField(text: $response, label: strings.trackerResponseLabel, hint: strings.trackerResponseHint, minLines: 3)
            DistressSection(value: $distress)
        }
        .appListBackground()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(isEditing ? strings.trackerEditTitle : strings.trackerAddTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(saving ? strings.trackerSavingAction : isEditing ? strings.trackerUpdateAction : strings.trackerSaveAction) {
                    save()
                }
                .fontWeight(.semibold)
                .disabled(saving || (isEditing && !loaded))
            }
        }
        .task { load() }
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

/// `_FlowField`: a form section with a growing text field.
private struct FlowField: View {
    @Binding var text: String
    let label: String
    let hint: String
    let minLines: Int

    var body: some View {
        Section(label) {
            TextField(label, text: $text, prompt: Text(hint), axis: .vertical)
                .lineLimit(minLines...(minLines + 4))
                .listRowBackground(AppColors.card)
        }
    }
}

/// `_DistressCard`: a 0 to 10 slider with the value shown in its colour.
private struct DistressSection: View {
    @Binding var value: Double
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let rounded = Int(value.rounded())
        Section {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(strings.trackerDistressLabel)
                    Spacer()
                    Text(strings.trackerDistressShortValue(value: rounded))
                        .font(.title3.weight(.bold).monospacedDigit())
                        .foregroundStyle(distressColor(rounded))
                        .contentTransition(.numericText(value: value))
                }
                .accessibilityHidden(true)
                Slider(value: $value, in: 0...10, step: 1)
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
            .padding(.vertical, 4)
            .listRowBackground(AppColors.card)
        }
    }
}
