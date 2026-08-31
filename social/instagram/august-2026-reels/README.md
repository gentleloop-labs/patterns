# Patterns Instagram reels: Aug 27-31, 2026

Five script-first cartoon reels for the Patterns Instagram campaign. Silent video masters are available in `output/` for the later TTS voiceover pass.

## Format

- Canvas: 1080 x 1920, vertical 9:16
- Frame rate: 30 fps
- Duration: 22-25 seconds each
- Animation: fixed 2D illustrations with expression swaps and short crossfades
- Cast: two recurring characters, Maya and Loop
- Audio: silent masters; two consistent TTS voices will be added from the line-level manifest
- Captions: burned in, maximum two lines, centered inside the 9:16 safe area
- Product reveal: one code-native Patterns feature poster during the final 3-7 seconds

## Reels

1. Aug 27 - `Just check one more time`
2. Aug 28 - `Searching for certainty in 12 browser tabs`
3. Aug 29 - `What people think ERP is vs. what it actually is`
4. Aug 30 - `The mental ritual no one else can see`
5. Aug 31 - `An urge is a wave, not a deadline`

## Production files

- `CHARACTER_AND_MOTION_DIRECTION.md` - shared visual language, rigs, voices, captions, and audio rules
- `01-one-more-check.md` through `05-urge-wave.md` - final dialogue and shot-by-shot direction
- `tts-lines.json` - clean TTS input lines with filenames and timing targets
- `HOOK_VARIANTS.md` - two alternate openings per reel for later A/B versions
- `ASSET_PLAN.md` and `CLAIMS.md` - build inventory and factual guardrails
- `assets/characters/` - final Maya and Loop expression sheets
- `output/*.mp4` - five rendered 1080 x 1920 silent masters

## Clinical and product boundaries

- These are educational cartoons, not individualized treatment instructions.
- Do not promise anxiety relief or portray recovery as making thoughts disappear.
- Do not depict ERP as forced, reckless, or a sudden confrontation with the hardest fear.
- Patterns supports journaling, tracking, and ERP practice. It does not diagnose OCD or replace qualified care.
- Product posters may reference the current mobile app, but must not embed screenshots or fabricate results, reviews, or progress metrics.

Clinical sources remain in `../august-2026-posts/SOURCES.md`.

## Voiceover production order

1. Generate every TTS line as a separate audio file using `tts-lines.json`.
2. Measure the real audio durations and replace the target timings if needed.
3. Lay the files over the matching silent master in `output/`.
4. Preserve the current scene boundaries unless a natural TTS read needs a small timing adjustment.
5. Export the final voiced version while retaining the burned-in dialogue.
