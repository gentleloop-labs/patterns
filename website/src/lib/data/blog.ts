/**
 * Blog posts for Patterns.
 *
 * Each post is a markdown file in `src/content/blog/`, compiled by mdsvex. The
 * filename is the slug and the URL, so renaming a file breaks a live URL - do
 * not rename published posts.
 *
 * Two kinds of post live here:
 *
 * - Personal essays, first person, from the person building Patterns. Honest,
 *   plain, no pretending to be a therapist.
 * - Clinical explainers on OCD subtypes and ERP technique, written to answer a
 *   search query directly. These use a neutral explanatory register, cite
 *   primary sources in a `## Sources` section, and carry a clearly labelled
 *   first-person section so the lived experience stays visible.
 *
 * Neither kind gives medical advice, and every post renders the medical
 * disclaimer. See `src/content/POST_TEMPLATE.md` for the house structure.
 */

export type BlogFaq = {
  q: string;
  a: string;
};

export type BlogPost = {
  /** Filename without the extension. Also the URL path segment. */
  slug: string;
  title: string;
  /** Meta description. Keep at or under 160 characters. */
  description: string;
  /** ISO date (YYYY-MM-DD). */
  date: string;
  /** ISO date of the last meaningful edit. Defaults to `date`. */
  updated: string;
  readingMinutes: number;
  /** One or two sentence teaser used on the index and in metadata. */
  excerpt: string;
  /** Topic tags. The first one is treated as the primary cluster. */
  tags: string[];
  /** Comma-separated meta keywords for the post page. */
  keywords?: string;
  /** Drives FAQPage structured data when present. */
  faq?: BlogFaq[];
  /** Manual related-post slugs. Falls back to tag overlap when omitted. */
  related?: string[];
};

/** Frontmatter as authored - most fields are optional and filled in below. */
type RawFrontmatter = Partial<Omit<BlogPost, 'slug'>>;

const metaModules = import.meta.glob<RawFrontmatter>('/src/content/blog/*.md', {
  eager: true,
  import: 'metadata'
});

/** Lazily loaded post bodies, so the index does not bundle every post. */
const bodyModules = import.meta.glob('/src/content/blog/*.md');

function slugFromPath(path: string): string {
  return path.slice(path.lastIndexOf('/') + 1).replace(/\.md$/, '');
}

function toPost(path: string, meta: RawFrontmatter): BlogPost {
  const slug = slugFromPath(path);

  if (!meta?.title || !meta?.description || !meta?.date) {
    throw new Error(
      `Blog post "${slug}" is missing required frontmatter (title, description, date).`
    );
  }

  return {
    slug,
    title: meta.title,
    description: meta.description,
    date: meta.date,
    updated: meta.updated ?? meta.date,
    readingMinutes: meta.readingMinutes ?? 5,
    excerpt: meta.excerpt ?? meta.description,
    tags: meta.tags ?? [],
    keywords: meta.keywords,
    faq: meta.faq,
    related: meta.related
  };
}

export const posts: BlogPost[] = Object.entries(metaModules).map(([path, meta]) =>
  toPost(path, meta)
);

export function getPost(slug: string): BlogPost | undefined {
  return posts.find((post) => post.slug === slug);
}

/** Newest first, for the index. */
export const postsByDate: BlogPost[] = [...posts].sort((a, b) => {
  const byDate = b.date.localeCompare(a.date);
  // Same-day posts get a stable order instead of whatever the glob returned.
  return byDate !== 0 ? byDate : a.slug.localeCompare(b.slug);
});

export const POSTS_PER_PAGE = 12;

/** Total index pages. Always at least 1, so an empty blog still renders. */
export const totalPages = Math.max(1, Math.ceil(postsByDate.length / POSTS_PER_PAGE));

export function postsForPage(page: number): BlogPost[] {
  const start = (page - 1) * POSTS_PER_PAGE;
  return postsByDate.slice(start, start + POSTS_PER_PAGE);
}

/** Every tag in use, most-used first, then alphabetical. */
export const allTags: { tag: string; count: number }[] = (() => {
  const counts = new Map<string, number>();
  for (const post of posts) {
    for (const tag of post.tags) {
      counts.set(tag, (counts.get(tag) ?? 0) + 1);
    }
  }
  return [...counts.entries()]
    .map(([tag, count]) => ({ tag, count }))
    .sort((a, b) => b.count - a.count || a.tag.localeCompare(b.tag));
})();

export function postsByTag(tag: string): BlogPost[] {
  return postsByDate.filter((post) => post.tags.includes(tag));
}

/** Turns a tag into the label shown on hub pages: "intrusive-thoughts" -> "Intrusive thoughts". */
export function tagLabel(tag: string): string {
  const spaced = tag.replace(/-/g, ' ');
  return spaced.charAt(0).toUpperCase() + spaced.slice(1);
}

/**
 * Posts to show at the end of `post`. Manual `related` slugs win, then the
 * posts sharing the most tags, then the newest - so there is always something.
 */
export function relatedPosts(post: BlogPost, limit = 3): BlogPost[] {
  const picked: BlogPost[] = [];
  const seen = new Set<string>([post.slug]);

  const add = (candidate: BlogPost | undefined) => {
    if (!candidate || seen.has(candidate.slug) || picked.length >= limit) return;
    seen.add(candidate.slug);
    picked.push(candidate);
  };

  for (const slug of post.related ?? []) {
    add(getPost(slug));
  }

  const byOverlap = postsByDate
    .filter((other) => !seen.has(other.slug))
    .map((other) => ({
      post: other,
      overlap: other.tags.filter((tag) => post.tags.includes(tag)).length
    }))
    .filter((entry) => entry.overlap > 0)
    .sort((a, b) => b.overlap - a.overlap || b.post.date.localeCompare(a.post.date));

  for (const entry of byOverlap) add(entry.post);
  for (const other of postsByDate) add(other);

  return picked;
}

/** Resolves the compiled markdown component for a slug. */
export async function loadPostBody(slug: string) {
  const loader = bodyModules[`/src/content/blog/${slug}.md`];
  if (!loader) return undefined;
  const mod = (await loader()) as { default: unknown };
  return mod.default;
}
