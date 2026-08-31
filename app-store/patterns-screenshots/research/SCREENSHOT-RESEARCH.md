# Screenshot research: the OCD category on the US App Store

Compiled 2026-08-23. Evidence gathered from the Astro ASO MCP (keyword rankings)
and the iTunes lookup API (live screenshot assets for ten apps).

Competitor assets live in `competitors/`. They are third-party marketing
material kept for reference only. Do not ship or redistribute them; consider
gitignoring this folder.

---

## 1. The apps studied

| app | slots used | reviews | tier |
| --- | --- | --- | --- |
| NOCD: OCD Therapy and Tools | 5 | 16,586 | funded incumbent |
| OCD.app - Self help + Therapy | 6 | 3,387 | funded incumbent |
| Choiceful: OCD Treatment App | 8 | 602 | funded AI startup |
| OCD Test | 3 | 330 | incumbent, screener |
| ObsessLess - OCD Support App | 7 | 103 | funded AI startup |
| unstuck: OCD Therapy Tools | 6 | 36 | funded AI startup |
| Delay: OCD Recovery | 10 | 3 | indie peer |
| **Patterns: OCD & ERP Journal** | **7** | **3** | **us** |
| OCD Toolkit | 5 | 0 | indie peer |
| JustThoughts | 4 | 0 | indie peer |

Median slot count is 6. Nobody in the category is doing anything clever with
slots 8 to 10; Delay is the only app past 8 and its last shots are settings
screens.

---

## 2. The finding that matters most

`grid_thumbs.png` renders every app's slot 1 at ~200pt wide, which is the width
Apple actually gives a portrait screenshot in the search results list. That is
the only view most people ever see.

At that size:

- **Patterns is the least legible tile of the nine.** The headline is set in a
  two-line serif at a weight that dissolves, the subhead disappears entirely,
  and the device mockup occupies roughly two thirds of the canvas while
  transmitting zero readable information.
- **Patterns is also the tile with the weakest edge.** The warm paper ground is
  close enough to the App Store's own light background that the tile has no
  silhouette. Delay (teal), OCD.app (teal), ObsessLess (yellow), OCD Toolkit
  (dark green) all cut a hard shape out of the page. JustThoughts shares our
  problem with a white ground.
- **The tiles that survive are the ones where type is the subject and the phone
  is secondary or absent.** ObsessLess slot 1 has no device at all. OCD.app
  sets one word, `ELIMINATE`, at roughly a quarter of the canvas height.

The arithmetic: at 200pt from a 1290px master, the scale factor is about 0.155.
Body text at 30px in the master renders at under 5pt on screen. Anything below
roughly 70px in the master is decoration, not communication.

**Implication.** Slot 1 is not a product shot. It is a poster. The device can
appear, but it must be cropped to one legible element, and the type has to
carry the tile on its own.

---

## 3. Slot-by-slot patterns across the category

Reading all ten sets, four archetypes account for nearly every screenshot.

### A. The claim poster (slot 1, universal)

Big type, a positioning claim, minimal or no UI. Often carries a trust device.

- NOCD: "Everything you need to conquer OCD"
- Choiceful: "Your OCD Treatment App" + a floating `Research-Proven` pill
- ObsessLess: "Your OCD Support Companion" + a laurel reading "Trusted by tens
  of thousands of people with OCD worldwide"
- OCD.app: "ELIMINATE OBSESSIVE & ANXIOUS SELF-TALK" + "Trusted by 150,000 people"
- Delay: "Sit With The Urge"

### B. The mechanic shot (slots 2 to 5)

One screen, one verb, showing the thing the app actually does. Delay is the
purest execution: two-word captions below the device, `Log Urges`, `Search
Fears`, `Track Progress`, `Avoid Compulsions`, `Stay Consistent`.

### C. The proof slot (a whole slot, no product)

This is the archetype Patterns does not have at all.

- ObsessLess slot 5: a full-bleed testimonial card. "If I hadn't found Ollie,
  I'd probably still be struggling for another year" — Max, 3 months with Ollie,
  five stars. No phone on the canvas.
- Choiceful slot 7: mascot, five stars, "I have hope again. I'm getting my life
  back. It's literally an OCD therapist in my pocket." (Suzy M, OCD sufferer of
  7 yrs), plus an Apple laurel reading "Top Ranked App for OCD".
- OCD.app slot 2: a five-star review quote occupying the entire frame.

Three of the four best-performing apps in the category spend a full slot on
proof rather than product.

### D. The objection sticker (an overlay, not a slot)

Choiceful puts a floating pill on nearly every screenshot, each one answering a
specific doubt:

- "100% Reassurance Proof. Trained on ERP, unlike chatGPT"
- "Professional-Grade Therapy. But without the $200+/hr price tag"
- "Your OCD Is Unique. Choice gets smarter the more you use it"
- "Built For Your OCD. Evidence-based recovery course"

This is the most sophisticated technique in the category. It costs no slots and
it pre-empts the reasons someone bounces.

---

## 4. Where Patterns currently sits

| slot | current | archetype |
| --- | --- | --- |
| 1 | When OCD feels urgent, start here | claim poster, but illegible at grid size |
| 2 | Delay the urge. Watch it change | mechanic |
| 3 | Build the ladder. Take the next step | mechanic |
| 4 | See patterns. Not judgments | mechanic |
| 5 | A journal for thoughts you don't say out loud | mechanic |
| 6 | Your hardest thoughts stay yours | mechanic (privacy) |
| 7 | Move beyond tracking. Practise recovery | paywall |

Six of seven slots are product. Zero proof, zero objection handling, zero
differentiation against the category's dominant pattern.

Three specific problems:

1. **No proof slot.** With 3 reviews we cannot run a testimonial, but that is
   not the only form of proof available. See section 5.
2. **The strongest differentiator is buried at slot 6.** Local-first, no
   account, no cloud sync, and no OCD content uploaded is the one claim in this
   category that no funded competitor can copy, because their entire product is
   a server-side chatbot. It is currently past the point where anyone scrolls.
3. **Three type sizes per frame.** Serif headline, gold accent line, grey
   subhead, plus a centred logo lockup. Delay's two words and OCD.app's one
   word both read faster. The craft is better than everyone else's; the
   information hierarchy is slower than everyone else's.

---

## 5. The wedge we are not using

Every funded competitor in this category is an AI chatbot. ObsessLess has Ollie.
Choiceful has Choice. unstuck leads with "24/7 Support Powered by AI".

Choiceful's own copy gives the game away: they had to ship a badge saying
"100% Reassurance Proof, Trained on ERP, unlike chatGPT". They are defending
against the obvious objection, which is that an always-available chatbot that
answers your questions about the intrusive thought is a reassurance-delivery
machine, and reassurance seeking is the compulsion.

Patterns has no AI, no account, no server, and no feed. In a category racing
toward conversational AI, that is a coherent and defensible position rather
than a missing feature. It is also the honest one: the app does not promise
relief, it teaches you to sit with the urge.

Available proof that does not require reviews:

- Local-first, verifiable: no account, no cloud sync, no OCD content uploaded.
- One-time purchase against a category of subscriptions. JustThoughts already
  uses "No ads. No subscription." as its entire slot 2, at this exact tier.
- The exposure ladder is real product depth. Neither Delay nor OCD Toolkit
  shows a hierarchy with per-rung difficulty and anxiety ratings.

---

## 6. Recommended working set

Eight slots. Order is for the search grid, not for feature chronology.

| slot | job | direction |
| --- | --- | --- |
| 1 | claim poster | Keep "When OCD feels urgent, start here." Rebuild the frame: headline at roughly 20 percent of canvas height, device cropped to the single "Try a two-minute delay" card, ground darkened so the tile has an edge against the store background. Add a small factual trust strip: no account, no cloud, no AI. |
| 2 | mechanic, hero | Delay the urge. Crop tight to the delay screen so the intensity slider and wait durations are legible at grid size. |
| 3 | wedge | New. The anti-reassurance position. Something in the register of "No chatbot. Reassurance is the compulsion." This is the slot that separates us from all three funded competitors. |
| 4 | mechanic, depth | Build the ladder. Keep, tighten the crop to three rungs so the difficulty and anxiety ratings read. |
| 5 | proof | New. Not a testimonial. A factual card: local-first architecture, what the app never sends, one-time unlock, no subscription. This is the slot ObsessLess and Choiceful use for reviews and we use for verifiable fact. |
| 6 | mechanic | See patterns. Not judgments. Insights. |
| 7 | mechanic | The journal. |
| 8 | offer | Patterns Pro, one-time unlock, priced against the category's subscriptions. |

Privacy moves from slot 6 into slots 1, 3 and 5 as a running argument rather
than a single late feature shot.

### Craft notes

- Adopt the objection-sticker layer from Choiceful. One small floating pill per
  frame, carrying a fact rather than a claim. Cheap, no slot cost.
- Drop the per-frame logo lockup on slots 2 onward. It repeats seven times and
  costs vertical space that headline type needs.
- Keep the serif. It is the best typography in the category by a distance. The
  problem is scale, not typeface.
- Keep the ground warm but darken or saturate it enough that the tile has a
  silhouette in a light UI. The dark app UI already gives us contrast inside
  the frame; we need contrast outside it too.

### Production notes

- Masters stay at 1290x2796; `render.js` already zooms to each accepted size.
- Anything under about 70px in the master is invisible in search results.
  Test every frame by downscaling to 200px wide before shipping.
- Slot 1 should be A/B tested with Product Page Optimization once there is
  enough traffic. Apple allows three treatments against the baseline.
- Worth checking whether an App Preview video is viable. None of the ten apps
  studied ship one, so it is uncontested territory.

---

## 7. Watch item

OCD Toolkit (App Store ID 6770041180, zero ratings) is running our design
language: dark ground, cream serif with a single italic accent word, one-line
poetic captions. "Name it to tame it." "Breathe through the spike." "Let the
urge pass." Its ID is higher than ours, so it shipped after Patterns. It is
already outranking us on `ocd therapy` (#7), `intrusive thoughts` (#5),
`compulsion` (#6) and `harm ocd` (#6).

The visual differentiation we currently rely on is being copied. The positional
differentiation in section 5 cannot be.
