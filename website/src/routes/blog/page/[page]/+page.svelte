<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import BlogList from '$lib/components/BlogList.svelte';
  import { links } from '$lib/data/links';
  import { ArrowLeft, ArrowRight } from 'lucide-svelte';
  import type { PageData } from './$types';

  let { data }: { data: PageData } = $props();

  const prevHref = $derived(data.page === 2 ? '/blog' : `/blog/page/${data.page - 1}`);

  const jsonLd = $derived([
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'Blog', item: `${links.site}blog` },
        {
          '@type': 'ListItem',
          position: 3,
          name: `Page ${data.page}`,
          item: `${links.site}blog/page/${data.page}`
        }
      ]
    }
  ]);
</script>

<Seo
  title={`The Patterns Blog - Page ${data.page}`}
  description={`Older posts from the Patterns blog on OCD, ERP, and living with the loop. Page ${data.page} of ${data.totalPages}.`}
  path={`blog/page/${data.page}`}
  {jsonLd}
/>

<article class="blog section-pad">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="head">
        <a class="crumb" href="/blog"><ArrowLeft size={16} /> The Patterns blog</a>
        <h1 class="title serif">Older posts</h1>
        <p class="intro">Page {data.page} of {data.totalPages}</p>
      </div>
    </AnimatedOnScroll>

    <BlogList posts={data.posts} />

    <nav class="pager" aria-label="Blog pages">
      <a href={prevHref}><ArrowLeft size={16} /> Newer posts</a>
      {#if data.page < data.totalPages}
        <a href="/blog/page/{data.page + 1}">Older posts <ArrowRight size={16} /></a>
      {/if}
    </nav>
  </ContentContainer>
</article>

<style>
  .blog {
    background: var(--surface);
  }

  .head {
    max-width: 720px;
    margin: 0 auto 40px;
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

  .title {
    margin: 18px 0 0;
    font-size: 40px;
    line-height: 1.1;
  }

  .intro {
    margin: 12px 0 0;
    font-size: 15px;
    color: var(--text-secondary);
  }

  .pager {
    max-width: 760px;
    margin: 36px auto 0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
  }

  .pager a {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 14px;
    font-weight: 600;
    color: var(--accent);
  }

  @media (max-width: 599px) {
    .title {
      font-size: 30px;
    }
  }
</style>
