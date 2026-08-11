# Patterns Website

Marketing site for [Patterns](https://patternsocd.com/), built with SvelteKit.

**Preferred host is the apex domain:** `https://patternsocd.com/` (no `www`).
Canonicals, Open Graph URLs, the sitemap, and `robots.txt` all use apex. DNS
should 308 `www.patternsocd.com` → `patternsocd.com`, not the other way around.

## Development

```bash
cd website
npm install
npm run dev
```

Open [http://localhost:5173](http://localhost:5173).

## Build

```bash
npm run build
npm run preview
```

Static output is written to `build/`.

## Deploy

Production deploys via Vercel. Pushes that change `website/**` should rebuild
the site. After domain changes, confirm:

```bash
curl -sI https://patternsocd.com/          # 200
curl -sI https://www.patternsocd.com/      # 308 → https://patternsocd.com/
```
