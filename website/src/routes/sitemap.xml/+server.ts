import { allTags, postsByDate, totalPages } from '$lib/data/blog';
import { links } from '$lib/data/links';
import type { RequestHandler } from './$types';

export const prerender = true;

type Entry = {
  /** Path without a leading slash. `links.site` already ends in one. */
  path: string;
  lastmod: string;
  changefreq: 'daily' | 'weekly' | 'monthly';
  priority: string;
  images?: { loc: string; title: string }[];
};

/**
 * Bump when any static marketing route below changes in a crawl-meaningful way
 * (copy, structure, or primary media). Blog lastmod comes from post frontmatter.
 */
const STATIC_LASTMOD = '2026-08-11';

/**
 * Hand-maintained entries for the static marketing routes. Blog URLs are
 * derived from the post files below, so publishing a post never needs an edit
 * here - that is the whole reason this file replaced static/sitemap.xml.
 */
const staticEntries: Entry[] = [
  {
    path: '',
    lastmod: STATIC_LASTMOD,
    changefreq: 'weekly',
    priority: '1.0',
    images: [
      {
        loc: `${links.site}assets/website-cta-1200.jpg`,
        title: 'Patterns mobile app download CTA for OCD journaling and ERP practice'
      },
      {
        loc: `${links.site}assets/mockups/feature-graphic.jpg`,
        title: 'Patterns OCD tracker app for iPhone and Android'
      },
      {
        loc: `${links.site}og/patterns-og.png`,
        title: 'Patterns private OCD tracker and ERP journal app'
      }
    ]
  },
  { path: 'get', lastmod: STATIC_LASTMOD, changefreq: 'monthly', priority: '0.9' },
  { path: 'ocd', lastmod: STATIC_LASTMOD, changefreq: 'monthly', priority: '0.8' },
  { path: 'erp', lastmod: STATIC_LASTMOD, changefreq: 'monthly', priority: '0.8' },
  { path: 'cbt', lastmod: STATIC_LASTMOD, changefreq: 'monthly', priority: '0.8' },
  { path: 'toolkit', lastmod: STATIC_LASTMOD, changefreq: 'monthly', priority: '0.8' },
  { path: 'roadmap', lastmod: STATIC_LASTMOD, changefreq: 'monthly', priority: '0.7' },
  { path: 'faq', lastmod: STATIC_LASTMOD, changefreq: 'monthly', priority: '0.7' },
  { path: 'privacy', lastmod: STATIC_LASTMOD, changefreq: 'monthly', priority: '0.5' }
];

/** The blog index moves whenever a post lands, so it tracks the newest post. */
const newestPostDate = postsByDate[0]?.updated ?? STATIC_LASTMOD;

function escapeXml(value: string): string {
  return value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

function renderEntry(entry: Entry): string {
  const images = (entry.images ?? [])
    .map(
      (image) =>
        `    <image:image>\n` +
        `      <image:loc>${escapeXml(image.loc)}</image:loc>\n` +
        `      <image:title>${escapeXml(image.title)}</image:title>\n` +
        `    </image:image>\n`
    )
    .join('');

  return (
    `  <url>\n` +
    `    <loc>${escapeXml(links.site + entry.path)}</loc>\n` +
    `    <lastmod>${entry.lastmod}</lastmod>\n` +
    `    <changefreq>${entry.changefreq}</changefreq>\n` +
    `    <priority>${entry.priority}</priority>\n` +
    images +
    `  </url>\n`
  );
}

export const GET: RequestHandler = () => {
  const entries: Entry[] = [
    ...staticEntries,
    { path: 'blog', lastmod: newestPostDate, changefreq: 'daily', priority: '0.7' },
    // Page 1 is /blog, so paginated pages start at 2.
    ...Array.from({ length: Math.max(0, totalPages - 1) }, (_, i) => ({
      path: `blog/page/${i + 2}`,
      lastmod: newestPostDate,
      changefreq: 'weekly' as const,
      priority: '0.4'
    })),
    ...allTags.map(({ tag }) => ({
      path: `blog/tag/${tag}`,
      lastmod: newestPostDate,
      changefreq: 'weekly' as const,
      priority: '0.5'
    })),
    ...postsByDate.map((post) => ({
      path: `blog/${post.slug}`,
      lastmod: post.updated,
      changefreq: 'monthly' as const,
      priority: '0.6'
    }))
  ];

  const body =
    `<?xml version="1.0" encoding="UTF-8"?>\n` +
    `<urlset\n` +
    `  xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"\n` +
    `  xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"\n` +
    `>\n` +
    entries.map(renderEntry).join('') +
    `</urlset>\n`;

  return new Response(body, {
    headers: {
      'Content-Type': 'application/xml; charset=utf-8',
      'Cache-Control': 'public, max-age=3600'
    }
  });
};
