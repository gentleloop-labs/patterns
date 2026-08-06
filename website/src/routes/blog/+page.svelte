<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import BlogList from '$lib/components/BlogList.svelte';
  import { allTags, postsByDate, postsForPage, tagLabel, totalPages } from '$lib/data/blog';
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
        {#if allTags.length}
          <ul class="topics">
            {#each allTags as { tag }}
              <li><a href="/blog/tag/{tag}">{tagLabel(tag)}</a></li>
            {/each}
          </ul>
        {/if}
      </div>
    </AnimatedOnScroll>

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

  .topics {
    list-style: none;
    margin: 26px 0 0;
    padding: 0;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 8px;
  }

  .topics a {
    display: inline-block;
    padding: 6px 14px;
    border-radius: 999px;
    border: 1px solid color-mix(in srgb, var(--border) 60%, transparent);
    font-size: 13px;
    font-weight: 600;
    color: var(--text-secondary);
    transition: border-color 0.2s, color 0.2s;
  }

  .topics a:hover {
    border-color: color-mix(in srgb, var(--accent) 50%, transparent);
    color: var(--accent);
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
  }
</style>
