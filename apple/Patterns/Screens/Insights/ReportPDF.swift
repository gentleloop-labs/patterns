import PatternsCore
import UIKit

/// `PdfReportService` from `lib/services/pdf_report_service.dart`. The
/// report is laid out as HTML and printed with UIKit's print renderer, which
/// paginates long entries and uses the system fonts (Japanese included).
/// US Letter with 48-point margins, as in Flutter.
@MainActor
enum ReportPDF {
    struct Sections: Equatable {
        var analytics = true
        var ybocs = true
        var journal = true
        var ocd = true
        var hasAny: Bool { analytics || ybocs || journal || ocd }
    }

    static func render(data: ReportData, sections: Sections, rangeLabel: String, filter: ReportFilter,
                       strings: Strings) -> Data {
        let html = document(data: data, sections: sections, rangeLabel: rangeLabel, filter: filter, strings: strings)
        let formatter = UIMarkupTextPrintFormatter(markupText: html)
        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(formatter, startingAtPageAt: 0)
        let paper = CGRect(x: 0, y: 0, width: 612, height: 792)
        renderer.setValue(paper, forKey: "paperRect")
        renderer.setValue(paper.insetBy(dx: 48, dy: 48), forKey: "printableRect")

        let output = NSMutableData()
        UIGraphicsBeginPDFContextToData(output, paper, [kCGPDFContextCreator as String: "Patterns"])
        renderer.prepare(forDrawingPages: NSRange(location: 0, length: renderer.numberOfPages))
        for page in 0..<renderer.numberOfPages {
            UIGraphicsBeginPDFPage()
            renderer.drawPage(at: page, in: UIGraphicsGetPDFContextBounds())
        }
        UIGraphicsEndPDFContext()
        return output as Data
    }

    // MARK: Document

    private static func document(data: ReportData, sections: Sections, rangeLabel: String, filter: ReportFilter,
                                 strings s: Strings) -> String {
        let dates = s.dates
        let bounds = filter.displayBounds()
        let shortDate = { (date: Date) in dateText(date, s.locale, time: false) }
        var body = """
        <p class="brand">Patterns</p>
        <h1>\(esc(s.pdfPersonalReport))</h1>
        <p class="meta">\(esc(rangeLabel))<br>\(esc(shortDate(bounds.start))) – \(esc(shortDate(bounds.end)))<br>\
        \(esc(s.pdfGenerated(date: dateText(Date(), s.locale, time: true))))</p>
        <hr>
        """
        if sections.analytics {
            body += "<h2>\(esc(s.exportAnalyticsSummary))</h2><table class=\"stats\">"
            body += stat(s.pdfJournalCount, dates.integer(data.journals.count))
            body += stat(s.pdfOcdCount, dates.integer(data.ocds.count))
            body += stat(s.pdfAverageDistress, dates.oneDecimal(data.averageDistress))
            body += stat(s.pdfObsessions, dates.integer(data.obsessions))
            body += stat(s.pdfCompulsions, dates.integer(data.compulsions))
            body += "</table>"
        }
        // The standardised measure before the raw entries, as a clinician
        // would read it.
        if sections.ybocs, let latest = data.ybocs.last, let first = data.ybocs.first {
            let severity = latest.severity ?? .forScore(latest.totalScore)
            let change = latest.totalScore - first.totalScore
            let changeLabel = data.ybocs.count < 2 ? s.pdfSingleSelfCheck
                : s.pdfChangeSince(change: "\(change > 0 ? "+" : "")\(change)",
                                   date: first.datetime.date.map(shortDate) ?? "")
            let themes = latest.themes.filter { id in YbocsContent.categories.contains { $0.id == id } }
                .map { s.ybocsCategoryTitle(category: $0) }
            body += "<h2>\(esc(s.exportYbocsSelfChecks))</h2><p class=\"note\">\(esc(s.pdfYbocsDescription))</p><table class=\"stats\">"
            body += stat(s.pdfMostRecentTotal, "\(latest.totalScore)/40 · \(pdfSeverity(severity, s)) (\(severity.rangeText))")
            body += stat(s.pdfTakenOn, latest.datetime.date.map(shortDate) ?? "")
            body += stat(s.pdfObsessionsSubtotal, "\(latest.obsessionScore)/20")
            body += stat(s.pdfCompulsionsSubtotal, "\(latest.compulsionScore)/20")
            body += stat(s.pdfChangeAcrossRange, changeLabel)
            body += stat(s.pdfSelfChecksInRange, "\(data.ybocs.count)")
            if !themes.isEmpty { body += stat(s.pdfThemesFlagged, themes.joined(separator: ", ")) }
            body += "</table><table class=\"grid\"><tr>"
            body += [s.pdfDate, s.pdfTotal, s.pdfObsessions, s.pdfCompulsions, s.pdfBand].map { "<th>\(esc($0))</th>" }.joined()
            body += "</tr>"
            for assessment in data.ybocs {
                let band = pdfSeverity(assessment.severity ?? .forScore(assessment.totalScore), s)
                body += "<tr><td>\(esc(assessment.datetime.date.map(shortDate) ?? ""))</td><td>\(assessment.totalScore)/40</td>"
                    + "<td>\(assessment.obsessionScore)/20</td><td>\(assessment.compulsionScore)/20</td><td>\(esc(band))</td></tr>"
            }
            body += "</table>"
        }
        if sections.journal {
            body += "<h2>\(esc(s.exportJournalEntries))</h2>"
            if data.journals.isEmpty {
                body += "<p class=\"empty\">\(esc(s.pdfNoJournalEntries))</p>"
            }
            for entry in data.journals {
                let day = DartDateTime.parse(entry.date).map(shortDate) ?? entry.date
                body += "<h3>\(esc(day))</h3><p class=\"entry\">\(richText(entry.body))</p>"
            }
        }
        if sections.ocd {
            body += "<h2>\(esc(s.exportOcdEvents))</h2>"
            if data.ocds.isEmpty {
                body += "<p class=\"empty\">\(esc(s.pdfNoOcdEvents))</p>"
            }
            for entry in data.ocds {
                let obsession = entry.type == .obsession
                let when = entry.datetime.date.map { dateText($0, s.locale, time: true) } ?? ""
                body += "<h3>\(esc(when)) · \(esc(obsession ? s.pdfObsession : s.pdfCompulsion)) · \(esc(s.pdfDistressScore(score: entry.distressLevel)))</h3>"
                body += "<p class=\"label\">\(esc(obsession ? s.pdfThought : s.pdfUrge))</p><p>\(esc(entry.content))</p>"
                if !entry.response.isEmpty { body += "<p>\(esc(s.pdfResponse(text: entry.response)))</p>" }
                if let action = entry.actionTaken, !action.isEmpty { body += "<p>\(esc(s.pdfActionTaken(text: action)))</p>" }
            }
        }
        body += "<hr><p class=\"disclaimer\">\(esc(s.pdfDisclaimer))</p>"
        return """
        <!doctype html><html><head><meta charset="utf-8"><style>
        body { font-family: -apple-system, sans-serif; font-size: 11pt; color: #1c1c1e; }
        .brand { font-size: 11pt; color: #757575; letter-spacing: 1.2pt; margin: 0 0 6pt; }
        h1 { font-size: 22pt; margin: 0 0 8pt; }
        .meta { font-size: 11pt; color: #616161; margin: 0 0 20pt; line-height: 1.4; }
        hr { border: none; border-top: 0.5pt solid #e0e0e0; margin: 16pt 0; }
        h2 { font-size: 14pt; margin: 22pt 0 10pt; }
        h3 { font-size: 11pt; margin: 14pt 0 4pt; page-break-after: avoid; }
        p { margin: 2pt 0; line-height: 1.4; }
        .note, .label { font-size: 10pt; color: #616161; }
        .empty { color: #757575; }
        .entry { white-space: pre-wrap; }
        table.stats { width: 100%; border-collapse: collapse; margin-bottom: 8pt; }
        table.stats td { padding: 0 0 6pt; vertical-align: top; }
        table.stats td.k { width: 40%; }
        table.stats td.v { font-weight: bold; }
        table.grid { width: 100%; border-collapse: collapse; font-size: 10pt; margin-top: 10pt; }
        table.grid th, table.grid td { border: 0.5pt solid #e0e0e0; padding: 4pt 6pt; text-align: left; }
        table.grid th { background: #f5f5f5; }
        .disclaimer { font-size: 9pt; color: #757575; }
        </style></head><body>\(body)</body></html>
        """
    }

    private static func stat(_ label: String, _ value: String) -> String {
        "<tr><td class=\"k\">\(esc(label))</td><td class=\"v\">\(esc(value))</td></tr>"
    }

    /// `_severityLabel` (the report's own severity copy).
    private static func pdfSeverity(_ severity: YbocsSeverity, _ s: Strings) -> String {
        switch severity {
        case .subclinical: s.severitySubclinical
        case .mild: s.severityMild
        case .moderate: s.severityModerate
        case .severe: s.severitySevere
        case .extreme: s.severityExtreme
        }
    }

    /// `_markdownText`: bold and italic kept, everything else as text.
    private static func richText(_ content: JournalContent) -> String {
        content.richRuns.map { run in
            var text = esc(run.text)
            if run.bold { text = "<b>\(text)</b>" }
            if run.italic { text = "<i>\(text)</i>" }
            return text
        }.joined()
    }

    /// `DateFormat.yMMMd`, with `add_jm` for times.
    private static func dateText(_ date: Date, _ locale: Locale, time: Bool) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate(time ? "yMMMdjm" : "yMMMd")
        return formatter.string(from: date)
    }

    private static func esc(_ text: String) -> String {
        text.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
    }
}
