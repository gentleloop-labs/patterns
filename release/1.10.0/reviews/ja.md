# 日本語 in-app review

Status: **AI-assisted linguistic, risk, and rendered-layout review complete**
Reviewed: September 17, 2026
Frozen source: `lib/l10n/app_en.arb` at `b5813aec...139974cf`
Draft: `lib/l10n/app_ja.arb`
Method: context-aware AI review, a separate source-delta reconciliation and
semantic back-translation pass, plus deterministic ARB integrity checks

This is not native-speaker or clinician sign-off.

## Completed passes

- All 711 messages have Japanese copy and retain the frozen English key set.
- All 133 parameterized messages declare the same placeholder names and Dart
  types as English. ICU select cases and required `other` branches pass
  `tool/check_arb_review_integrity.dart`.
- Mobile/shared clinical terminology now uses `強迫性障害（強迫症）` on
  explanatory first use, then `強迫症`, with `強迫観念`, `強迫行為`, and
  `曝露反応妨害法（ERP）` used consistently. Y-BOCS remains a self-check,
  not a diagnosis or emergency service. Desktop-only copy is outside this
  1.10 review scope and remains unchanged.
- Privacy copy distinguishes local personal content, app-store purchase
  processing, manual unencrypted exports, and optional default-off analytics.
  It excludes personal content, generated summaries, region, and language
  choice from analytics.
- Payment copy keeps Pro as a one-time unlock and states that tips are optional
  and unlock no features. No price was introduced.
- Direct address avoids an explicit pronoun where natural, while control
  labels, values, states, hints, dates, and counts remain explicit.
- Quiet completion uses `今はここまで`, and factual completion copy remains
  non-celebratory.
- A second pass started from every Japanese message, back-translated its
  meaning into English, and compared it with the frozen English source. All
  711 messages were covered by product area, with separate checks for
  clinical, crisis, privacy, payment, accessibility, destructive-action,
  notification, PDF, placeholder, plural, direct-address, and stable-ID
  meaning.

## Back-translation findings

| Risk area | Japanese meaning recovered in the second pass | Resolution |
| --- | --- | --- |
| Release framing | `Patternsがより良くなりました` claimed that Patterns had become better, and `活動の振り返り` described a reflection rather than a factual summary of recorded activity. | Replaced both with factual new-tool and recorded-activity-summary wording. |
| Onboarding | `今の強迫症のパターン` added an OCD-specific diagnosis label that the frozen source intentionally removed. | Replaced it with the neutral `今のパターン`. |
| Y-BOCS PDF | `合計40点` and `それぞれ20点` could describe fixed scores rather than maximum possible scores. | Clarified the unchanged maximums as `40点満点` and `20点満点`. |
| Privacy | `評価` could mean app-store reviews rather than recorded distress ratings, and `地域` was broader than locale. | Replaced them with `苦痛度` and `地域設定`; analytics remains optional and default-off. |

No contradiction, omitted warning, added clinical claim, price, user-content
rewrite, placeholder change, or stable-ID change remains in the reviewed
mobile/shared catalog. Desktop-only `リカバリー` wording remains unchanged
and outside the 1.10 mobile gate. This is an AI-assisted semantic review, not
evidence of native-speaker or clinician sign-off.

- The 288-state rendered mobile matrix passes all six languages at normal,
  200%, and maximum stress text scales; evidence and scope are recorded in
  `../RENDERED-MOBILE-LAYOUT-REVIEW.md`.

## Identified revisions

- Replaced the untranslated `OCD` acronym with Japanese clinical terminology.
- Standardized exposure terminology from mixed katakana and kanji to `曝露`,
  and wrote out `曝露反応妨害法（ERP）` on explanatory first-use surfaces.
- Replaced cure-adjacent `回復` and `リカバリー` labels with factual `練習`,
  `セルフヘルプ`, or `練習アクティビティ` wording.
- Standardized mixed `インサイト` labels to `分析` and `穏やかな分析`.
- Replaced Y-BOCS record actions labelled as `評価` with `セルフチェック`,
  and added the non-diagnostic snapshot boundary to every severity range.
- Removed unnecessary explicit `あなた` address from privacy and release copy.
- Clarified that the immediate-support tools do not provide medical or
  emergency support, without inventing a regional emergency number.
- Corrected iOS permission copy from `暴露` to the clinical spelling `曝露`
  and replaced the untranslated disorder acronym.
- Reconciled 5 Japanese messages with the September 17 English source freeze:
  factual release wording, neutral onboarding language, exact Y-BOCS maximums,
  and precise analytics exclusions.

## Review references

- [Japan Ministry of Health, Labour and Welfare mental-health portal:
  強迫性障害（強迫症）](https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/hukushi_kaigo/shougaishahukushi/kokoro/index.html)
- [Japan Ministry of Health, Labour and Welfare material: 曝露反応妨害法
  （ERP）, 強迫観念, and 強迫行為](https://www.mhlw.go.jp/file/06-Seisakujouhou-12200000-Shakaiengokyokushougaihokenfukushibu/0000113840.pdf)
- [Japan Ministry of Health, Labour and Welfare: public mental-health
  consultation services](https://www.mhlw.go.jp/kokoro/youth/consultation/window/index.html)

Consulted September 16 and rechecked September 17, 2026.

## Open evidence

- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate Japanese App Store and Google Play listing,
  IAP, and screenshot copy.

Production enablement remains blocked while any open evidence remains.
