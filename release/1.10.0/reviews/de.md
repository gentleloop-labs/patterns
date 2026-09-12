# Deutsch in-app review

Status: **AI-assisted review in progress**
Reviewed: September 13, 2026
Frozen source: `lib/l10n/app_en.arb` at `606a985b...9074bed`
Draft: `lib/l10n/app_de.arb`
Method: context-aware AI review plus deterministic ARB integrity checks

This is not native-speaker or clinician sign-off.

## Completed passes

- All 711 messages have German copy and retain the frozen English key set.
- All 133 parameterized messages declare the same placeholder names and Dart
  types as English. ICU select cases, German plurals, and required `other`
  branches pass `tool/check_arb_review_integrity.dart`.
- Clinical terminology now uses `Zwangsstörung`, `Zwangsgedanke`, and
  `Zwangshandlung`, with `Reizkonfrontation mit Reaktionsverhinderung (ERP)`
  written out on explanatory first-use surfaces. Y-BOCS remains a self-check,
  not a diagnosis or emergency service.
- Privacy copy distinguishes local personal content, app-store purchase
  processing, manual unencrypted exports, and optional default-off analytics.
  It excludes personal content, generated summaries, region, and language
  choice from analytics.
- Payment copy keeps Pro as a one-time unlock and states that tips are optional
  and unlock no features. No price was introduced.
- Direct address is consistently the respectful `Sie` form across the
  mobile/shared interface, including recovery programs and the application
  shell.
- Quiet completion uses `Für den Moment fertig`, and factual completion copy
  remains non-celebratory.

## Identified revisions

- Replaced the untranslated `OCD` acronym with natural German clinical terms.
- Standardized the interface from mixed `du`/`Sie` address to `Sie`.
- Replaced ambiguous `Zwang` labels with `Zwangsgedanke` or
  `Zwangshandlung` where the distinction matters.
- Replaced user-facing `Recovery` and cure-adjacent `Genesung` labels with
  factual `Übungen`, `Selbsthilfeübungen`, or `Übungsaktivität`.
- Replaced the awkward `Für jetzt fertig` with `Für den Moment fertig`.
- Renamed the emergency-tool entry so it does not imply clinical or emergency
  care, while retaining the explicit local-emergency-services boundary.
- Standardized `Selbsttest` to the less diagnostic `Selbstcheck`.
- Corrected the cross-platform purchase explanation from Apple-specific
  `App Store` to the respective app store.

## Review references

- [German Federal Ministry of Health portal: Zwangsstörung, Zwangsgedanken,
  and Zwangshandlungen](https://gesund.bund.de/zwangsstoerung)
- [IQWiG Gesundheitsinformation.de: Reizkonfrontation mit
  Reaktionsverhinderung](https://www.gesundheitsinformation.de/behandlung-von-zwangsstoerungen.html)

Consulted September 13, 2026.

## Open evidence

- Complete the independent linguistic-consistency and full back-translation
  pass; the changes above must be included in it.
- Render every representative mobile flow at normal, 200%, and maximum text
  sizes, then inspect clipping, wrapping, semantics, and focus order.
- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate German App Store and Google Play listing,
  IAP, and screenshot copy.

Production enablement remains blocked while any open evidence remains.
