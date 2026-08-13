<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import MedicalDisclaimer from '$lib/components/MedicalDisclaimer.svelte';
  import StoreLink from '$lib/components/StoreLink.svelte';
  import { getBlogCategory, tagLabel } from '$lib/data/blog';
  import { links } from '$lib/data/links';
  import { site } from '$lib/data/site';
  import { ArrowRight, ArrowLeft } from 'lucide-svelte';
  import BrandIcon from '$lib/components/BrandIcon.svelte';
  import Footer from '$lib/sections/Footer.svelte';
  import { siAppstore, siGoogleplay } from 'simple-icons';
  import type { PageData } from './$types';

  let { data }: { data: PageData } = $props();
  const post = $derived(data.post);
  const related = $derived(data.related);
  const Body = $derived(data.body as unknown as import('svelte').Component);

  const dateFmt = new Intl.DateTimeFormat('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

  const jsonLd = $derived([
    {
      '@context': 'https://schema.org',
      '@type': 'BlogPosting',
      headline: post.title,
      description: post.description,
      datePublished: post.date,
      dateModified: post.updated,
      url: `${links.site}blog/${post.slug}`,
      image: [site.ogImage],
      keywords: post.tags.join(', '),
      articleSection: getBlogCategory(post.category)?.label,
      author: { '@type': 'Person', name: site.author.name, url: site.author.url },
      publisher: {
        '@type': 'Organization',
        name: 'MaskedSyntax',
        url: links.maskedsyntax,
        logo: {
          '@type': 'ImageObject',
          url: site.logoUrl,
          width: site.logoWidth,
          height: site.logoHeight
        }
      },
      mainEntityOfPage: { '@type': 'WebPage', '@id': `${links.site}blog/${post.slug}` },
      isPartOf: { '@type': 'Blog', name: 'The Patterns Blog', url: `${links.site}blog` }
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'Blog', item: `${links.site}blog` },
        { '@type': 'ListItem', position: 3, name: post.title, item: `${links.site}blog/${post.slug}` }
      ]
    },
    // Only emit FAQPage when the post actually renders the questions below.
    ...(post.faq?.length
      ? [
          {
            '@context': 'https://schema.org',
            '@type': 'FAQPage',
            mainEntity: post.faq.map((item) => ({
              '@type': 'Question',
              name: item.q,
              acceptedAnswer: { '@type': 'Answer', text: item.a }
            }))
          }
        ]
      : [])
  ]);
</script>

<Seo
  title={`${post.title} | The Patterns Blog`}
  description={post.description}
  path={`blog/${post.slug}`}
  keywords={post.keywords}
  ogType="article"
  article={{ publishedTime: post.date, modifiedTime: post.updated, author: site.author.name }}
  {jsonLd}
/>

<article class="post section-pad">
  <ContentContainer>
    <AnimatedOnScroll>
      <a class="crumb" href="/blog"><ArrowLeft size={16} /> The Patterns blog</a>
      <header class="post-head">
        <a class="category" href="/learn/{post.category}">{getBlogCategory(post.category)?.label}</a>
        <div class="meta">
          <time datetime={post.date}>{dateFmt.format(new Date(post.date))}</time>
          <span aria-hidden="true">·</span>
          <span>{post.readingMinutes} min read</span>
        </div>
        <h1 class="title serif">{post.title}</h1>
        <p class="byline">
          Written by <a href="/about/aftaab-siddiqui">Aftaab Siddiqui</a>, the person building
          Patterns. <a href="/editorial-policy">How this content is made</a>.
        </p>
        {#if post.tags.length}
          <ul class="tags">
            {#each post.tags as tag}
              <li><a href="/blog/tag/{tag}">{tagLabel(tag)}</a></li>
            {/each}
          </ul>
        {/if}
      </header>

      <div class="prose reading">
        <Body />
      </div>

      {#if post.faq?.length}
        <section class="faq" aria-labelledby="faq-heading">
          <h2 id="faq-heading">Common questions</h2>
          {#each post.faq as item}
            <div class="faq-item">
              <h3>{item.q}</h3>
              <p>{item.a}</p>
            </div>
          {/each}
        </section>
      {/if}

      <div class="disclaimer-wrap">
        <MedicalDisclaimer />
      </div>

      <section class="cta" aria-labelledby="cta-heading">
        <h2 id="cta-heading">Track the loop in a place that stays private</h2>
        <p>
          Patterns is a free OCD journal and ERP companion. No account, no cloud sync,
          nothing leaves your device.
        </p>
        <div class="cta-buttons">
          <StoreLink store="app_store" placement="body" class="store-btn">
            <BrandIcon icon={siAppstore} size={18} color="#000" /> App Store
          </StoreLink>
          <StoreLink store="play_store" placement="body" class="store-btn">
            <BrandIcon icon={siGoogleplay} size={18} color="#000" /> Google Play
          </StoreLink>
        </div>
        <a class="cta-link" href="/#download">Get Patterns for mobile</a>
      </section>

      {#if related.length}
        <nav class="related" aria-label="More posts">
          {#each related as p}
            <a href="/blog/{p.slug}" class="related-card">
              <span>{p.title}</span>
              <ArrowRight size={18} />
            </a>
          {/each}
        </nav>
      {/if}

      <div class="back-wrap"><a href="/blog">← All posts</a></div>
    </AnimatedOnScroll>
  </ContentContainer>
</article>

<Footer />

<style>
  .post {
    background: var(--surface);
  }

  .crumb {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 14px;
    font-weight: 600;
    color: var(--accent);
  }

  .post-head {
    max-width: 720px;
    margin: 24px auto 40px;
    text-align: center;
  }

  .category {
    display: inline-block;
    margin-bottom: 12px;
    color: var(--accent);
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 0.06em;
    text-transform: uppercase;
  }

  .meta {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    font-size: 13px;
    color: var(--text-secondary);
  }

  .title {
    margin: 14px 0 0;
    font-size: 44px;
    line-height: 1.12;
  }

  .byline {
    margin: 16px 0 0;
    font-size: 15px;
    color: var(--text-secondary);
  }

  .byline a {
    color: var(--accent);
    text-decoration: underline;
    text-underline-offset: 3px;
  }

  .tags {
    list-style: none;
    margin: 18px 0 0;
    padding: 0;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 8px;
  }

  .tags a {
    display: inline-block;
    padding: 5px 12px;
    border-radius: 999px;
    border: 1px solid color-mix(in srgb, var(--border) 60%, transparent);
    font-size: 13px;
    font-weight: 600;
    color: var(--text-secondary);
    transition: border-color 0.2s, color 0.2s;
  }

  .tags a:hover {
    border-color: color-mix(in srgb, var(--accent) 50%, transparent);
    color: var(--accent);
  }

  .prose {
    max-width: 720px;
    margin: 0 auto;
    font-size: 17px;
    color: var(--text-secondary);
  }

  .prose :global(h2) {
    margin: 48px 0 16px;
    font-size: 28px;
    line-height: 1.2;
    color: var(--text);
  }

  .prose :global(h3) {
    margin: 32px 0 12px;
    font-size: 21px;
    line-height: 1.3;
    color: var(--text);
  }

  .prose :global(p) {
    margin: 0 0 18px;
  }

  .prose :global(strong) {
    color: var(--text);
    font-weight: 600;
  }

  .prose :global(em) {
    color: var(--text);
  }

  .prose :global(a) {
    color: var(--accent);
    text-decoration: underline;
    text-underline-offset: 3px;
  }

  .prose :global(ul),
  .prose :global(ol) {
    margin: 0 0 18px;
    padding-left: 24px;
  }

  .prose :global(li) {
    margin: 0 0 10px;
    line-height: 1.65;
  }

  .prose :global(li)::marker {
    color: var(--accent);
  }

  .prose :global(.lead) {
    font-size: 20px;
    line-height: 1.6;
    color: var(--text);
  }

  .prose :global(blockquote) {
    margin: 28px 0;
    padding: 4px 0 4px 22px;
    border-left: 3px solid var(--accent);
    font-size: 19px;
    line-height: 1.55;
    font-style: italic;
    color: var(--text);
  }

  .prose :global(hr) {
    margin: 40px 0;
    border: 0;
    border-top: 1px solid color-mix(in srgb, var(--border) 60%, transparent);
  }

  .prose :global(code) {
    padding: 2px 6px;
    border-radius: 6px;
    background: color-mix(in srgb, var(--border) 35%, transparent);
    font-size: 0.92em;
  }

  /* Tables are wide; let them scroll rather than break the page. */
  .prose :global(.table-wrap) {
    overflow-x: auto;
    margin: 0 0 24px;
  }

  .prose :global(table) {
    width: 100%;
    border-collapse: collapse;
    font-size: 15px;
  }

  .prose :global(th),
  .prose :global(td) {
    padding: 10px 14px;
    text-align: left;
    border-bottom: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
    vertical-align: top;
  }

  .prose :global(th) {
    font-weight: 600;
    color: var(--text);
    white-space: nowrap;
  }

  .faq {
    max-width: 720px;
    margin: 56px auto 0;
    padding-top: 8px;
    border-top: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
  }

  .faq h2 {
    margin: 32px 0 20px;
    font-size: 28px;
    line-height: 1.2;
    color: var(--text);
  }

  .faq-item {
    margin: 0 0 24px;
  }

  .faq-item h3 {
    margin: 0 0 8px;
    font-size: 18px;
    line-height: 1.35;
    color: var(--text);
  }

  .faq-item p {
    margin: 0;
    font-size: 16px;
    line-height: 1.65;
    color: var(--text-secondary);
  }

  .disclaimer-wrap {
    max-width: 720px;
    margin: 48px auto 0;
  }

  .cta {
    max-width: 720px;
    margin: 24px auto 0;
    padding: 28px;
    border-radius: 18px;
    border: 1px solid color-mix(in srgb, var(--border) 50%, transparent);
    background: var(--bg);
    text-align: center;
  }

  .cta h2 {
    margin: 0;
    font-size: 22px;
    line-height: 1.3;
    color: var(--text);
  }

  .cta p {
    margin: 10px auto 0;
    max-width: 460px;
    font-size: 15px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  .cta-buttons {
    margin: 20px 0 0;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 12px;
  }

  .cta-buttons :global(.store-btn) {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 11px 20px;
    border-radius: 12px;
    background: var(--accent);
    color: #000;
    font-size: 15px;
    font-weight: 600;
    transition: opacity 0.2s;
  }

  .cta-buttons :global(.store-btn:hover) {
    opacity: 0.88;
  }

  .cta-link {
    display: inline-block;
    margin-top: 14px;
    font-size: 14px;
    font-weight: 600;
    color: var(--accent);
  }

  .related {
    max-width: 720px;
    margin: 32px auto 0;
    display: grid;
    gap: 12px;
    grid-template-columns: 1fr;
  }

  .related-card {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding: 18px 20px;
    border-radius: 14px;
    border: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
    font-weight: 600;
    color: var(--text);
    transition: border-color 0.2s, color 0.2s;
  }

  .related-card:hover {
    border-color: color-mix(in srgb, var(--accent) 55%, transparent);
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

  @media (min-width: 600px) {
    .related {
      grid-template-columns: repeat(2, 1fr);
    }
  }

  @media (max-width: 599px) {
    .title {
      font-size: 32px;
    }

    .prose {
      font-size: 16px;
    }

    .prose :global(h2) {
      font-size: 24px;
    }
  }
</style>
