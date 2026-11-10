import PatternsCore
import SwiftUI
import UniformTypeIdentifiers

/// `ExportReportSheet` from `lib/widgets/export_report_sheet.dart`: pick a
/// range and sections, see how many entries that covers, then save a PDF
/// through the system save sheet.
struct ExportReportSheet: View {
    var initialRange: ReportRange = .thirty

    @Environment(AppModel.self) private var model
    @Environment(AppNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss
    @State private var snapshot: Loadable<ActivitySnapshot> = .loading
    @State private var range: ReportRange = .thirty
    @State private var customStart = Calendar.current.date(byAdding: .day, value: -29, to: Date()) ?? Date()
    @State private var customEnd = Date()
    @State private var sections = ReportPDF.Sections()
    @State private var document: PDFDocumentFile?
    @State private var saving = false
    @State private var generating = false

    var body: some View {
        let strings = model.strings
        let filter = ReportFilter(range: range, customStart: customStart, customEnd: customEnd)
        let data = snapshot.value.map { ReportData(snapshot: $0, filter: filter) }
        let journalCount = data?.journals.count ?? 0
        let ocdCount = data?.ocds.count ?? 0
        let selfChecks = data?.ybocs.count ?? 0
        let total = journalCount + ocdCount
        // `hasExportableContent`: a summary needs entries to summarise, and
        // self-checks alone are enough for a report.
        let hasContent = (sections.analytics && total > 0) || (sections.journal && journalCount > 0)
            || (sections.ocd && ocdCount > 0) || (sections.ybocs && selfChecks > 0)
        NavigationStack {
            Form {
                Section {
                } header: {
                    Text(strings.exportReportDescription)
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                        .textCase(nil)
                        .padding(.leading, -4)
                }
                Section {
                    Picker(strings.exportTimeWindow, selection: $range) {
                        Text(strings.rangeSevenDays).tag(ReportRange.seven)
                        Text(strings.rangeThirtyDays).tag(ReportRange.thirty)
                        Text(strings.rangeNinetyDays).tag(ReportRange.ninety)
                        Text(strings.rangeYear).tag(ReportRange.year)
                        Text(strings.rangeAll).tag(ReportRange.allTime)
                        Text(strings.rangeCustom).tag(ReportRange.custom)
                    }
                    .pickerStyle(.menu)
                    if range == .custom {
                        DatePicker(strings.exportStart, selection: $customStart, in: ...customEnd, displayedComponents: .date)
                        DatePicker(strings.exportEnd, selection: $customEnd, in: customStart...Date(), displayedComponents: .date)
                    }
                }
                .environment(\.locale, strings.locale)
                .listRowBackground(AppColors.card)
                Section {
                    Toggle(strings.exportAnalyticsSummary, isOn: $sections.analytics)
                    Toggle(strings.exportJournalEntries, isOn: $sections.journal)
                    Toggle(strings.exportOcdEvents, isOn: $sections.ocd)
                    Toggle(strings.exportYbocsSelfChecks, isOn: $sections.ybocs)
                } header: {
                    Text(strings.exportIncludeSections)
                } footer: {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(strings.exportEntrySummary(total: total + selfChecks, journal: journalCount, ocd: ocdCount,
                                                        selfChecks: selfChecks))
                        if total > 500 {
                            Text(strings.exportLargeReport).foregroundStyle(AppColors.accent)
                        }
                        Text(strings.exportPrivacyWarning)
                    }
                    .padding(.top, 4)
                }
                .listRowBackground(AppColors.card)
                if !sections.hasAny || !hasContent {
                    Text(sections.hasAny ? strings.exportNoEntriesError : strings.exportSelectSectionError)
                        .font(.subheadline)
                        .foregroundStyle(AppColors.negative)
                        .listRowBackground(Color.clear)
                }
            }
            .appListBackground()
            .navigationTitle(strings.exportReportTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(strings.cancelAction) { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    guard let data else { return }
                    generate(data, filter: filter)
                } label: {
                    Group {
                        if generating { ProgressView().tint(AppColors.onAccent) } else { Text(strings.exportSavePdf) }
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.accentProminent)
                .controlSize(.large)
                .disabled(data == nil || !sections.hasAny || !hasContent || generating)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(AppColors.surface)
            }
        }
        .overlay(alignment: .top) { ToastHost() }
        .onAppear { range = initialRange }
        .liveQuery(model.database, into: $snapshot) { db in try ActivitySnapshot.fetch(db) }
        .fileExporter(isPresented: $saving, document: document, contentType: .pdf,
                      defaultFilename: filter.suggestedFileName()) { result in
            document = nil
            switch result {
            case .success:
                dismiss()
                navigation.showToast(strings.exportReportSaved, kind: .success)
            case let .failure(error):
                if (error as? CocoaError)?.code != .userCancelled {
                    navigation.showToast(strings.exportReportFailed, kind: .error)
                }
            }
        }
    }

    private func label(_ s: Strings) -> String {
        switch range {
        case .seven: s.rangeLastSevenDays
        case .thirty: s.rangeLastThirtyDays
        case .ninety: s.rangeLastNinetyDays
        case .year: s.rangeLastYear
        case .allTime: s.rangeAllTime
        case .custom:
            "\(Self.medium(customStart, s.locale)) – \(Self.medium(customEnd, s.locale))"
        }
    }

    private static func medium(_ date: Date, _ locale: Locale) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate("yMMMd")
        return formatter.string(from: date)
    }

    private func generate(_ data: ReportData, filter: ReportFilter) {
        generating = true
        let pdf = ReportPDF.render(data: data, sections: sections, rangeLabel: label(model.strings),
                                   filter: filter, strings: model.strings)
        generating = false
        guard !pdf.isEmpty else {
            return navigation.showToast(model.strings.exportReportFailed, kind: .error)
        }
        document = PDFDocumentFile(data: pdf)
        saving = true
    }
}

/// The report, handed to the system save sheet.
struct PDFDocumentFile: FileDocument {
    static let readableContentTypes: [UTType] = [.pdf]
    let data: Data

    init(data: Data) { self.data = data }

    init(configuration: ReadConfiguration) throws {
        data = configuration.file.regularFileContents ?? Data()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}
