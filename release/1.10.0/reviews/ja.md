# 日本語 in-app review

Status: **AI-assisted review in progress**
Reviewed: September 16, 2026
Frozen source: `lib/l10n/app_en.arb` at `606a985b...9074bed`
Draft: `lib/l10n/app_ja.arb`
Method: context-aware AI review plus deterministic ARB integrity checks

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

## Review references

- [Japan Ministry of Health, Labour and Welfare mental-health portal:
  強迫性障害（強迫症）](https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/hukushi_kaigo/shougaishahukushi/kokoro/index.html)
- [Japan Ministry of Health, Labour and Welfare material: 曝露反応妨害法
  （ERP）, 強迫観念, and 強迫行為](https://www.mhlw.go.jp/file/06-Seisakujouhou-12200000-Shakaiengokyokushougaihokenfukushibu/0000113840.pdf)

Consulted September 16, 2026.

## Open evidence

- Complete the independent linguistic-consistency and full back-translation
  pass; the changes above must be included in it.
- Render every representative mobile flow at normal, 200%, and maximum text
  sizes, then inspect clipping, wrapping, semantics, and focus order.
- Complete physical iPhone and Android accessibility and purchase QA.
- Review and approve the separate Japanese App Store and Google Play listing,
  IAP, and screenshot copy.

Production enablement remains blocked while any open evidence remains.
