# Patterns Instagram posts: Aug 27-31, 2026

This folder contains square 1080 × 1080 px OCD- and Patterns-focused non-reel posts from the Aug 27-31 plan:

- 12 carousel posts
- 3 static/product posts
- 5 reel slots intentionally excluded from rendering

The mix matches the 20-post calendar rule: 60% carousels, 25% reels, 15% static/product posts.

The campaign combines:

- OCD education: the OCD loop, mental compulsions, reassurance, ERP, exposure hierarchies, and urge surfing
- Product education: Compulsion Delay, on-device privacy, tracking, and private insights
- Clear boundaries: Patterns supports reflection and ERP practice but does not diagnose OCD or replace qualified care

## Output

Run from this directory:

```sh
node render.js
```

The generated Instagram-ready square PNGs are written to `output/`, one folder per post, with zero-padded filenames for upload order.

## Skipped Reel Slots

- Aug 27: Cartoon - OCD says, "Just check one more time"
- Aug 28: Cartoon - Searching for certainty in 12 browser tabs
- Aug 29: Cartoon - What people think ERP is vs. what it actually is
- Aug 30: Cartoon - The mental ritual no one else can see
- Aug 31: Cartoon - An urge rises like a wave, then changes

Clinical references and product claims are documented in `SOURCES.md`.

The scripts and 2D production direction for these five reels are in `../august-2026-reels/`.
