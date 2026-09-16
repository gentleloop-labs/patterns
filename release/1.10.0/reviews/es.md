# Español neutral: revisión dentro de la app

Status: **AI-assisted review in progress**
Reviewed: September 16, 2026
Frozen source: `lib/l10n/app_en.arb` at `606a985b...9074bed`
Draft: `lib/l10n/app_es.arb`
Method: context-aware AI review plus deterministic ARB integrity checks

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

## Review references

- [Spanish Ministry of Health publication: trastorno obsesivo-compulsivo and
  exposición con prevención de respuesta](https://www.sanidad.gob.es/biblioPublic/publicaciones/recursos_propios/resp/revista_cdrom/VOL97/REVISIONES/RS97C_202309075.pdf)
- [GuíaSalud, Spanish National Health System: TOC and exposición con prevención
  de respuesta (EPR)](https://portal.guiasalud.es/gpc/trastorno_obsesivo_compulsivo_ninos_adolescentes/)

Consulted September 16, 2026.

## Open evidence

- Complete the independent linguistic-consistency and full back-translation
  pass; the changes above must be included in it.
- Render every representative mobile flow at normal, 200%, and maximum text
  sizes, then inspect clipping, wrapping, semantics, and focus order.
- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate Spanish (Mexico), Spanish (Spain), and Latin
  American Spanish storefront listing, IAP, and screenshot copy.

Production enablement remains blocked while any open evidence remains.
