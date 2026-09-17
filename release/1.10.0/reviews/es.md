# Español neutral: revisión dentro de la app

Status: **AI-assisted linguistic and risk review complete; rendered review pending**
Reviewed: September 17, 2026
Frozen source: `lib/l10n/app_en.arb` at `b5813aec...139974cf`
Draft: `lib/l10n/app_es.arb`
Method: context-aware AI review, a separate source-delta reconciliation and
semantic back-translation pass, plus deterministic ARB integrity checks

This is not native-speaker or clinician sign-off.

## Completed passes

- All 711 messages have neutral Spanish copy and retain the frozen English key
  set.
- All 133 parameterized messages declare the same placeholder names and Dart
  types as English. ICU select cases, Spanish plurals, and required `other`
  branches pass `tool/check_arb_review_integrity.dart`.
- Mobile/shared clinical terminology now uses
  `trastorno obsesivo-compulsivo (TOC)` on explanatory first use, then `TOC`,
  with `obsesión`, `compulsión`, and
  `exposición con prevención de respuesta (EPR)` used consistently. Y-BOCS
  remains a self-check, not a diagnosis or emergency service. Desktop-only copy
  is outside this 1.10 review scope and remains unchanged.
- Privacy copy distinguishes local personal content, app-store purchase
  processing, manual unencrypted exports, and optional default-off analytics.
  It excludes personal content, generated summaries, region, and language
  choice from analytics.
- Payment copy keeps Pro as a one-time unlock and states that tips are optional
  and unlock no features. No price was introduced.
- Direct address is consistently neutral `tú` across the mobile/shared
  interface. Region-specific Spain and Mexico storefront adaptation remains a
  separate review.
- Quiet completion uses `Terminar por ahora`, and factual completion copy
  remains non-celebratory.
- A second pass started from every Spanish message, back-translated its meaning
  into English, and compared it with the frozen English source. All 711
  messages were covered by product area, with separate checks for clinical,
  crisis, privacy, payment, accessibility, destructive-action, notification,
  PDF, placeholder, plural, neutral address, and stable-ID meaning.

## Back-translation findings

| Risk area | Spanish meaning recovered in the second pass | Resolution |
| --- | --- | --- |
| Release framing | `Patterns ha mejorado` claimed that the product had improved, while `resúmenes objetivos de actividad` was ambiguous about whether the summaries were factual or goal-based. | Replaced both with factual new-tool and descriptive recorded-activity wording. |
| Y-BOCS PDF | `El total es de 40, con 20...` could describe fixed scores instead of maximum possible scores. | Clarified the unchanged maximum as 40 points, with up to 20 points for each subtotal. |
| Analytics consent | `¿Ayudas...?` was unnatural as a consent question, and `valoraciones` and `región` could mean app-store ratings and geographic region. | Replaced them with an explicit optional question, `niveles de malestar`, and `configuración regional`; sharing remains default-off. |
| Analytics detail | `eventos de uso con nombre`, `la versión` and `la hora` did not clearly identify the fixed event names, app version, and event time. | Made every transmitted field explicit while preserving the first-party, default-off, and deletion boundaries. |

No contradiction, omitted warning, added clinical claim, price, user-content
rewrite, placeholder change, or stable-ID change remains in the reviewed
mobile/shared catalog. Desktop-only `recuperación` wording remains unchanged
and outside the 1.10 mobile gate. This is an AI-assisted semantic review, not
evidence of native-speaker or clinician sign-off.

## Identified revisions

- Replaced mixed `OCD`/`TOC` and `ERP`/`EPR` terminology with standard Spanish
  `TOC` and `EPR`, including written-out first-use explanations.
- Standardized mixed formal and informal address to neutral `tú`.
- Replaced cure-adjacent `recuperación` labels with factual `práctica`,
  `autoayuda`, or `actividad de práctica` wording.
- Replaced ambiguous `Información` labels with `Análisis` and
  `Análisis sin presión`.
- Replaced `urgencia` with `impulso` where the English source means an urge.
- Standardized reassurance-seeking terminology as `búsqueda de confirmación`.
- Relabelled saved Y-BOCS records as `autoevaluación` and added the
  non-diagnostic snapshot boundary to every severity range.
- Renamed the immediate-support entry so it does not imply clinical or
  emergency care, while retaining the local-emergency-services boundary.
- Updated iOS permission copy to the same neutral voice and clinical
  terminology.
- Reconciled 6 Spanish messages with the September 17 English source freeze:
  factual release wording, exact Y-BOCS maximums, and precise default-off
  analytics consent and data-field explanations.

## Review references

- [Spanish Ministry of Health publication: trastorno obsesivo-compulsivo and
  exposición con prevención de respuesta](https://www.sanidad.gob.es/biblioPublic/publicaciones/recursos_propios/resp/revista_cdrom/VOL97/REVISIONES/RS97C_202309075.pdf)
- [GuíaSalud, Spanish National Health System: TOC and exposición con prevención
  de respuesta (EPR)](https://portal.guiasalud.es/gpc/trastorno_obsesivo_compulsivo_ninos_adolescentes/)
- [Spanish Ministry of Health: imminent-danger and professional-care
  boundaries](https://www.sanidad.gob.es/linea024/)

Consulted September 16 and rechecked September 17, 2026.

## Open evidence

- Render every representative mobile flow at normal, 200%, and maximum text
  sizes, then inspect clipping, wrapping, semantics, and focus order.
- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate Spanish (Mexico), Spanish (Spain), and Latin
  American Spanish storefront listing, IAP, and screenshot copy.

Production enablement remains blocked while any open evidence remains.
