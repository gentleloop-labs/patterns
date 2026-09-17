# Deutsch in-app review

Status: **AI-assisted linguistic, risk, and rendered-layout review complete**
Reviewed: September 17, 2026
Frozen source: `lib/l10n/app_en.arb` at `b5813aec...139974cf`
Draft: `lib/l10n/app_de.arb`
Method: context-aware AI review, a separate source-delta reconciliation and
semantic back-translation pass, plus deterministic ARB integrity checks

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
- A second pass started from every German message, back-translated its meaning
  into English, and compared it with the frozen English source. All 711
  messages were covered by product area, with separate checks for clinical,
  crisis, privacy, payment, accessibility, destructive-action, notification,
  PDF, placeholder, plural, respectful address, and stable-ID meaning.

## Back-translation findings

| Risk area | German meaning recovered in the second pass | Resolution |
| --- | --- | --- |
| Release framing | `Patterns wurde verbessert` claimed that the product had improved, while `sachliche Einblicke` omitted that the summary describes recorded activity. | Replaced both with factual new-self-help-exercise and activity-summary wording. |
| Y-BOCS | The PDF described the scale itself as self-rated, and severe/extreme result branches omitted the repeated non-diagnostic boundary. | Clarified that this is an in-app self-check based on Y-BOCS, preserved the 40/20/20 limits, and made every severity branch state that the result is a snapshot, not a diagnosis. |
| Emergency boundary | `möglicherweise in unmittelbarer Gefahr` weakened the frozen source's direct instruction. | All applicable immediate-danger branches now use `Wenn Sie in unmittelbarer Gefahr sind` and retain local emergency services. |
| Onboarding | `Zwangsmuster einschätzen` could sound like clinical assessment and added a diagnosis-specific label that the frozen source removed. | Replaced it with the neutral `meine aktuellen Muster ansehen`. |
| Privacy | `Region` did not precisely represent locale, and `Bewertungen` could be read as store reviews rather than recorded ratings. | Replaced them with `Gebietsschema` and `Belastungswerte`; analytics remains optional and default-off. |

No contradiction, omitted warning, added clinical claim, price, user-content
rewrite, placeholder change, or stable-ID change remains in the reviewed
mobile/shared catalog. Desktop-only `Recovery` wording remains unchanged and
outside the 1.10 mobile gate. This is an AI-assisted semantic review, not
evidence of native-speaker or clinician sign-off.

- The 288-state rendered mobile matrix passes all six languages at normal,
  200%, and maximum stress text scales; evidence and scope are recorded in
  `../RENDERED-MOBILE-LAYOUT-REVIEW.md`.

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
- Reconciled 9 German messages with the September 17 English source freeze:
  factual release wording, Y-BOCS and PDF boundaries, direct emergency
  instructions, neutral onboarding language, and precise privacy terms.

## Review references

- [German Federal Ministry of Health portal: Zwangsstörung, Zwangsgedanken,
  and Zwangshandlungen](https://gesund.bund.de/zwangsstoerung)
- [IQWiG Gesundheitsinformation.de: Reizkonfrontation mit
  Reaktionsverhinderung](https://www.gesundheitsinformation.de/behandlung-von-zwangsstoerungen.html)
- [AWMF S3 guideline for obsessive-compulsive disorders](https://www.awmf.org/uploads/tx_szleitlinien/038_017k_S3_Zwangsst%C3%B6rungen_2022-07.pdf)

Consulted September 13 and rechecked September 17, 2026.

## Open evidence

- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate German App Store and Google Play listing,
  IAP, and screenshot copy.

Production enablement remains blocked while any open evidence remains.
