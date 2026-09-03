<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { getBlogCategory, postsByDate } from '$lib/data/blog';
  import { ArrowRight } from 'lucide-svelte';

  const latestPosts = postsByDate.slice(0, 3);
  const dateFmt = new Intl.DateTimeFormat('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
</script>

<section id="latest-articles" class="articles section-pad content-below-fold" aria-labelledby="articles-title">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="head">
        <div>
          <span class="eyebrow">LATEST FROM THE LIBRARY</span>
          <h2 id="articles-title" class="serif">Understand the loop in plain language.</h2>
        </div>
        <a href="/blog">See all articles <ArrowRight size={16} /></a>
      </div>
    </AnimatedOnScroll>

    <div class="grid">
      {#each latestPosts as post, index (post.slug)}
        <AnimatedOnScroll delay={80 + index * 55}>
          <article>
            <div class="meta">
              <a href="/learn/{post.category}">{getBlogCategory(post.category)?.label}</a>
              <span aria-hidden="true">·</span>
              <time datetime={post.date}>{dateFmt.format(new Date(post.date))}</time>
              <span aria-hidden="true">·</span>
              <span>{post.readingMinutes} min</span>
            </div>
            <h3><a href="/blog/{post.slug}">{post.title}</a></h3>
            <p>{post.excerpt}</p>
            <a class="read" href="/blog/{post.slug}" aria-label="Read {post.title}">
              Read article <ArrowRight size={15} />
            </a>
          </article>
        </AnimatedOnScroll>
      {/each}
    </div>
  </ContentContainer>
</section>

<style>
  .articles {
    background: var(--surface);
  }

  .head {
    display: flex;
    align-items: end;
    justify-content: space-between;
    gap: 24px;
    margin-bottom: 42px;
  }

  .eyebrow {
    color: var(--accent);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.1em;
  }

  h2 {
    max-width: 680px;
    margin: 15px 0 0;
    font-size: 43px;
    line-height: 1.12;
  }

  .head > a,
  .read {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    color: var(--accent);
    font-size: 14px;
    font-weight: 700;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 18px;
  }

  article {
    height: 100%;
    padding: 26px;
    border: 1px solid color-mix(in srgb, var(--border) 65%, transparent);
    border-radius: 18px;
    background: var(--bg);
  }

  .meta {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    color: var(--text-secondary);
    font-size: 11px;
  }

  .meta a {
    color: var(--accent);
    font-weight: 700;
  }

  h3 {
    margin: 15px 0 0;
    font-size: 22px;
    line-height: 1.25;
  }

  h3 a:hover {
    color: var(--accent);
  }

  article p {
    margin: 12px 0 0;
    color: var(--text-secondary);
    font-size: 14px;
    line-height: 1.6;
  }

  .read {
    margin-top: 20px;
  }

  @media (max-width: 900px) {
    .grid {
      grid-template-columns: 1fr;
    }
  }

  @media (max-width: 599px) {
    .head {
      align-items: flex-start;
      flex-direction: column;
    }

    h2 {
      font-size: 32px;
    }
  }
</style>
