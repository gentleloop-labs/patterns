import PatternsCore
import SwiftUI

/// Localized copy for a program or track.
extension ErpProgram {
    func title(_ s: Strings) -> String {
        trackID == nil ? s.structuredProgramTitle(program: copyKey) : s.ocdTrackTitle(track: copyKey)
    }

    func subtitle(_ s: Strings) -> String {
        trackID == nil ? s.structuredProgramSubtitle(program: copyKey) : s.ocdTrackBlurb(track: copyKey)
    }

    func weekTitle(_ week: ProgramWeek, _ s: Strings) -> String {
        trackID == nil ? s.structuredProgramWeek(week: week.id) : s.ocdTrackWeek(week: week.id)
    }

    func taskLabel(_ task: String, _ s: Strings) -> String {
        trackID == nil ? s.structuredProgramTask(task: task) : s.ocdTrackTask(task: task)
    }

    /// Only tracks with no self-check category carry a note.
    func checklistNote(_ s: Strings) -> String? {
        trackID != nil && ybocsCategoryIDs.isEmpty ? s.ocdTrackChecklistNote(track: copyKey) : nil
    }
}

/// `StructuredProgramsScreen` from `lib/mobile/screens/structured_programs_screen.dart`:
/// theme tracks and general programs, week by week. Pro.
struct StructuredProgramsScreen: View {
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var enrollments: Loadable<[ProgramEnrollment]> = .loading
    @State private var progress: Loadable<[ProgramTaskProgress]> = .loading
    @State private var assessments: Loadable<[YbocsAssessment]> = .loading

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.structuredProgramText(key: key) }
        // The newest self-check only marks likely-relevant tracks; nothing
        // is hidden or reordered by it.
        let themes = (assessments.value ?? []).max { ($0.datetime.date() ?? .distantPast) < ($1.datetime.date() ?? .distantPast) }?.themes ?? []
        List {
            Section {
            } header: {
                Text(text("subtitle"))
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .padding(.leading, -4)
            }
            SectionIntroSection(id: "structuredPrograms")
            Section {
                ForEach(ProgramContent.tracks) { program in
                    row(program, suggested: program.matches(themes: themes))
                }
            } header: {
                groupHeader(text("themeGroup"), themes.isEmpty ? text("themeGroupEmpty") : text("themeGroupMatched"))
            }
            .listRowBackground(AppColors.card)
            Section {
                ForEach(ProgramContent.general) { row($0, suggested: false) }
            } header: {
                groupHeader(text("generalGroup"), text("generalCaption"))
            }
            .listRowBackground(AppColors.card)
        }
        .listStyle(.insetGrouped)
        .appListBackground()
        .navigationTitle(text("title"))
        .liveQuery(model.database, into: $enrollments) { db in try ProgramEnrollment.all().fetchAll(db) }
        .liveQuery(model.database, into: $progress) { db in try ProgramTaskProgress.fetchAll(db) }
        .liveQuery(model.database, into: $assessments) { db in try YbocsAssessment.all().fetchAll(db) }
    }

    private func groupHeader(_ title: String, _ caption: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title).font(.headline).foregroundStyle(Color(.label))
            Text(caption).font(.footnote).foregroundStyle(Color(.secondaryLabel))
        }
        .textCase(nil)
        .padding(.leading, -4)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
    }

    private func row(_ program: ErpProgram, suggested: Bool) -> some View {
        let strings = model.strings
        let enrollmentID = (enrollments.value ?? []).first { $0.programId == program.id }?.id
        let done = enrollmentID.map { id in (progress.value ?? []).filter { $0.enrollmentId == id }.count } ?? 0
        return ProgramRow(program: program, started: enrollmentID != nil, done: done, suggested: suggested) {
            open(program)
        }
    }

    /// `_open`: enrolling on first open, as Flutter does.
    private func open(_ program: ErpProgram) {
        do {
            let id = try model.database.enroll(programID: program.id)
            navigation.push(.programDetail(programID: program.id, enrollmentID: id))
        } catch {
            navigation.showToast(model.strings.structuredProgramText(key: "enrollError"), kind: .error)
        }
    }
}

private struct ProgramRow: View {
    let program: ErpProgram
    let started: Bool
    let done: Int
    let suggested: Bool
    let onOpen: () -> Void
    @Environment(AppModel.self) private var model

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.structuredProgramText(key: key) }
        let calm = model.calmInsightsEnabled
        let total = program.totalTasks
        let fraction = total == 0 ? 0 : Double(done) / Double(total)
        let percent = Int((fraction * 100).rounded())
        let title = program.title(strings)
        Button(action: onOpen) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(title).font(.headline).foregroundStyle(Color(.label))
                        Spacer()
                        if suggested && !started {
                            Text(text("selfCheckMatch"))
                                .font(.caption2.weight(.bold))
                                .foregroundStyle(AppColors.accent)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(AppColors.accent.opacity(0.14), in: .capsule)
                        }
                        if started && !calm {
                            Text(strings.dates.wholePercent(percent))
                                .font(.subheadline.weight(.bold).monospacedDigit())
                                .foregroundStyle(AppColors.accent)
                        }
                    }
                    Text(strings.structuredProgramSummary(count: program.weeks.count, subtitle: program.subtitle(strings)))
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                        .multilineTextAlignment(.leading)
                    if started && !calm {
                        ProgressView(value: fraction).padding(.top, 4)
                    } else if !started {
                        Text(text("tapToStart"))
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(AppColors.accent)
                            .padding(.top, 2)
                    }
                }
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
            }
            .padding(.vertical, 6)
            .contentShape(.rect)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityValue(started
            ? (calm ? text("started") : strings.structuredProgramProgress(done: done, total: total, percent: percent))
            : text("notStarted"))
        .accessibilityHint(text("openHint"))
        .accessibilityAddTraits(.isButton)
    }
}

/// `ProgramDetailScreen`: overall progress, then each week with its tasks.
/// The first unfinished week starts open.
struct ProgramDetailScreen: View {
    let programID: String
    let enrollmentID: Int64
    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @State private var progress: Loadable<[ProgramTaskProgress]> = .loading
    @State private var expanded: Int?

    var body: some View {
        let strings = model.strings
        let text = { (key: String) in strings.structuredProgramText(key: key) }
        if let program = ProgramContent.program(id: programID) {
            let rows = (progress.value ?? []).filter { $0.enrollmentId == enrollmentID }
            let isDone = { (week: Int, task: String) in rows.contains { $0.weekIndex == week && $0.taskId == task } }
            let total = program.totalTasks
            let done = rows.count
            let calm = model.calmInsightsEnabled
            let current = program.weeks.indices.first { index in
                !program.weeks[index].tasks.allSatisfy { isDone(index, $0) }
            } ?? program.weeks.count - 1
            List {
                // Track names are long, so the full name heads the list and
                // the bar keeps a small title.
                Section {
                } header: {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(program.title(strings))
                            .font(.title.weight(.bold))
                            .foregroundStyle(Color(.label))
                            .accessibilityAddTraits(.isHeader)
                        if let note = program.checklistNote(strings) {
                            Text(note).font(.footnote).foregroundStyle(Color(.secondaryLabel))
                        }
                    }
                    .textCase(nil)
                    .padding(.leading, -4)
                }
                if case .failed = progress {
                    Text(text("progressLoadError")).foregroundStyle(.secondary).listRowBackground(AppColors.card)
                }
                Section {
                    HStack {
                        Text(calm ? text("activityRecorded")
                             : done == total ? strings.structuredProgramComplete(count: total)
                             : strings.structuredProgramTaskProgress(done: done, total: total))
                            .font(.headline)
                        Spacer()
                        if !calm {
                            Text(strings.dates.wholePercent(total == 0 ? 0 : Int((Double(done) / Double(total) * 100).rounded())))
                                .font(.headline.monospacedDigit())
                                .foregroundStyle(AppColors.accent)
                        }
                    }
                }
                .listRowBackground(AppColors.card)
                ForEach(Array(program.weeks.enumerated()), id: \.element.id) { index, week in
                    let weekDone = week.tasks.filter { isDone(index, $0) }.count
                    Section {
                        DisclosureGroup(isExpanded: Binding(
                            get: { (expanded ?? current) == index },
                            set: { expanded = $0 ? index : -1 }
                        )) {
                            ForEach(week.tasks, id: \.self) { task in
                                let checked = isDone(index, task)
                                Button { toggle(index, task, !checked) } label: {
                                    HStack(alignment: .firstTextBaseline, spacing: 12) {
                                        Image(systemName: checked ? "checkmark.square.fill" : "square")
                                            .foregroundStyle(checked ? AppColors.accent : Color(.tertiaryLabel))
                                        Text(program.taskLabel(task, strings))
                                            .strikethrough(checked, color: Color(.secondaryLabel))
                                            .foregroundStyle(checked ? Color(.secondaryLabel) : Color(.label))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .contentShape(.rect)
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel(program.taskLabel(task, strings))
                                .accessibilityHint(text("taskToggleHint"))
                                .accessibilityAddTraits(checked ? [.isButton, .isSelected] : .isButton)
                            }
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: weekDone == week.tasks.count ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(weekDone == week.tasks.count ? AppColors.accent : Color(.tertiaryLabel))
                                Text(program.weekTitle(week, strings)).font(.headline).foregroundStyle(Color(.label))
                                Spacer()
                                if !calm {
                                    Text(strings.structuredProgramCompactProgress(done: weekDone, total: week.tasks.count))
                                        .font(.subheadline.monospacedDigit())
                                        .foregroundStyle(Color(.secondaryLabel))
                                }
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(program.weekTitle(week, strings))
                            .accessibilityValue(text(weekDone == week.tasks.count ? "weekComplete" : "weekNotComplete"))
                            .accessibilityHint(text("weekToggleHint"))
                        }
                    }
                    .listRowBackground(AppColors.card)
                }
            }
            .listStyle(.insetGrouped)
            .appListBackground()
            .navigationTitle(program.title(strings))
            .navigationBarTitleDisplayMode(.inline)
            .liveQuery(model.database, into: $progress) { db in try ProgramTaskProgress.fetchAll(db) }
        }
    }

    private func toggle(_ week: Int, _ task: String, _ completed: Bool) {
        let strings = model.strings
        do {
            try model.database.setProgramTask(enrollmentID: enrollmentID, weekIndex: week, taskID: task, completed: completed)
            UIAccessibility.post(notification: .announcement,
                                 argument: strings.structuredProgramTaskChanged(status: completed ? "completed" : "notCompleted"))
        } catch {
            navigation.showToast(strings.structuredProgramText(key: "taskSaveError"), kind: .error)
        }
    }
}
