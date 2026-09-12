# Português (Brasil) in-app review

Status: **AI-assisted review in progress**
Reviewed: September 13, 2026
Frozen source: `lib/l10n/app_en.arb` at `606a985b...9074bed`
Draft: `lib/l10n/app_pt_BR.arb`
Method: context-aware AI review plus deterministic ARB integrity checks

This is not native-speaker or clinician sign-off.

## Completed passes

- All 711 messages have Brazilian Portuguese copy and retain the frozen
  English key set.
- All 133 parameterized messages now declare the same placeholder names and
  Dart types as English. ICU select cases and required `other` branches pass
  `tool/check_arb_review_integrity.dart`.
- Clinical terminology was normalized to `TOC` and `EPR`. The Y-BOCS name,
  obsession/compulsion distinction, self-check boundary, severity ranges,
  local-emergency-services wording, and deliberate distress measurements were
  retained.
- Privacy copy still distinguishes local personal content, app-store purchase
  processing, manual unencrypted exports, and optional default-off analytics.
  It explicitly excludes personal TOC content, generated summaries, locale,
  and language choice.
- Payment copy keeps Pro as a one-time unlock and states that tips are optional
  and unlock no features. No price was introduced.
- Accessibility labels preserve values, control states, hints, dates, counts,
  and user-authored placeholders. Direct references to the user were rewritten
  where practical to avoid gendered `pronto`, `ansioso`, or `cobrado` forms.
- Quiet completion now uses `Encerrar por agora`, and all factual saved/practice
  confirmations remain non-celebratory.

## Identified revisions

- Replaced mixed `OCD`/`TOC` terminology with `TOC`.
- Replaced the English-order `ERP` acronym with Brazilian `EPR`.
- Replaced inconsistent `reafirmação` with `reasseguramento` or the plainer
  `confirmação` where the user is asked what they wanted to request.
- Standardized `autoquestionário` to `autoavaliação` and repaired grammatical
  agreement introduced by that change.
- Standardized the main Insights label to `Análises` and Calm Insights to
  `Análises tranquilas`.
- Replaced untranslated `Feedback` and `Urge Surfing` labels.
- Corrected mixed-gender analytics lists using `nunca são enviados`.

## Review references

- [Brazilian Ministry of Health: Transtorno Obsessivo-Compulsivo
  (TOC)](https://bvsms.saude.gov.br/transtorno-obsessivo-compulsivo-toc/)
- [Brazilian Clinical Trials Registry: Exposição e Prevenção de
  Resposta](https://ensaiosclinicos.gov.br/rg/RBR-8pd94mw)
- [University of São Paulo clinical terminology for
  reasseguramento](https://teses.usp.br/teses/disponiveis/5/5142/tde-23082005-190905/publico/teseRoseliShavitt.pdf)

Consulted September 13, 2026.

## Open evidence

- Complete the independent linguistic-consistency and full back-translation
  pass; the changes above must be included in it.
- Render every representative mobile flow at normal, 200%, and maximum text
  sizes, then inspect clipping, wrapping, semantics, and focus order.
- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate Brazil App Store and Google Play listing,
  IAP, and screenshot copy.

Production enablement remains blocked while any open evidence remains.
