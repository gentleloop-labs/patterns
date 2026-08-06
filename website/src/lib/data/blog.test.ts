import { readFileSync, readdirSync } from 'node:fs';
import { join } from 'node:path';
import { describe, expect, it } from 'vitest';
import { allTags, getPost, posts, postsByDate, relatedPosts, tagLabel } from './blog';

/**
 * Quality gate for the blog. The plan is to publish several posts a day for a
 * long time, and hand-checking each one does not survive that. These assertions
 * encode the house rules so a bad post fails CI instead of shipping.
 *
 * The prerender crawler already fails the build on a broken internal link, so
 * that case is deliberately not duplicated here.
 */

const CONTENT_DIR = join(process.cwd(), 'src/content/blog');

/** Raw file bodies, keyed by slug, with the frontmatter block stripped. */
const bodies = new Map<string, string>(
  readdirSync(CONTENT_DIR)
    .filter((name) => name.endsWith('.md'))
    .map((name) => {
      const raw = readFileSync(join(CONTENT_DIR, name), 'utf8');
      return [name.replace(/\.md$/, ''), raw.replace(/^---\r?\n[\s\S]*?\r?\n---/, '')];
    })
);

describe('blog posts', () => {
  it('loads every markdown file in src/content/blog', () => {
    expect(posts.length).toBe(bodies.size);
    expect(posts.length).toBeGreaterThan(0);
  });

  it('has unique slugs', () => {
    const slugs = posts.map((post) => post.slug);
    expect(new Set(slugs).size).toBe(slugs.length);
  });

  it('uses URL-safe slugs', () => {
    for (const post of posts) {
      expect(post.slug, post.slug).toMatch(/^[a-z0-9]+(-[a-z0-9]+)*$/);
    }
  });

  it('keeps meta descriptions short enough to survive a search result', () => {
    for (const post of posts) {
      expect(post.description.length, `${post.slug} description`).toBeLessThanOrEqual(165);
      expect(post.description.length, `${post.slug} description`).toBeGreaterThan(50);
    }
  });

  it('has a usable excerpt and title', () => {
    for (const post of posts) {
      expect(post.title.trim().length, post.slug).toBeGreaterThan(10);
      expect(post.excerpt.trim().length, post.slug).toBeGreaterThan(30);
    }
  });

  it('uses ISO dates, and never publishes a post dated in the future', () => {
    // Future-dated posts land in the sitemap with a lastmod that has not
    // happened yet, which search engines treat as a quality signal against you.
    const today = new Date().toISOString().slice(0, 10);
    for (const post of posts) {
      expect(post.date, post.slug).toMatch(/^\d{4}-\d{2}-\d{2}$/);
      expect(post.updated, post.slug).toMatch(/^\d{4}-\d{2}-\d{2}$/);
      expect(post.date.localeCompare(today), `${post.slug} is dated in the future`)
        .toBeLessThanOrEqual(0);
      expect(post.updated.localeCompare(post.date), `${post.slug} updated before date`)
        .toBeGreaterThanOrEqual(0);
    }
  });

  it('never uses em dashes in copy', () => {
    // Project-wide rule: the house style is " - ". This catches the ones that
    // slip in from pasted or generated text.
    for (const post of posts) {
      const body = bodies.get(post.slug) ?? '';
      const fields = [post.title, post.description, post.excerpt, body];
      for (const field of fields) {
        expect(field.includes('—'), `${post.slug} contains an em dash`).toBe(false);
      }
    }
  });

  it('tags every post, with tags that match the tag-page URL format', () => {
    for (const post of posts) {
      expect(post.tags.length, `${post.slug} has no tags`).toBeGreaterThan(0);
      for (const tag of post.tags) {
        expect(tag, `${post.slug} tag "${tag}"`).toMatch(/^[a-z0-9]+(-[a-z0-9]+)*$/);
      }
    }
  });

  it('resolves every manually listed related slug', () => {
    for (const post of posts) {
      for (const slug of post.related ?? []) {
        expect(getPost(slug), `${post.slug} relates to missing post "${slug}"`).toBeDefined();
        expect(slug, `${post.slug} relates to itself`).not.toBe(post.slug);
      }
    }
  });

  it('links internally at least twice, including one guide or pillar page', () => {
    // Orphan posts do not rank and do not convert. Every post has to hand the
    // reader somewhere useful next.
    for (const post of posts) {
      const body = bodies.get(post.slug) ?? '';
      const hrefs = [
        ...body.matchAll(/href="(\/[^"]*)"/g),
        ...body.matchAll(/\]\((\/[^)]*)\)/g)
      ].map((match) => match[1]);

      expect(hrefs.length, `${post.slug} has fewer than 2 internal links`)
        .toBeGreaterThanOrEqual(2);

      const hasAnchor = hrefs.some(
        (href) =>
          href === '/' ||
          href.startsWith('/erp') ||
          href.startsWith('/ocd') ||
          href.startsWith('/cbt') ||
          href.startsWith('/toolkit') ||
          href.startsWith('/blog/')
      );
      expect(hasAnchor, `${post.slug} links to no guide or pillar page`).toBe(true);
    }
  });

  it('never links to a blog slug that does not exist', () => {
    for (const post of posts) {
      const body = bodies.get(post.slug) ?? '';
      const blogLinks = [
        ...body.matchAll(/href="\/blog\/([a-z0-9-]+)"/g),
        ...body.matchAll(/\]\(\/blog\/([a-z0-9-]+)\)/g)
      ].map((match) => match[1]);

      for (const slug of blogLinks) {
        expect(getPost(slug), `${post.slug} links to missing post "${slug}"`).toBeDefined();
      }
    }
  });

  it('gives FAQ entries a real question and answer when present', () => {
    for (const post of posts) {
      for (const item of post.faq ?? []) {
        expect(item.q.trim().endsWith('?'), `${post.slug} FAQ "${item.q}"`).toBe(true);
        // Answers may be lifted into a search result on their own, so they have
        // to stand up without the surrounding page.
        expect(item.a.trim().length, `${post.slug} FAQ answer too short`).toBeGreaterThan(80);
      }
    }
  });

  it('states a plausible reading time', () => {
    for (const post of posts) {
      // The FAQ block renders on the page, so it counts toward the read.
      const faqText = (post.faq ?? []).map((item) => `${item.q} ${item.a}`).join(' ');
      const words = `${bodies.get(post.slug) ?? ''} ${faqText}`.trim().split(/\s+/).length;
      const estimate = words / 200;
      expect(post.readingMinutes, `${post.slug} reading time`).toBeGreaterThan(estimate * 0.6);
      expect(post.readingMinutes, `${post.slug} reading time`).toBeLessThan(estimate * 2);
    }
  });
});

describe('blog ordering and grouping', () => {
  it('sorts postsByDate newest first', () => {
    for (let i = 1; i < postsByDate.length; i++) {
      expect(postsByDate[i - 1].date.localeCompare(postsByDate[i].date)).toBeGreaterThanOrEqual(0);
    }
  });

  it('counts each tag once per post', () => {
    for (const { tag, count } of allTags) {
      expect(count).toBe(posts.filter((post) => post.tags.includes(tag)).length);
    }
  });

  it('formats tag labels for display', () => {
    expect(tagLabel('intrusive-thoughts')).toBe('Intrusive thoughts');
    expect(tagLabel('erp')).toBe('Erp');
  });

  it('always returns related posts, and never the post itself', () => {
    for (const post of posts) {
      const related = relatedPosts(post, 3);
      expect(related.length, post.slug).toBe(Math.min(3, posts.length - 1));
      expect(related.map((p) => p.slug)).not.toContain(post.slug);
      expect(new Set(related.map((p) => p.slug)).size).toBe(related.length);
    }
  });

  it('prefers manually listed related posts', () => {
    for (const post of posts) {
      const manual = post.related ?? [];
      if (manual.length === 0) continue;
      const related = relatedPosts(post, 3).map((p) => p.slug);
      expect(related.slice(0, manual.length)).toEqual(manual);
    }
  });
});
