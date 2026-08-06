import { postsByDate } from '$lib/data/blog';
import { links } from '$lib/data/links';
import type { RequestHandler } from './$types';

export const prerender = true;

const FEED_TITLE = 'The Patterns Blog';
const FEED_DESCRIPTION =
  'Plain-language guides to OCD subtypes and ERP, plus honest essays from someone who lives with OCD.';

function escapeXml(value: string): string {
  return value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

/** Dates are authored as YYYY-MM-DD; RSS wants RFC 822. */
function toRfc822(isoDate: string): string {
  return new Date(`${isoDate}T00:00:00Z`).toUTCString();
}

export const GET: RequestHandler = () => {
  const latest = postsByDate[0]?.updated;

  const items = postsByDate
    .map(
      (post) =>
        `    <item>\n` +
        `      <title>${escapeXml(post.title)}</title>\n` +
        `      <link>${escapeXml(`${links.site}blog/${post.slug}`)}</link>\n` +
        `      <guid isPermaLink="true">${escapeXml(`${links.site}blog/${post.slug}`)}</guid>\n` +
        `      <description>${escapeXml(post.excerpt)}</description>\n` +
        `      <pubDate>${toRfc822(post.date)}</pubDate>\n` +
        post.tags
          .map((tag) => `      <category>${escapeXml(tag)}</category>\n`)
          .join('') +
        `    </item>\n`
    )
    .join('');

  const body =
    `<?xml version="1.0" encoding="UTF-8"?>\n` +
    `<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">\n` +
    `  <channel>\n` +
    `    <title>${escapeXml(FEED_TITLE)}</title>\n` +
    `    <link>${escapeXml(`${links.site}blog`)}</link>\n` +
    `    <description>${escapeXml(FEED_DESCRIPTION)}</description>\n` +
    `    <language>en</language>\n` +
    `    <atom:link href="${escapeXml(`${links.site}rss.xml`)}" rel="self" type="application/rss+xml" />\n` +
    (latest ? `    <lastBuildDate>${toRfc822(latest)}</lastBuildDate>\n` : '') +
    items +
    `  </channel>\n` +
    `</rss>\n`;

  return new Response(body, {
    headers: {
      'Content-Type': 'application/rss+xml; charset=utf-8',
      'Cache-Control': 'public, max-age=3600'
    }
  });
};
