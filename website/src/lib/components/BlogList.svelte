<script lang="ts">
  import { getBlogCategory, tagLabel, type BlogPost } from '$lib/data/blog';
  import { ArrowRight } from 'lucide-svelte';

  /** Shared card list for the blog index, paginated pages, and tag hubs. */
  let { posts, showTags = true }: { posts: BlogPost[]; showTags?: boolean } = $props();

  const dateFmt = new Intl.DateTimeFormat('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
</script>

<div class="list">
  <!-- Deliberately not wrapped in AnimatedOnScroll: an index is for scanning,
       and cards that fade in on scroll make the list feel unreliable. -->
  {#each posts as post (post.slug)}
    <article class="post-card">
      <div class="meta">
        <a class="category" href="/learn/{post.category}">{getBlogCategory(post.category)?.label}</a>
        <span aria-hidden="true">·</span>
        <time datetime={post.date}>{dateFmt.format(new Date(post.date))}</time>
        <span aria-hidden="true">·</span>
        <span>{post.readingMinutes} min read</span>
      </div>
      <h2><a href="/blog/{post.slug}">{post.title}</a></h2>
      <p>{post.excerpt}</p>
      {#if showTags && post.tags.length}
        <ul class="tags">
          {#each post.tags.slice(0, 3) as tag}
            <li><a href="/blog/tag/{tag}">{tagLabel(tag)}</a></li>
          {/each}
        </ul>
      {/if}
      <a class="read" href="/blog/{post.slug}" aria-label="Read {post.title}">
        Read post <ArrowRight size={16} />
      </a>
    </article>
  {/each}
</div>

<style>
  .list {
    max-width: var(--blog-content-width, 760px);
    margin: 0 auto;
    display: grid;
    gap: 20px;
  }

  .post-card {
    display: block;
    padding: 28px;
    border-radius: 18px;
    border: 1px solid color-mix(in srgb, var(--border) 50%, transparent);
    background: var(--bg);
    transition: border-color 0.25s, transform 0.25s;
  }

  .post-card:hover {
    border-color: color-mix(in srgb, var(--accent) 40%, transparent);
    transform: translateY(-2px);
  }

  .meta {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    color: var(--text-secondary);
  }

  .category {
    color: var(--accent);
    font-weight: 600;
  }

  .post-card h2 {
    margin: 12px 0 0;
    font-size: 24px;
    line-height: 1.25;
  }

  .post-card h2 a {
    color: var(--text);
  }

  .post-card h2 a:hover {
    color: var(--accent);
  }

  .post-card p {
    margin: 10px 0 0;
    font-size: 16px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  .tags {
    list-style: none;
    margin: 16px 0 0;
    padding: 0;
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
  }

  .tags a {
    display: inline-block;
    padding: 4px 11px;
    border-radius: 999px;
    border: 1px solid color-mix(in srgb, var(--border) 60%, transparent);
    font-size: 12px;
    font-weight: 600;
    color: var(--text-secondary);
    transition: border-color 0.2s, color 0.2s;
  }

  .tags a:hover {
    border-color: color-mix(in srgb, var(--accent) 50%, transparent);
    color: var(--accent);
  }

  .read {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    margin-top: 18px;
    font-size: 14px;
    font-weight: 600;
    color: var(--accent);
  }

  @media (max-width: 599px) {
    .post-card h2 {
      font-size: 20px;
    }
  }
</style>
