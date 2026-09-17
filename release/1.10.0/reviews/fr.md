# Français : revue dans l’application

Status: **AI-assisted linguistic, risk, and rendered-layout review complete**
Reviewed: September 17, 2026
Frozen source: `lib/l10n/app_en.arb` at `b5813aec...139974cf`
Draft: `lib/l10n/app_fr.arb`
Method: context-aware AI review, a separate source-delta reconciliation and
semantic back-translation pass, plus deterministic ARB integrity checks

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
- A second pass started from every French message, back-translated its meaning
  into English, and compared it with the frozen English source. All 711
  messages were covered by product area, with separate checks for clinical,
  crisis, privacy, payment, accessibility, destructive-action, notification,
  PDF, placeholder, plural, polite address, and stable-ID meaning.

## Back-translation findings

| Risk area | French meaning recovered in the second pass | Resolution |
| --- | --- | --- |
| Release framing | `Patterns s’est amélioré` claimed that the product had improved, while the activity-summary wording did not specify recorded activity. | Replaced both with factual new-tool and recorded-activity-summary wording. |
| Y-BOCS PDF | `Le total est sur 40, dont 20...` could describe fixed subtotals instead of maximum possible scores. | Clarified the unchanged 40-point maximum and the two subtotals of up to 20 points. |
| Analytics consent | `Aider à améliorer Patterns ?` was an infinitive label rather than an explicit consent question, while `évaluations` and `région` could mean store reviews and geographic region. | Replaced them with a polite optional question, `niveaux de détresse`, and `paramètres régionaux`; sharing remains default-off. |
| Analytics detail | `événements de fonctionnalité nommés`, `la version` and `l’heure` did not clearly identify fixed event names, app version, and event time. | Made every transmitted field explicit while preserving the first-party, default-off, and deletion boundaries. |

No contradiction, omitted warning, added clinical claim, price, user-content
rewrite, placeholder change, or stable-ID change remains in the reviewed
mobile/shared catalog. Desktop-only `rétablissement` wording remains unchanged
and outside the 1.10 mobile gate. This is an AI-assisted semantic review, not
evidence of native-speaker or clinician sign-off.

- The 288-state rendered mobile matrix passes all six languages at normal,
  200%, and maximum stress text scales; evidence and scope are recorded in
  `../RENDERED-MOBILE-LAYOUT-REVIEW.md`.

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
- Reconciled 6 French messages with the September 17 English source freeze:
  factual release wording, exact Y-BOCS maximums, and precise default-off
  analytics consent and data-field explanations.

## Review references

- [Assurance Maladie: trouble obsessionnel compulsif (TOC), obsessions et
  compulsions](https://www.ameli.fr/assure/sante/themes/toc/symptomes-diagnostic-evolution)
- [Inserm: exposition avec prévention de la réponse](https://ipubli.inserm.fr/bitstream/handle/10608/8236/MS_2013_12_1111.pdf?isAllowed=y&sequence=5)
- [French Ministry of Health: crisis and immediate-danger support
  guidance](https://sante.gouv.fr/prevention-en-sante/sante-mentale/la-prevention-du-suicide/article/que-faire-et-a-qui-s-adresser-face-a-une-crise-suicidaire)

Consulted September 16 and rechecked September 17, 2026.

## Open evidence

- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate France and Canada storefront listing, IAP,
  and screenshot copy.

Production enablement remains blocked while any open evidence remains.
