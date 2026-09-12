import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../content/ybocs_content.dart';
import '../l10n/app_localizations.dart';
import '../models/export_report_options.dart';
import '../models/models.dart';
import '../widgets/rich_journal.dart';
import 'analytics_service.dart';

class PdfReportService {
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;
  static pw.Font? _japaneseFallbackFont;

  static Future<pw.ThemeData> _theme() async {
    _regularFont ??= pw.Font.ttf(
      await rootBundle.load('assets/fonts/Manrope-Regular.ttf'),
    );
    _boldFont ??= pw.Font.ttf(
      await rootBundle.load('assets/fonts/Manrope-Bold.ttf'),
    );
    _japaneseFallbackFont ??= pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSansJP-Variable.ttf'),
    );

    return pw.ThemeData.withFont(
      base: _regularFont!,
      bold: _boldFont!,
      fontFallback: [_japaneseFallbackFont!],
    );
  }

  static Future<Uint8List> generate({
    required ExportReportOptions options,
    required List<JournalEntry> journals,
    required List<OcdEntry> ocds,
    List<YbocsAssessment> ybocs = const [],
    required Locale locale,
    required AppLocalizations strings,
  }) async {
    await initializeDateFormatting(locale.toLanguageTag());
    final filter = options.filter;
    final filteredJournals = AnalyticsService.filterJournals(journals, filter)
      ..sort((a, b) => a.date.compareTo(b.date));
    final filteredOcds = AnalyticsService.filterOcds(ocds, filter)
      ..sort((a, b) => a.datetime.compareTo(b.datetime));
    final filteredYbocs = AnalyticsService.filterYbocs(ybocs, filter);
    final summary = AnalyticsService.buildSummary(
      journals: filteredJournals,
      ocds: filteredOcds,
      filter: filter,
      range: options.range,
    );

    final bounds = filter.displayBounds(
      customStart: options.customStart,
      customEnd: options.customEnd,
    );
    final localeName = locale.toLanguageTag();
    final dateFmt = DateFormat.yMMMd(localeName);
    final timeFmt = DateFormat.yMMMd(localeName).add_jm();
    final generatedAt = DateFormat.yMMMd(
      localeName,
    ).add_jm().format(DateTime.now());
    final theme = await _theme();

    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(48),
        theme: theme,
        build: (context) {
          final widgets = <pw.Widget>[
            pw.Text(
              'Patterns',
              style: pw.TextStyle(
                fontSize: 11,
                color: PdfColors.grey600,
                letterSpacing: 1.2,
              ),
            ),
            pw.SizedBox(height: 6),
            pw.Text(
              strings.pdfPersonalReport,
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              '${options.localizedRangeLabel(strings, locale)}\n'
              '${dateFmt.format(bounds.$1)} – ${dateFmt.format(bounds.$2)}\n'
              '${strings.pdfGenerated(generatedAt)}',
              style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
            ),
            pw.SizedBox(height: 24),
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 20),
          ];

          if (options.sections.analytics) {
            widgets.addAll(_analyticsSection(summary, strings, localeName));
          }
          // Before the raw entries: a clinician reading this wants the
          // standardised measure first, then the detail behind it.
          if (options.sections.ybocs && filteredYbocs.isNotEmpty) {
            widgets.addAll(_ybocsSection(filteredYbocs, dateFmt, strings));
          }
          if (options.sections.journal) {
            widgets.addAll(_journalSection(filteredJournals, dateFmt, strings));
          }
          if (options.sections.ocd) {
            widgets.addAll(_ocdSection(filteredOcds, timeFmt, strings));
          }

          widgets.addAll([
            pw.SizedBox(height: 32),
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 12),
            pw.Text(
              strings.pdfDisclaimer,
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
            ),
          ]);

          return widgets;
        },
      ),
    );

    return doc.save();
  }

  static List<pw.Widget> _analyticsSection(
    AnalyticsSummary summary,
    AppLocalizations strings,
    String localeName,
  ) {
    final number = NumberFormat.decimalPattern(localeName);
    return [
      _sectionTitle(strings.exportAnalyticsSummary),
      pw.SizedBox(height: 10),
      _statRow(strings.pdfJournalCount, number.format(summary.journalCount)),
      _statRow(strings.pdfOcdCount, number.format(summary.ocdCount)),
      _statRow(
        strings.pdfAverageDistress,
        NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        ).format(summary.averageDistress),
      ),
      _statRow(strings.pdfObsessions, number.format(summary.obsessions)),
      _statRow(strings.pdfCompulsions, number.format(summary.compulsions)),
      pw.SizedBox(height: 24),
    ];
  }

  /// Y-BOCS self-checks as a clinician would want to read them: the latest
  /// total with its severity band, the obsession and compulsion subtotals, the
  /// change across the range, then every dated score.
  ///
  /// Deliberately no chart. fl_chart cannot render into a PDF, and a dated table
  /// is more useful in an appointment than a sparkline anyway.
  static List<pw.Widget> _ybocsSection(
    List<YbocsAssessment> assessments,
    DateFormat dateFmt,
    AppLocalizations strings,
  ) {
    final latest = assessments.last;
    final first = assessments.first;
    final change = latest.totalScore - first.totalScore;
    final changeLabel = assessments.length < 2
        ? strings.pdfSingleSelfCheck
        : strings.pdfChangeSince(
            '${change > 0 ? '+' : ''}$change',
            dateFmt.format(first.datetime),
          );

    final themeLabels = latest.themes
        .map((id) => localizedYbocsCategoryTitleFor(id, strings))
        .whereType<String>()
        .toList();

    return [
      _sectionTitle(strings.exportYbocsSelfChecks),
      pw.SizedBox(height: 4),
      pw.Text(
        strings.pdfYbocsDescription,
        style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
      ),
      pw.SizedBox(height: 10),
      _statRow(
        strings.pdfMostRecentTotal,
        '${latest.totalScore}/40 · ${_severityLabel(latest.severity, strings)} '
        '(${latest.severity.range})',
      ),
      _statRow(strings.pdfTakenOn, dateFmt.format(latest.datetime)),
      _statRow(strings.pdfObsessionsSubtotal, '${latest.obsessionScore}/20'),
      _statRow(strings.pdfCompulsionsSubtotal, '${latest.compulsionScore}/20'),
      _statRow(strings.pdfChangeAcrossRange, changeLabel),
      _statRow(strings.pdfSelfChecksInRange, '${assessments.length}'),
      if (themeLabels.isNotEmpty) ...[
        pw.SizedBox(height: 4),
        _statRow(strings.pdfThemesFlagged, themeLabels.join(', ')),
      ],
      pw.SizedBox(height: 12),
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
        children: [
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey100),
            children: [
              _ybocsCell(strings.pdfDate, bold: true),
              _ybocsCell(strings.pdfTotal, bold: true),
              _ybocsCell(strings.pdfObsessions, bold: true),
              _ybocsCell(strings.pdfCompulsions, bold: true),
              _ybocsCell(strings.pdfBand, bold: true),
            ],
          ),
          for (final a in assessments)
            pw.TableRow(
              children: [
                _ybocsCell(dateFmt.format(a.datetime)),
                _ybocsCell('${a.totalScore}/40'),
                _ybocsCell('${a.obsessionScore}/20'),
                _ybocsCell('${a.compulsionScore}/20'),
                _ybocsCell(_severityLabel(a.severity, strings)),
              ],
            ),
        ],
      ),
      pw.SizedBox(height: 24),
    ];
  }

  static pw.Widget _ybocsCell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  static List<pw.Widget> _journalSection(
    List<JournalEntry> entries,
    DateFormat dateFmt,
    AppLocalizations strings,
  ) {
    final widgets = <pw.Widget>[
      _sectionTitle(strings.exportJournalEntries),
      pw.SizedBox(height: 10),
    ];

    if (entries.isEmpty) {
      widgets.add(
        pw.Text(
          strings.pdfNoJournalEntries,
          style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
        ),
      );
    } else {
      for (final entry in entries) {
        final date = DateTime.parse(entry.date);
        widgets.addAll([
          pw.Text(
            dateFmt.format(date),
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          _markdownText(entry.content, fontSize: 11),
          pw.SizedBox(height: 16),
        ]);
      }
    }

    widgets.add(pw.SizedBox(height: 8));
    return widgets;
  }

  static List<pw.Widget> _ocdSection(
    List<OcdEntry> entries,
    DateFormat timeFmt,
    AppLocalizations strings,
  ) {
    final widgets = <pw.Widget>[
      _sectionTitle(strings.exportOcdEvents),
      pw.SizedBox(height: 10),
    ];

    if (entries.isEmpty) {
      widgets.add(
        pw.Text(
          strings.pdfNoOcdEvents,
          style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
        ),
      );
    } else {
      for (final entry in entries) {
        final typeLabel = entry.type == OcdType.obsession
            ? strings.pdfObsession
            : strings.pdfCompulsion;
        widgets.addAll([
          pw.Text(
            '${timeFmt.format(entry.datetime)} · $typeLabel · '
            '${strings.pdfDistressScore(entry.distressLevel)}',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            entry.type == OcdType.obsession
                ? strings.pdfThought
                : strings.pdfUrge,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.Text(entry.content, style: const pw.TextStyle(fontSize: 11)),
          if (entry.response.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              strings.pdfResponse(entry.response),
              style: const pw.TextStyle(fontSize: 11),
            ),
          ],
          if (entry.actionTaken != null && entry.actionTaken!.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              strings.pdfActionTaken(entry.actionTaken!),
              style: const pw.TextStyle(fontSize: 11),
            ),
          ],
          pw.SizedBox(height: 16),
        ]);
      }
    }

    return widgets;
  }

  /// Renders a journal entry's rich text as styled PDF text. Bold uses the
  /// theme's bold font; italic falls back to regular (no italic font is
  /// bundled) but the text content is always rendered cleanly.
  static pw.Widget _markdownText(String content, {required double fontSize}) {
    final runs = richRunsFromStored(content);
    return pw.RichText(
      text: pw.TextSpan(
        style: pw.TextStyle(fontSize: fontSize),
        children: [
          for (final run in runs)
            pw.TextSpan(
              text: run.text,
              style: pw.TextStyle(
                fontWeight: run.bold
                    ? pw.FontWeight.bold
                    : pw.FontWeight.normal,
                fontStyle: run.italic
                    ? pw.FontStyle.italic
                    : pw.FontStyle.normal,
              ),
            ),
        ],
      ),
    );
  }

  static pw.Widget _sectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
    );
  }

  static String _severityLabel(
    YbocsSeverity severity,
    AppLocalizations strings,
  ) => switch (severity) {
    YbocsSeverity.subclinical => strings.severitySubclinical,
    YbocsSeverity.mild => strings.severityMild,
    YbocsSeverity.moderate => strings.severityModerate,
    YbocsSeverity.severe => strings.severitySevere,
    YbocsSeverity.extreme => strings.severityExtreme,
  };

  static pw.Widget _statRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(label, style: const pw.TextStyle(fontSize: 11)),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              value,
              style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
