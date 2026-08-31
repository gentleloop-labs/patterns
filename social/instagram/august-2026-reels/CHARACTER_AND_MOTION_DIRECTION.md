# Character and minimal-motion direction

## Core format

All five reels use one fixed composition:

- Maya is shown waist-up in the lower-left or lower-center.
- Loop appears inside one large thought cloud in the upper-right.
- Character positions, camera, background, and scale remain fixed.
- Each dialogue beat swaps the active character's expression and the text inside the thought or speech bubble.
- The final 3-5 seconds crossfade to one static, real Patterns screen.

This should feel like a clean illustrated conversation, not full character animation.

## What changes between scenes

Only these properties should change:

- Maya expression
- Loop expression
- Active speaker highlight
- Thought-cloud or speech-bubble text
- Burned-in caption text
- Optional small prop held in a fixed pose
- Final product poster

Do not animate walking, hand gestures, body turns, props entering, camera movement, parallax, lip sync, or environmental action.

## Character design

### Maya

- Rounded human proportions with a waist-up crop
- Soft-green jacket, warm off-white shirt, muted-coral accent
- One fixed body pose with hands visible near the lower edge
- Five face assets: neutral, worried, skeptical, realizing, deliberate
- Eyes and mouth are part of each static expression asset

### Loop

- Compact charcoal character with warm-yellow accents and a spiral badge
- Always contained inside the thought cloud so it reads as an internal OCD voice
- One fixed body pose
- Five face assets: confident, helpful, questioning, insistent, surprised
- No horns, sharp teeth, red eyes, smoke, or frightening imagery

Loop is not a monster, clinician, separate personality, or hallucination. The character is a visual shorthand for the repetitive demand for certainty.

## Expression map

| Dialogue function | Maya | Loop |
| --- | --- | --- |
| OCD presents a demand | worried | confident |
| Maya responds automatically | skeptical | helpful |
| OCD adds a what-if | concerned | insistent |
| Maya recognizes the pattern | realizing | surprised |
| Maya chooses a response | deliberate | questioning |

## Scene template

Each reel should have 5-8 scenes driven by TTS line changes:

1. Hold one static background and fixed character layout.
2. Swap to the speaking character's expression at the start of the line.
3. Replace the bubble text at the same frame.
4. Hold that exact composition for the duration of the TTS line.
5. Crossfade for 4-6 frames into the next expression and text state.
6. Crossfade to a static product screen for the closing line.

No scene should require character rigging beyond image replacement.

## TTS voice direction

### Maya voice

- Adult, warm, grounded, conversational
- About 145-155 words per minute
- Starts mildly tense and becomes more deliberate
- Avoid inspirational, overly soothing, or triumphant delivery

### Loop voice

- Adult, quick, persuasive, matter-of-fact
- About 160-170 words per minute
- Sounds certain and helpful on the surface
- Never sinister, manic, robotic, or comedic-villainous

## TTS export rules

- Generate one file per line using `tts-lines.json`.
- Do not send expression notes or stage directions into the TTS tool.
- Prefer WAV, 48 kHz, mono. High-quality MP3 is acceptable if WAV is unavailable.
- Leave 100-150 ms of silence at the beginning and end of each line.
- Keep one voice preset for Maya and one for Loop across all five reels.
- Do not time-stretch more than 5%. Hold the static scene for the natural read.

## Caption system

- Burn in all dialogue for sound-off viewing.
- Use sentence case, maximum two lines, 54-64 px Manrope Semibold.
- Keep captions in one fixed area between the characters and the bottom safe zone.
- Highlight one short phrase per scene in warm yellow.
- Do not move captions around between scenes.
- Speaker color: Maya uses a soft-green name tick; Loop uses a warm-yellow name tick.

## Backgrounds

Use one static background per reel:

- Reel 1: front door and lock
- Reel 2: desk with laptop and a small stack of browser tabs
- Reel 3: simple exposure ladder diagram
- Reel 4: desk with a faint replay symbol behind Maya
- Reel 5: flat wave curve or ocean line

Backgrounds should establish context but must not animate.

## Product ending

- Use one code-native Patterns poster tailored to the reel's feature.
- Reference only the current mobile product when recreating a feature concept.
- Never use desktop screenshots or assets; the desktop project is abandoned.
- Apply a simple 8-12 frame crossfade from the cartoon layout.
- Keep the poster static and include the Patterns mark, one short line, `patternsocd.com`, and the clinical boundary.
- Do not animate taps, scrolling, timers, charts, or phone movement in this batch.

## Audio

- Dialogue carries the reel.
- Use a quiet music bed with no vocals.
- Optional cues are limited to one soft bubble pop per speaker change and one warm tone at the product reveal.
- Do not build sync-heavy sound design that requires exact prop animation.

## Safety and tone

- Do not show graphic intrusive-thought content.
- Do not make Maya look irrational, dirty, dangerous, or incapable.
- Do not imply that choosing differently immediately removes anxiety.
- Keep Loop visibly inside the thought cloud.
- End on agency and a next response, not guaranteed calm.
