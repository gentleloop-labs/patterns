# Patterns Instagram launch carousels

Five complete 4:5 (1080 × 1350 px) carousels for the Patterns Instagram account.

## Recommended posting order

1. **Meet Patterns** — what the app is and the boundary around what it is not.
2. **The daily loop** — how someone uses Patterns from noticing to reflection.
3. **Why Patterns** — the privacy, calm, and clarity principles behind the product.
4. **NF on living with OCD** — diagnosis, rumination, music, and creative impact.
5. **Howie Mandel on living with OCD** — contamination fears, diagnosis, treatment, and openness.

## Output

- `output/post-01-meet-patterns/` — 5 cards
- `output/post-02-daily-loop/` — 6 cards
- `output/post-03-designed-for-privacy/` — 5 cards
- `output/post-04-nf-ocd-story/` — 6 cards
- `output/post-05-howie-mandel-ocd-story/` — 6 cards

Each folder is already ordered with zero-padded filenames for Instagram upload.

## Regenerate

From this directory:

```sh
node render.js
```

The renderer uses the repository's existing Puppeteer installation and the app's bundled Fraunces and Manrope font files.

Research sources and photo licenses for posts 4 and 5 are in `SOURCES.md`. Photo attribution is also embedded in the relevant cards and captions.
