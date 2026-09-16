# Français : revue dans l’application

Status: **AI-assisted review in progress**
Reviewed: September 16, 2026
Frozen source: `lib/l10n/app_en.arb` at `606a985b...9074bed`
Draft: `lib/l10n/app_fr.arb`
Method: context-aware AI review plus deterministic ARB integrity checks

This is not native-speaker or clinician sign-off.

## Completed passes

- All 711 messages have French copy and retain the frozen English key set.
- All 133 parameterized messages declare the same placeholder names and Dart
  types as English. ICU select cases, French plurals, and required `other`
  branches pass `tool/check_arb_review_integrity.dart`.
- Mobile/shared clinical terminology now uses
  `trouble obsessionnel compulsif (TOC)` on explanatory first use, then `TOC`,
  with `obsession`, `compulsion`, and
  `exposition avec prévention de la réponse (EPR)` used consistently. Y-BOCS
  remains a self-check, not a diagnosis or emergency service. Desktop-only copy
  is outside this 1.10 review scope and remains unchanged.
- Privacy copy distinguishes local personal content, app-store purchase
  processing, manual unencrypted exports, and optional default-off analytics.
  It excludes personal content, generated summaries, region, and language
  choice from analytics.
- Payment copy keeps Pro as a one-time unlock and states that tips are optional
  and unlock no features. No price was introduced.
- Direct address consistently uses polite `vous` across the mobile/shared
  interface. France and Canada storefront adaptation remains a separate
  review.
- Quiet completion uses `Terminer pour le moment`, and factual completion copy
  remains non-celebratory.

## Identified revisions

- Replaced mixed `OCD`/`TOC` and `ERP`/`EPR` terminology with standard French
  `TOC` and `EPR`, including written-out first-use explanations.
- Retained polite `vous` address consistently across mobile/shared copy.
- Replaced cure-adjacent `rétablissement` labels with factual `pratique`,
  `auto-assistance`, or `activité de pratique` wording.
- Replaced anglicized `Insights` labels with `Analyses` and
  `Analyses sans pression`.
- Relabelled saved Y-BOCS records as `auto-évaluation`, changed severity
  wording to `catégorie`, and retained the non-diagnostic snapshot boundary.
- Renamed the immediate-support entry so it does not imply clinical or
  emergency care, while retaining the local-emergency-services boundary.
- Updated iOS permission copy to the same clinical terminology.

## Review references

- [Assurance Maladie: trouble obsessionnel compulsif (TOC), obsessions et
  compulsions](https://www.ameli.fr/assure/sante/themes/toc/symptomes-diagnostic-evolution)
- [Inserm: exposition avec prévention de la réponse](https://ipubli.inserm.fr/bitstream/handle/10608/8236/MS_2013_12_1111.pdf?isAllowed=y&sequence=5)

Consulted September 16, 2026.

## Open evidence

- Complete the independent linguistic-consistency and full back-translation
  pass; the changes above must be included in it.
- Render every representative mobile flow at normal, 200%, and maximum text
  sizes, then inspect clipping, wrapping, semantics, and focus order.
- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate France and Canada storefront listing, IAP,
  and screenshot copy.

Production enablement remains blocked while any open evidence remains.
