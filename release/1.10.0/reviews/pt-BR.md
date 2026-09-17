# Português (Brasil) in-app review

Status: **AI-assisted linguistic, risk, and rendered-layout review complete**
Reviewed: September 17, 2026
Frozen source: `lib/l10n/app_en.arb` at `b5813aec...139974cf`
Draft: `lib/l10n/app_pt_BR.arb`
Method: context-aware AI review, a separate source-delta reconciliation and
semantic back-translation pass, plus deterministic ARB integrity checks

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
- A second pass started from every Portuguese message, back-translated its
  meaning into English, and compared it with the frozen English source. All
  711 messages were covered by product area, with separate checks for clinical,
  crisis, privacy, payment, accessibility, destructive-action, notification,
  PDF, placeholder, plural, and stable-ID meaning.

## Back-translation findings

| Risk area | Portuguese meaning recovered in the second pass | Resolution |
| --- | --- | --- |
| Product framing | Several mobile labels still promised or implied “recovery” where frozen English now says practice or self-help. | 20 affected labels, notifications, purchase messages, backup copy, and accessibility values now use `prática` or `autoajuda`. Desktop-only copy remains unchanged and outside the 1.10 mobile gate. |
| ERP onboarding | “A short guided exposure” had lost response prevention and the EPR acronym. | Restored `exposição e prevenção de resposta (EPR)` without implying treatment. |
| Y-BOCS | The PDF description sounded like the scale itself was self-rated; severe and extreme result branches lacked the repeated non-diagnostic boundary. | Clarified that this is an in-app self-check based on Y-BOCS and made every severity branch say the result is a snapshot, not a diagnosis. |
| Immediate support | A “kit” label could be read as a packaged emergency service. | Renamed it `Apoio em um momento difícil`; the local-emergency-services boundary is unchanged. |
| Release and commerce tone | `O Patterns melhorou`, progress insights, and a gendered `Obrigado` exceeded the factual source or introduced avoidable gender. | Replaced them with factual new-tool/activity wording and `Agradecemos o apoio`. |
| Destructive actions | The wipe and backup summaries called stored records “recovery” history. | Renamed only the displayed category to self-help practice; persisted records and schemas are unchanged. |

No contradiction, omitted warning, added clinical claim, price, user-content
rewrite, placeholder change, or stable-ID change remains in the reviewed
mobile/shared catalog. This is an AI-assisted semantic review, not evidence of
native-speaker or clinician sign-off.

- The 288-state rendered mobile matrix passes all six languages at normal,
  200%, and maximum stress text scales; evidence and scope are recorded in
  `../RENDERED-MOBILE-LAYOUT-REVIEW.md`.

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
- Reconciled 27 Portuguese messages with the September 17 English source
  freeze: practice/self-help framing, onboarding EPR expansion, Y-BOCS and PDF
  boundaries, immediate-support naming, factual update copy, and gender-neutral
  commerce thanks.

## Review references

- [Brazilian Ministry of Health: Transtorno Obsessivo-Compulsivo
  (TOC)](https://bvsms.saude.gov.br/transtorno-obsessivo-compulsivo-toc/)
- [Brazilian Clinical Trials Registry: Exposição e Prevenção de
  Resposta](https://ensaiosclinicos.gov.br/rg/RBR-8pd94mw)
- [Brazilian Ministry of Health care pathway: TOC and exposure with response
  prevention](https://linhasdecuidado.saude.gov.br/portal/ansiedade/unidade-de-atencao-primaria/planejamento-terapeutico/)
- [University of São Paulo clinical terminology for
  reasseguramento](https://teses.usp.br/teses/disponiveis/5/5142/tde-23082005-190905/publico/teseRoseliShavitt.pdf)

Consulted September 13 and rechecked September 17, 2026.

## Open evidence

- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate Brazil App Store and Google Play listing,
  IAP, and screenshot copy.

Production enablement remains blocked while any open evidence remains.
