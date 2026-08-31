# Asset plan for 2D production

## Available now

- Patterns logos: `../../../assets/logo.png` and `../../../assets/logo-dark.png`
- Brand fonts: `../../../assets/fonts/`
- Current mobile App Store exports may be used only as visual references for code-native posters.
- Current mobile screen source under `../../../lib/mobile/` is the product-truth reference.
- Desktop screenshots and desktop UI are explicitly excluded because that project is abandoned.
- Existing animated product UI and Remotion primitives: `../../../remotion/src/`
- Existing music and effects references: `../../../remotion/public/audio/`

## Build once and reuse

- One fixed Maya body illustration with five interchangeable expression images
- One fixed Loop body illustration with five interchangeable expression images
- One fixed thought cloud and one fixed Maya speech bubble
- Caption component with Maya and Loop speaker ticks
- Static product-poster component for the final 3-7 seconds
- One 4-6 frame crossfade helper for every scene change

## Reel-specific assets

- Reel 1: one static door-and-lock background
- Reel 2: one static desk, laptop, and twelve-tab background
- Reel 3: one static four-rung exposure-ladder background
- Reel 4: one static desk background with a faint rewind symbol
- Reel 5: one static wave-curve background labeled rise, crest, and shift

## Allowed code changes between scenes

- Swap Maya's expression image
- Swap Loop's expression image
- Replace thought-cloud or speech-bubble text
- Replace burned-in caption text
- Change the active speaker highlight
- Crossfade to the next static state
- Crossfade to one code-native Patterns feature poster

## Do not build for this batch

- Character rigs, lip sync, blinking, walking, hand gestures, or body movement
- Camera pans, zooms, rotations, parallax, or perspective changes
- Animated props, browser scrolling, button taps, timers, charts, or waves
- Multiple environments within one reel

## Must use real product truth

- App screen names and feature availability
- Pro labels for Exposure Hierarchy and Urge Surfing
- The Compulsion Delay flow and reflection outcomes
- The Patterns mark, colors, and type system
- Any product field or statement represented in the poster
