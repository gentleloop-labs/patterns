<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import BlogList from '$lib/components/BlogList.svelte';
  import { blogCategories, postsByDate, postsForPage, totalPages } from '$lib/data/blog';
  import Footer from '$lib/sections/Footer.svelte';
  import { links } from '$lib/data/links';
  import { PenLine, ArrowRight } from 'lucide-svelte';

  const pagePosts = postsForPage(1);

  const jsonLd = [
    {
      '@context': 'https://schema.org',
      '@type': 'Blog',
      name: 'The Patterns Blog',
      description:
        'Plain-language guides to OCD subtypes and ERP, plus personal essays from the person building Patterns - someone who lives with OCD.',
      url: `${links.site}blog`,
      publisher: { '@type': 'Organization', name: 'MaskedSyntax', url: links.maskedsyntax },
      blogPost: postsByDate.map((post) => ({
        '@type': 'BlogPosting',
        headline: post.title,
        description: post.description,
        datePublished: post.date,
        url: `${links.site}blog/${post.slug}`
      }))
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'Blog', item: `${links.site}blog` }
      ]
    }
  ];
</script>

<Seo
  title="The Patterns Blog - OCD, ERP, and living with the loop"
  description="Plain-language guides to OCD subtypes and ERP, plus honest essays from someone who lives with OCD and is building an app for it."
  path="blog"
  keywords="OCD blog, OCD subtypes, ERP therapy, intrusive thoughts, OCD recovery, living with OCD"
  {jsonLd}
/>

<article class="blog section-pad">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="head">
        <div class="icon-tile">
          <PenLine size={34} color="var(--accent)" strokeWidth={1.75} />
        </div>
        <p class="eyebrow">The Patterns blog</p>
        <h1 class="title serif">Notes from inside the loop.</h1>
        <p class="intro">
          Plain-language guides to how OCD works and how ERP treats it, alongside
          personal essays from the person building Patterns. Nothing here is medical
          advice - it is what the evidence says, and what it is like to live it.
        </p>
      </div>
    </AnimatedOnScroll>

    <nav class="categories" aria-label="Browse the OCD information library">
      {#each blogCategories as category}
        <a href="/learn/{category.slug}">
          <strong>{category.label}</strong>
          <span>{category.description}</span>
        </a>
      {/each}
    </nav>

    <div class="latest-head">
      <h2 class="serif">Latest articles</h2>
      <a href="/learn">Explore the full library <ArrowRight size={16} /></a>
    </div>

    <BlogList posts={pagePosts} />

    {#if totalPages > 1}
      <nav class="pager" aria-label="Blog pages">
        <span>Page 1 of {totalPages}</span>
        <a href="/blog/page/2">Older posts <ArrowRight size={16} /></a>
      </nav>
    {/if}

    <div class="back-wrap"><a href="/">← Back to Home</a></div>
  </ContentContainer>
</article>

<Footer />

<style>
  .blog {
    background: var(--surface);
  }

  .head {
    max-width: 720px;
    margin: 0 auto 48px;
    text-align: center;
  }

  .icon-tile {
    width: 80px;
    height: 80px;
    margin: 0 auto 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 20px;
    background: color-mix(in srgb, var(--accent) 10%, transparent);
  }

  .eyebrow {
    margin: 0 0 12px;
    font-size: 13px;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--accent);
  }

  .title {
    margin: 0;
    font-size: 46px;
    line-height: 1.1;
  }

  .intro {
    margin: 20px auto 0;
    max-width: 620px;
    font-size: 19px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  .categories {
    max-width: 980px;
    margin: 0 auto 56px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 14px;
  }

  .categories a {
    padding: 22px;
    border-radius: 16px;
    border: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
    background: var(--bg);
    transition: border-color 0.2s, transform 0.2s;
  }

  .categories a:hover {
    border-color: color-mix(in srgb, var(--accent) 45%, transparent);
    transform: translateY(-2px);
  }

  .categories strong,
  .categories span {
    display: block;
  }

  .categories strong {
    color: var(--text);
    font-size: 17px;
  }

  .categories span {
    margin-top: 8px;
    color: var(--text-secondary);
    font-size: 14px;
    line-height: 1.5;
  }

  .latest-head {
    max-width: 760px;
    margin: 0 auto 22px;
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 16px;
  }

  .latest-head h2 {
    margin: 0;
    font-size: 30px;
  }

  .latest-head a {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    color: var(--accent);
    font-size: 14px;
    font-weight: 600;
  }

  .pager {
    max-width: 760px;
    margin: 36px auto 0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    font-size: 14px;
    color: var(--text-secondary);
  }

  .pager a {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-weight: 600;
    color: var(--accent);
  }

  .back-wrap {
    text-align: center;
    margin-top: 48px;
  }

  .back-wrap a {
    font-weight: 600;
    color: var(--accent);
  }

  @media (max-width: 599px) {
    .title {
      font-size: 34px;
    }

    .intro {
      font-size: 16px;
    }

    .latest-head {
      align-items: flex-start;
      flex-direction: column;
    }
  }
</style>
