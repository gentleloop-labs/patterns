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

export const blogCategories = [
  {
    slug: 'recognizing-ocd',
    label: 'Recognizing OCD',
    description:
      'Understand intrusive thoughts, compulsions, avoidance, and the patterns that can make OCD difficult to recognize.',
    intro:
      'Start here if you are trying to understand whether a recurring thought-and-response pattern might be OCD. These guides explain common signs without trying to diagnose you.'
  },
  {
    slug: 'ocd-themes',
    label: 'OCD Themes',
    description:
      'Plain-language guides to the many subjects OCD can attach to, from contamination and checking to relationships and morality.',
    intro:
      'OCD can attach to almost anything a person values. These guides focus on the shared cycle underneath different themes, including the compulsions that are easy to miss.'
  },
  {
    slug: 'treatment-erp',
    label: 'Treatment & ERP',
    description:
      'Learn how exposure and response prevention works, what its tools are for, and how treatment is structured.',
    intro:
      'Exposure and response prevention is the first-line psychological treatment for OCD. These guides explain its principles and practical tools, while leaving treatment decisions to you and a qualified professional.'
  },
  {
    slug: 'living-with-ocd',
    label: 'Living With OCD',
    description:
      'Evidence-led guidance for navigating recovery, setbacks, relationships, work, and ordinary life with OCD.',
    intro:
      'OCD is experienced between appointments and outside exercises. This collection focuses on the everyday parts of recovery and the situations that can make the loop louder.'
  },
  {
    slug: 'personal-stories',
    label: 'Personal Stories',
    description:
      'First-person essays from the person building Patterns about OCD, ERP, privacy, and life between therapy sessions.',
    intro:
      'These essays are lived experience, not clinical guidance. They explain why Patterns exists and what recovery tools have felt like from inside the loop.'
  }
] as const;

export type BlogCategory = (typeof blogCategories)[number]['slug'];
export type BlogContentType = 'evidence-guide' | 'personal-essay';

export function getBlogCategory(slug: string) {
  return blogCategories.find((category) => category.slug === slug);
}

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
  /** Reader-facing information-library category. */
  category: BlogCategory;
  /** Separates sourced explainers from first-person essays. */
  contentType: BlogContentType;
  /** Drafts stay in the content directory but are excluded from every public route and feed. */
  draft: boolean;
  /** Comma-separated meta keywords for the post page. */
  keywords?: string;
  /** Drives FAQPage structured data when present. */
  faq?: BlogFaq[];
  /** Manual related-post slugs. Falls back to tag overlap when omitted. */
  related?: string[];
};

/** Frontmatter as authored - most fields are optional and filled in below. */
type RawFrontmatter = Partial<Omit<BlogPost, 'slug'>>;

/**
 * Import each mdsvex module as a namespace, then read its generated metadata
 * export below. A named `import: 'metadata'` works in production builds but
 * Bun-triggered Vite dependency scans can inspect the raw Markdown before
 * mdsvex transforms it and incorrectly report that the export is missing.
 */
const metaModules = import.meta.glob<{ metadata: RawFrontmatter }>('/src/content/blog/*.md', {
  eager: true
});

/** Lazily loaded post bodies, so the index does not bundle every post. */
const bodyModules = import.meta.glob('/src/content/blog/*.md');

function slugFromPath(path: string): string {
  return path.slice(path.lastIndexOf('/') + 1).replace(/\.md$/, '');
}

function toPost(path: string, meta: RawFrontmatter): BlogPost {
  const slug = slugFromPath(path);

  if (
    !meta?.title ||
    !meta?.description ||
    !meta?.date ||
    !meta?.category ||
    !meta?.contentType
  ) {
    throw new Error(
      `Blog post "${slug}" is missing required frontmatter (title, description, date, category, contentType).`
    );
  }

  if (!getBlogCategory(meta.category)) {
    throw new Error(`Blog post "${slug}" has unknown category "${meta.category}".`);
  }
  if (!['evidence-guide', 'personal-essay'].includes(meta.contentType)) {
    throw new Error(`Blog post "${slug}" has unknown contentType "${meta.contentType}".`);
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
    category: meta.category,
    contentType: meta.contentType,
    draft: meta.draft ?? false,
    keywords: meta.keywords,
    faq: meta.faq,
    related: meta.related
  };
}

export const authoredPosts: BlogPost[] = Object.entries(metaModules).map(([path, module]) =>
  toPost(path, module.metadata)
);

/** Only approved content is visible to routes, feeds, related posts, and the sitemap. */
export const posts: BlogPost[] = authoredPosts.filter((post) => !post.draft);

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

export function postsByCategory(category: BlogCategory): BlogPost[] {
  return postsByDate.filter((post) => post.category === category);
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
