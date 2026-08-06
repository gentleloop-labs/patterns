<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import BlogList from '$lib/components/BlogList.svelte';
  import { allTags, tagLabel } from '$lib/data/blog';
  import { links } from '$lib/data/links';
  import { ArrowLeft } from 'lucide-svelte';
  import type { PageData } from './$types';

  let { data }: { data: PageData } = $props();

  const others = $derived(allTags.filter(({ tag }) => tag !== data.tag));

  const jsonLd = $derived([
    {
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: `${data.label} - The Patterns Blog`,
      url: `${links.site}blog/tag/${data.tag}`,
      isPartOf: { '@type': 'Blog', name: 'The Patterns Blog', url: `${links.site}blog` },
      mainEntity: {
        '@type': 'ItemList',
        itemListElement: data.posts.map((post, i) => ({
          '@type': 'ListItem',
          position: i + 1,
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
        { '@type': 'ListItem', position: 2, name: 'Blog', item: `${links.site}blog` },
        {
          '@type': 'ListItem',
          position: 3,
          name: data.label,
          item: `${links.site}blog/tag/${data.tag}`
        }
      ]
    }
  ]);
</script>

<Seo
  title={`${data.label} - The Patterns Blog`}
  description={`Every Patterns post on ${data.label.toLowerCase()}: plain-language guides to OCD and ERP, written to be read at 2am.`}
  path={`blog/tag/${data.tag}`}
  keywords={`${data.label.toLowerCase()}, OCD, ERP, intrusive thoughts`}
  {jsonLd}
/>

<article class="blog section-pad">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="head">
        <a class="crumb" href="/blog"><ArrowLeft size={16} /> The Patterns blog</a>
        <p class="eyebrow">Topic</p>
        <h1 class="title serif">{data.label}</h1>
        <p class="intro">
          {data.posts.length}
          {data.posts.length === 1 ? 'post' : 'posts'} on {data.label.toLowerCase()}.
        </p>
      </div>
    </AnimatedOnScroll>

    <BlogList posts={data.posts} showTags={false} />

    {#if others.length}
      <nav class="topics" aria-label="Other topics">
        <p>Other topics</p>
        <ul>
          {#each others as { tag }}
            <li><a href="/blog/tag/{tag}">{tagLabel(tag)}</a></li>
          {/each}
        </ul>
      </nav>
    {/if}

    <div class="back-wrap"><a href="/blog">← All posts</a></div>
  </ContentContainer>
</article>

<style>
  .blog {
    background: var(--surface);
  }

  .head {
    max-width: 720px;
    margin: 0 auto 44px;
    text-align: center;
  }

  .crumb {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 14px;
    font-weight: 600;
    color: var(--accent);
  }

  .eyebrow {
    margin: 22px 0 10px;
    font-size: 13px;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--accent);
  }

  .title {
    margin: 0;
    font-size: 44px;
    line-height: 1.1;
  }

  .intro {
    margin: 14px 0 0;
    font-size: 16px;
    color: var(--text-secondary);
  }

  .topics {
    max-width: 760px;
    margin: 48px auto 0;
    text-align: center;
  }

  .topics p {
    margin: 0 0 14px;
    font-size: 13px;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--text-secondary);
  }

  .topics ul {
    list-style: none;
    margin: 0;
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
      font-size: 32px;
    }
  }
</style>
