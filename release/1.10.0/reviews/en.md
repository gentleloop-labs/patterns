# English: canonical source-risk review

Status: **AI-assisted review in progress**
Reviewed: September 17, 2026
Frozen source: `lib/l10n/app_en.arb` at `f9f017c5...04db013bd`
Source commit: `b5813aec96c53ff6480f9ca15f5a9c7d139974cf`
Method: context-aware AI source review plus deterministic ARB integrity checks

This is not clinician sign-off.

## Completed passes

- All 711 canonical messages have route, dialog, notification, PDF, commerce,
  clinical, safety, privacy, or accessibility context.
- All 133 parameterized messages retain valid placeholder names and Dart types.
  ICU selects, plurals, and required `other` branches pass
  `tool/check_arb_review_integrity.dart` across all six languages.
- Mobile/shared clinical terminology uses `OCD`,
  `exposure and response prevention (ERP)`, `obsession`, `compulsion`, and
  `Yale-Brown Obsessive Compulsive Scale (Y-BOCS)` consistently. The in-app
  Y-BOCS flow is explicitly a self-check based on the scale, not a diagnosis
  or emergency service.
- Privacy copy distinguishes local personal content, app-store purchase
  processing, manual unencrypted exports, and optional default-off analytics.
  It excludes personal content, generated summaries, locale, and language
  choice from analytics.
- Payment copy keeps Pro as a one-time unlock and states that tips are optional
  and unlock no features. No price or treatment outcome is introduced.
- Quiet completion uses `Done for now`, and its confirmations describe only
  what was saved or recorded.
- English iOS permission descriptions restrict each permission to its stated
  feature and describe local storage where applicable.

## Identified revisions

- Replaced outcome-oriented mobile `Recovery` labels with factual `Practice`,
  `practice activity`, or `self-help tool` wording. Stable IDs, analytics
  names, database values, and desktop-only copy remain unchanged.
- Replaced `Emergency Toolkit` with `Support in a difficult moment` and kept
  the explicit local-emergency-services boundary.
- Expanded the first guided exposure description to introduce
  `exposure and response prevention (ERP)` clearly.
- Reframed the PDF Y-BOCS description as an in-app self-check based on the
  scale rather than presenting it as the clinician-rated instrument itself.
- Replaced `assessment` with `self-check` throughout saved Y-BOCS actions and
  outcomes.
- Added the `snapshot, not a diagnosis` boundary to severe and extreme Y-BOCS
  result branches before professional-support guidance.
- Replaced self-congratulatory update copy with factual descriptions of the
  tools and activity summaries that changed.

## Review references

- [NIMH: OCD and exposure and response prevention](https://www.nimh.nih.gov/health/publications/obsessive-compulsive-disorder-when-unwanted-thoughts-or-repetitive-behaviors-take-over)
- [NHS: OCD treatment and exposure and response prevention](https://www.nhs.uk/mental-health/conditions/obsessive-compulsive-disorder-ocd/treatment/)
- [PubMed: original Y-BOCS development and clinician-rated scope](https://pubmed.ncbi.nlm.nih.gov/2684084/)
- [PubMed: self-report and clinician-administered Y-BOCS differ](https://pubmed.ncbi.nlm.nih.gov/20561767/)
- [FDA: disease-related diagnosis and treatment claims change software's
  regulatory posture](https://www.fda.gov/medical-devices/digital-health-center-excellence/step-3-software-function-intended-maintaining-or-encouraging-healthy-lifestyle)

Consulted September 17, 2026.

## Open evidence

- Complete an independent English linguistic-consistency pass against every
  rendered flow and the five reviewed translations.
- Render every representative mobile flow at normal, 200%, and maximum text
  sizes, then inspect clipping, wrapping, semantics, and focus order.
- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate English storefront listing, IAP, and
  screenshot adaptations for the United States, United Kingdom, Canada, and
  Australia.

Production enablement remains blocked while any open evidence remains.
