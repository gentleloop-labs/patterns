<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import BlogList from '$lib/components/BlogList.svelte';
  import Footer from '$lib/sections/Footer.svelte';
  import { blogCategories } from '$lib/data/blog';
  import { links } from '$lib/data/links';
  import { ArrowLeft } from 'lucide-svelte';
  import type { PageData } from './$types';

  let { data }: { data: PageData } = $props();

  const otherCategories = $derived(
    blogCategories.filter((category) => category.slug !== data.category.slug)
  );

  const jsonLd = $derived([
    {
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: `${data.category.label} - Patterns OCD Information Library`,
      description: data.category.description,
      url: `${links.library}/${data.category.slug}`,
      isPartOf: { '@type': 'CollectionPage', name: 'OCD Information Library', url: links.library },
      mainEntity: {
        '@type': 'ItemList',
        itemListElement: data.posts.map((post, index) => ({
          '@type': 'ListItem',
          position: index + 1,
          name: post.title,
          url: `${links.site}blog/${post.slug}`
        }))
      }
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'OCD information library', item: links.library },
        {
          '@type': 'ListItem',
          position: 3,
          name: data.category.label,
          item: `${links.library}/${data.category.slug}`
        }
      ]
    }
  ]);
</script>

<Seo
  title={`${data.category.label} - OCD Information Library | Patterns`}
  description={data.category.description}
  path={`learn/${data.category.slug}`}
  keywords={`${data.category.label}, OCD information, OCD help, Patterns OCD`}
  {jsonLd}
/>

<article class="category section-pad">
  <ContentContainer>
    <header class="head">
      <a class="crumb" href="/learn"><ArrowLeft size={16} /> OCD information library</a>
      <p class="eyebrow">Explore by category</p>
      <h1 class="serif">{data.category.label}</h1>
      <p class="intro">{data.category.intro}</p>
      <p class="count">{data.posts.length} {data.posts.length === 1 ? 'article' : 'articles'}</p>
    </header>

    {#if data.posts.length}
      <BlogList posts={data.posts} showTags={false} />
    {:else}
      <div class="empty">
        <p>The first guides in this category are in editorial review.</p>
        <a href="/blog">Read the latest Patterns articles</a>
      </div>
    {/if}

    <nav class="other" aria-label="Other library categories">
      <p>Explore another category</p>
      <ul>
        {#each otherCategories as category}
          <li><a href="/learn/{category.slug}">{category.label}</a></li>
        {/each}
      </ul>
    </nav>
  </ContentContainer>
</article>

<Footer />

<style>
  .category {
    background: var(--surface);
  }

  .head {
    max-width: 720px;
    margin: 0 auto 48px;
    text-align: center;
  }

  .crumb {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    color: var(--accent);
    font-size: 14px;
    font-weight: 600;
  }

  .eyebrow {
    margin: 24px 0 10px;
    color: var(--accent);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  h1 {
    margin: 0;
    font-size: 46px;
    line-height: 1.1;
  }

  .intro {
    margin: 18px auto 0;
    color: var(--text-secondary);
    font-size: 18px;
    line-height: 1.65;
  }

  .count {
    margin: 16px 0 0;
    color: var(--text-secondary);
    font-size: 13px;
  }

  .empty {
    max-width: 720px;
    margin: 0 auto;
    padding: 36px;
    border: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
    border-radius: 18px;
    text-align: center;
  }

  .empty p {
    color: var(--text-secondary);
  }

  .empty a {
    color: var(--accent);
    font-weight: 600;
  }

  .other {
    max-width: 760px;
    margin: 52px auto 0;
    text-align: center;
  }

  .other > p {
    margin: 0 0 14px;
    color: var(--text-secondary);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  .other ul {
    margin: 0;
    padding: 0;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 8px;
    list-style: none;
  }

  .other a {
    display: inline-block;
    padding: 7px 13px;
    border: 1px solid color-mix(in srgb, var(--border) 60%, transparent);
    border-radius: 999px;
    color: var(--text-secondary);
    font-size: 13px;
    font-weight: 600;
  }

  .other a:hover {
    border-color: color-mix(in srgb, var(--accent) 45%, transparent);
    color: var(--accent);
  }

  @media (max-width: 599px) {
    h1 {
      font-size: 34px;
    }

    .intro {
      font-size: 16px;
    }
  }
</style>
