import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final arb =
      jsonDecode(File('lib/l10n/app_es.arb').readAsStringSync())
          as Map<String, dynamic>;
  final productCopy = arb.entries
      .where(
        (entry) =>
            !entry.key.startsWith('@') &&
            !entry.key.startsWith('desktop') &&
            entry.value is String,
      )
      .map((entry) => entry.value as String)
      .join('\n');

  test('Spanish uses the reviewed clinical glossary and neutral tú voice', () {
    expect(productCopy, contains('trastorno obsesivo-compulsivo (TOC)'));
    expect(productCopy, contains('obsesiones'));
    expect(productCopy, contains('compulsiones'));
    expect(
      productCopy,
      contains('exposición con prevención de respuesta (EPR)'),
    );
    expect(productCopy, contains('Y-BOCS'));
    expect(productCopy, isNot(contains(RegExp(r'\bOCD\b'))));
    expect(productCopy, isNot(contains(RegExp(r'\bERP\b'))));
    expect(
      productCopy,
      isNot(contains(RegExp(r'\busted\b', caseSensitive: false))),
    );
    expect(productCopy, isNot(contains('recuperación')));
    expect(productCopy, isNot(contains('urgencia')));
    expect(productCopy, isNot(contains('buscar tranquilidad')));
  });

  test('Spanish keeps quiet completion and safety boundaries', () {
    expect(arb['doneForNowAction'], 'Terminar por ahora');
    expect(arb['privacyClinicalBoundary'], contains('No diagnostica ni trata'));
    expect(arb['privacyClinicalBoundary'], contains('no sustituye'));
    expect(
      arb['privacyClinicalBoundary'],
      contains('asistencia de emergencia'),
    );
    expect(
      arb['emergencyToolkitText'],
      contains('servicios de emergencia locales'),
    );
    expect(arb['tipJarBody'], contains('opcionales'));
    expect(arb['tipJarBody'], contains('no desbloquean'));
    expect(arb['privacyAnalytics'], contains('idioma elegido'));
  });

  test('Spanish keeps release, PDF, and privacy copy factual', () {
    expect(arb['updateAnnouncementTitle'], isNot(contains('ha mejorado')));
    expect(arb['updateAnnouncementTitle'], contains('nuevas herramientas'));
    expect(arb['updateAnnouncementBody'], contains('actividad registrada'));
    expect(arb['pdfYbocsDescription'], contains('máximo de 40 puntos'));
    expect(arb['pdfYbocsDescription'], contains('hasta 20'));
    expect(arb['analyticsPromptTitle'], startsWith('¿Quieres'));
    expect(arb['analyticsPromptBody'], contains('niveles de malestar'));
    expect(arb['analyticsPromptBody'], contains('configuración regional'));
    expect(arb['privacyAnalytics'], contains('versión de la aplicación'));
    expect(arb['privacyAnalytics'], contains('hora del evento'));
  });

  test('Spanish keeps Y-BOCS and immediate-support boundaries explicit', () {
    expect(arb['ybocsSeverityBlurb'], contains('severe{'));
    expect(arb['ybocsSeverityBlurb'], contains('extreme{'));
    expect(
      RegExp(r'(severe|extreme)\{[^}]*no un diagnóstico').allMatches(
        arb['ybocsSeverityBlurb'] as String,
      ),
      hasLength(2),
    );
    expect(arb['emergencyToolkitText'], contains('peligro inmediato'));
    expect(arb['ybocsText'], contains('peligro inmediato'));
  });

  test('Spanish iOS permission copy uses localized clinical language', () {
    final permissionCopy = File(
      'ios/Runner/es.lproj/InfoPlist.strings',
    ).readAsStringSync();
    expect(permissionCopy, contains('TOC'));
    expect(permissionCopy, contains('tu dispositivo'));
    expect(permissionCopy, isNot(contains(RegExp(r'\bOCD\b'))));
    expect(permissionCopy, isNot(contains('su dispositivo')));
  });
}
