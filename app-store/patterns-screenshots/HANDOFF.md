# Handoff: App Store metadata and screenshot work

Session date 2026-08-23. Branch `master`. Everything below is uncommitted.

---

## 1. What this work is

Two related threads for the iOS app **Patterns: OCD & ERP Journal**
(App Store ID `6762611172`, US store, developer Aftaab Siddiqui):

1. **ASO metadata.** Decided a new title/subtitle/keyword set. Not yet applied
   in App Store Connect. Section 3.
2. **Screenshots.** Researched the competitive set, found that slot 1 was
   illegible at real search-grid size, and rebuilt slot 1. Slots 3 and 5 are
   specified but not built. Sections 4 to 6.

---

## 2. Data source

Rankings and keyword popularity come from a local **Astro ASO MCP server** at
`http://127.0.0.1:8089/mcp`. It was not registered as tools in the session, so
it was driven directly over streamable HTTP:

```sh
# initialize, capture Mcp-Session-Id from the response headers
curl -s -X POST http://127.0.0.1:8089/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"cc","version":"1"}}}' -D -
# then POST notifications/initialized, then tools/list, then tools/call
```

Useful tools: `get_app_keywords`, `search_app_store`, `add_keywords`,
`get_keyword_suggestions`, `extract_competitors_keywords`. Note
`search_app_store` requires **both** `keyword` and `store`.

Competitor screenshots came from the public iTunes lookup API:
`https://itunes.apple.com/lookup?id=<appStoreId>&country=us`, then rewriting the
`/392x696bb.png` suffix on `screenshotUrls` to `/800x0w.png` for a larger asset.

**Cleanup owed:** ~50 research keywords were added to the Patterns tracking list
(44 to 94 tracked) to measure popularity and difficulty. They can be pruned with
`remove_keywords`. That tool is destructive and requires listing the keywords
and getting explicit user confirmation first.

---

## 3. Metadata decision (agreed, NOT yet applied)

Current live values:

- Name: `Patterns: OCD & ERP Journal`
- Subtitle: `ERP tools for OCD recovery`
- Keywords: `compulsion,intrusive,thoughts,obsession,exposure,rumination,reassurance,checking,rituals,urge`

Agreed replacements:

| field | value | chars |
| --- | --- | --- |
| Name | `Patterns: OCD & ERP Journal` (unchanged) | 27/30 |
| Subtitle | `Track urges, anxiety, triggers` | 30/30 |
| Keywords | `compulsion,intrusive,thoughts,obsession,exposure,rumination,reassurance,reflect,therapy,cbt,log,dbt` | 99/100 |

Reasoning, so it is not relitigated:

- The old subtitle duplicated `ERP` and `OCD` from the title. Apple indexes a
  word once, so those were dead characters.
- Dropped `checking` (popularity 5 at difficulty 79) and `rituals` (popularity
  53 looks great but a store search shows it is Rituals Home & Body Cosmetics
  traffic; Patterns does not rank and will not).
- Dropped `urge` from the field because the subtitle now carries `urges`.
- Added `reflect` (pop 42 / diff 13, the best ratio found anywhere),
  `therapy` (54), `cbt` (41), `log` (39), `dbt` (31).
- **`track` is not `tracker`.** Apple treats them as separate tokens, so the
  chosen subtitle does *not* index `tracker` (pop 52). This was a deliberate
  trade: `therapy` is easier (diff 68 vs 82) and combines better with
  OCD/ERP/exposure. If the user later wants both, the subtitle variant
  `Urge tracker, anxiety triggers` (30 chars) frees `therapy` to stay in the
  keyword field.
- The whole OCD long tail sits at Apple's popularity floor of 5. Patterns
  already ranks #2 on `ocd journal`, #11 on `ocd`, #14 on `ocd help`,
  #17 on `reassurance`. That cluster is won and is worth very little traffic.
  The real constraint is **3 reviews**, not keywords.

Guardrail: `cbt` is in the invisible keyword field only. Per the project's
content rule, CBT must never be positioned as general CBT in user-facing copy,
only as ERP-for-OCD. Do not put CBT in the subtitle or screenshot copy.

---

## 4. Research output

`research/SCREENSHOT-RESEARCH.md` is the full write-up. Read it before touching
screenshot design. Key artifacts:

- `research/grid_thumbs.png` — every competitor's slot 1 at ~200pt, the width
  Apple actually gives a portrait screenshot in search results.
- `research/grid_thumbs_v4.png` — the same grid with the rebuilt slot 1 added.
- `research/competitors/` — third-party marketing assets, reference only.
  **Do not ship or commit these.** Consider adding to `.gitignore`.

The two findings that drive everything:

1. At 200pt from a 1290px master the scale factor is ~0.155. Anything under
   about **70px in the master is invisible** in search results. The old slot 1
   put all its information inside a device mockup at ~20-30px, so the tile
   communicated nothing.
2. The warm paper ground has no silhouette against the App Store's light
   background. Delay (teal), OCD.app (teal), ObsessLess (yellow) and OCD
   Toolkit (dark green) all cut a hard shape out of the page. **Not fixed** —
   see section 6.

---

## 5. What changed in this repo

Pre-existing uncommitted work (the "Storefront v3" paper redesign) was already
in the tree when this session started. Do not attribute it to this work.

**Changed by this session:**

| file | change |
| --- | --- |
| `index.html` | Slot 1 only. Trimmed the `<p>` subhead, added `ul.trust-strip` and `article.hero-card` between `.hero-copy` and `.phone`. |
| `style.css` | Appended the `Storefront v4` layer (from the banner comment at ~line 1404 to EOF). Nothing above that line was touched. |
| `exports/**` | Regenerated by `node render.js`. All targets, plus the feature graphic and contact sheet. |
| `research/` | New, untracked. |

`render.js` was **not** modified.

### Running the renderer

```sh
cd app-store/patterns-screenshots
node render.js
```

`content/node_modules` had been deleted, so puppeteer was reinstalled:

```sh
cd content && PUPPETEER_SKIP_DOWNLOAD=true npm install
```

The download skip is correct: `render.js` drives the system Chrome at
`/Applications/Google Chrome.app/Contents/MacOS/Google Chrome` via
`executablePath`, so the bundled Chromium is never used.

### Slot 1 rebuild, specifically

- Headline 96px to 118px, leading tightened to .96.
- Subhead reduced to `One clear next step.` The removed negatives ("No feed.
  No noise.") are now facts in the trust strip.
- New pill row: `No account` / `No cloud` / `No AI`.
- The `YOUR NEXT STEP / Try a two-minute delay` card is duplicated out of the
  device and rendered at roughly 2.9x, floating above it at `top: 900px`.
- The in-frame original is `display: none` so no gap is left behind.
- The device drops to `top: 1610px`, `z-index: 1`, and bleeds off the bottom
  while still showing real app content.

### Gotcha that will bite the next person

`style.css:27` defines `.shot:not(.shot-7) .phone`, specificity (0,3,0). A
plain `.shot-1 .phone { top: ... }` is (0,2,0) and **loses silently** — this
already caused one bad render. Per-shot phone overrides must be written as
`.shot-1:not(.shot-7) .phone`, and the Play variant as
`body[data-mode="play"] .shot-1:not(.shot-7) .phone`.

Always verify a change by downscaling the export to 200px wide before calling
it done. Full-size review will not catch legibility failures.

---

## 6. Next tasks, in priority order

### 6a. Build slots 3 and 5 (copy approved, not implemented)

Target set is 8 slots. New slot 3 is the category wedge; new slot 5 is a proof
card that **absorbs the current slot 6**, keeping the total at 8.

**Slot 3 — the wedge.** Every funded competitor in this category is an AI
chatbot (ObsessLess has "Ollie", Choiceful has "Choice", unstuck leads with
"24/7 Support Powered by AI"). Choiceful even ships a badge reading "100%
Reassurance Proof, Trained on ERP, unlike chatGPT", which concedes the
objection: an always-available chatbot that answers questions about the
intrusive thought is a reassurance-delivery machine, and reassurance seeking is
the compulsion. Patterns has no AI, no account and no server. That position
cannot be copied by a server-side product.

Approved copy (option A of three drafted):

> Headline: `No AI to ask.` / `No answer to chase.` (second line in gold `em`,
> matching the existing two-line pattern)
> Subhead: `Reassurance is the compulsion. This is a place to practise letting
> the question stay open.`

**Slot 5 — proof, no device on the canvas.** Three of the four strongest apps
in the category spend a full slot on a testimonial. Patterns has 3 reviews and
cannot, so this slot runs verifiable fact instead. Every line below is
supported by the app's own Settings screen and the Pro screen.

> Headline: `Your OCD data stays` / `on your phone.`
> - Journal and ERP records stay on the device
> - No account, no cloud sync, no OCD content uploaded
> - Anonymous feature-use analytics are optional
> - Exports go only where you send them
> - One-time unlock. No subscription.

Final slot order:

| slot | content | status |
| --- | --- | --- |
| 1 | When OCD feels urgent, start here | **rebuilt** |
| 2 | Delay the urge. Watch it change | keep, tighten crop so the intensity slider reads |
| 3 | No AI to ask. No answer to chase | **to build** |
| 4 | Build the ladder. Take the next step | keep, crop to three rungs so the ratings read |
| 5 | Nothing here leaves your phone | **to build**, replaces old slot 6 |
| 6 | See patterns. Not judgments | keep |
| 7 | A journal for thoughts you don't say out loud | keep |
| 8 | Patterns Pro, one-time unlock | keep |

Renaming or reordering means editing the `shots` array in `render.js` and the
`#shot-N` ids in `index.html`, and the list in `README.md`.

### 6b. Ground colour test (open brand decision)

Try two or three grounds that give the tile a silhouette against a light store
background, render each, and compare **at 200px wide** alongside
`research/grid_thumbs.png`. Do not just pick one; the user should choose. The
ground is `--paper: #f3ece0` in the v3 layer.

### 6c. Objection stickers

Adopt Choiceful's technique: one small floating pill per frame carrying a fact,
not a claim. Costs no slots.

### 6d. Smaller craft items

- Drop the repeated brand lockup on slots 2 onward. It recurs seven times and
  costs vertical space the headline needs.
- Keep Fraunces. It is the best typography in the category by a distance; the
  problem was scale, not typeface.
- Check whether an App Preview video is viable. None of the ten apps studied
  ship one.

---

## 7. Constraints to respect

- **No em dashes** in any app or website user-facing copy. Rephrase instead.
  (The existing v4 copy complies.)
- Voice for content is first-person from someone with OCD, never clinical.
- CBT is only ever positioned as ERP-for-OCD, never as general CBT.
- Do not promise anxiety relief. ERP builds tolerance for anxiety rather than
  removing it, so "relief" copy contradicts the product. A high-value keyword
  phrase (`anxiety relief`, pop 32) was deliberately rejected for this reason.
- Only claim what the app does. It has a streak counter, so "no streaks" is not
  available as a differentiator.

---

## 8. Watch item

**OCD Toolkit**, App Store ID `6770041180`, zero ratings, is running the
Patterns design language: dark ground, cream serif with a single italic accent
word, one-line poetic captions ("Name it to tame it." / "Breathe through the
spike." / "Let the urge pass."). Its App Store ID is higher than Patterns', so
it shipped later. It already outranks Patterns on `ocd therapy` (#7),
`intrusive thoughts` (#5), `compulsion` (#6) and `harm ocd` (#6).

The visual differentiation is being copied. The positional differentiation in
6a cannot be.
