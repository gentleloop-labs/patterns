# English: canonical source-risk review

Status: **AI-assisted linguistic and risk review complete; rendered review pending**
Reviewed: September 17, 2026
Frozen source: `lib/l10n/app_en.arb` at `f9f017c5...04db013bd`
Source commit: `b5813aec96c53ff6480f9ca15f5a9c7d139974cf`
Method: context-aware AI source review, a separate linguistic-consistency and
five-language semantic reconciliation pass, plus deterministic ARB integrity
checks

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
- A second pass started from every English message and checked its meaning
  against the reviewed Brazilian Portuguese, German, Japanese, neutral
  Spanish, and French catalogs. All 711 messages were covered by product area,
  with separate checks for clinical, crisis, privacy, payment, accessibility,
  destructive-action, notification, PDF, placeholder, plural, voice, and
  stable-ID meaning.

## Cross-language consistency findings

| Risk area | Independent English finding | Resolution |
| --- | --- | --- |
| Product framing | Mobile/shared headings and announcements consistently describe practice, self-help tools, and recorded activity without claiming recovery or improvement. | No canonical source change required. |
| Y-BOCS | The app consistently presents an in-app self-check based on Y-BOCS, preserves the 40/20/20 limits, and repeats the snapshot-not-diagnosis boundary in every severity branch. | No canonical source change required. |
| Immediate support | The tool does not imply clinical or emergency care and directly instructs a person in immediate danger to contact local emergency services. | No canonical source change required. |
| Privacy | Local content, app-store purchases, manual unencrypted exports, optional first-party analytics, excluded personal/locale data, and analytics deletion behavior remain distinct. | No canonical source change required. |
| Payments | Pro remains a one-time unlock; all three tips remain optional and unlock nothing. No price, urgency, or treatment outcome appears. | No canonical source change required. |
| Reviewed translations | All five reviewed translations preserve these meanings while using their approved clinical terminology and address conventions. | No contradiction or omitted boundary remains. |

The independent pass did not change either frozen source artifact, so the
recorded source hash and source commit remain valid. This is an AI-assisted
linguistic and risk review, not clinician sign-off or rendered-device evidence.

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
- Completed the independent September 17 linguistic-consistency comparison
  against all five reviewed translations; no additional canonical source
  revision was required.

## Review references

- [NIMH: OCD and exposure and response prevention](https://www.nimh.nih.gov/health/publications/obsessive-compulsive-disorder-when-unwanted-thoughts-or-repetitive-behaviors-take-over)
- [NHS: OCD treatment and exposure and response prevention](https://www.nhs.uk/mental-health/conditions/obsessive-compulsive-disorder-ocd/treatment/)
- [PubMed: original Y-BOCS development and clinician-rated scope](https://pubmed.ncbi.nlm.nih.gov/2684084/)
- [PubMed: self-report and clinician-administered Y-BOCS differ](https://pubmed.ncbi.nlm.nih.gov/20561767/)
- [FDA: disease-related diagnosis and treatment claims change software's
  regulatory posture](https://www.fda.gov/medical-devices/digital-health-center-excellence/step-3-software-function-intended-maintaining-or-encouraging-healthy-lifestyle)

Consulted and rechecked September 17, 2026.

## Open evidence

- Render every representative mobile flow at normal, 200%, and maximum text
  sizes, then inspect clipping, wrapping, semantics, and focus order.
- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate English storefront listing, IAP, and
  screenshot adaptations for the United States, United Kingdom, Canada, and
  Australia.

Production enablement remains blocked while any open evidence remains.
