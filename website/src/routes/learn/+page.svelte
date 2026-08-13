<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import Footer from '$lib/sections/Footer.svelte';
  import { blogCategories, postsByCategory } from '$lib/data/blog';
  import { links } from '$lib/data/links';
  import { ArrowRight, BookOpen } from 'lucide-svelte';

  const jsonLd = [
    {
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      name: 'OCD Information Library',
      description:
        'Evidence-led OCD guides and lived-experience essays organized around recognizing OCD, themes, treatment, daily life, and personal stories.',
      url: links.library,
      isPartOf: { '@type': 'WebSite', name: 'Patterns', url: links.site },
      mainEntity: {
        '@type': 'ItemList',
        itemListElement: blogCategories.map((category, index) => ({
          '@type': 'ListItem',
          position: index + 1,
          name: category.label,
          url: `${links.library}/${category.slug}`
        }))
      }
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'OCD information library', item: links.library }
      ]
    }
  ];
</script>

<Seo
  title="OCD Information Library - Symptoms, Themes, Treatment & Recovery | Patterns"
  description="Explore clear, carefully sourced guides to recognizing OCD, common themes, ERP treatment, and daily life, alongside honest lived-experience essays."
  path="learn"
  keywords="OCD information, OCD symptoms, OCD themes, ERP treatment, living with OCD, intrusive thoughts"
  {jsonLd}
/>

<article class="library section-pad">
  <ContentContainer>
    <AnimatedOnScroll>
      <header class="head">
        <div class="icon-tile"><BookOpen size={34} color="var(--accent)" strokeWidth={1.75} /></div>
        <p class="eyebrow">Patterns OCD information library</p>
        <h1 class="serif">Understand the pattern, one question at a time.</h1>
        <p>
          Start with what you are trying to understand. Evidence-led guides explain the clinical
          ideas in plain language; personal essays are clearly marked as lived experience.
        </p>
      </header>
    </AnimatedOnScroll>

    <div class="categories">
      {#each blogCategories as category}
        {@const categoryPosts = postsByCategory(category.slug)}
        <section class="category-card">
          <div class="card-head">
            <div>
              <p>{categoryPosts.length} {categoryPosts.length === 1 ? 'article' : 'articles'}</p>
              <h2 class="serif">{category.label}</h2>
            </div>
            <a class="arrow" href="/learn/{category.slug}" aria-label="Explore {category.label}">
              <ArrowRight size={20} />
            </a>
          </div>
          <p class="description">{category.description}</p>
          {#if categoryPosts.length}
            <ul>
              {#each categoryPosts.slice(0, 3) as post}
                <li><a href="/blog/{post.slug}">{post.title}</a></li>
              {/each}
            </ul>
          {:else}
            <p class="empty">Guides for this section are in editorial review.</p>
          {/if}
          <a class="explore" href="/learn/{category.slug}">
            Explore {category.label} <ArrowRight size={16} />
          </a>
        </section>
      {/each}
    </div>

    <aside class="trust">
      <h2 class="serif">Who writes this?</h2>
      <p>
        Patterns is written by <a href="/about/aftaab-siddiqui">Aftaab Siddiqui</a>, who lives
        with OCD and builds the app. Evidence-led guides cite their sources and follow a published
        <a href="/editorial-policy">editorial policy</a>. This library is educational and does
        not diagnose or replace professional care.
      </p>
    </aside>
  </ContentContainer>
</article>

<Footer />

<style>
  .library {
    background: var(--surface);
  }

  .head {
    max-width: 760px;
    margin: 0 auto 56px;
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

  .eyebrow,
  .category-card .card-head p {
    margin: 0 0 10px;
    color: var(--accent);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  .head h1 {
    margin: 0;
    font-size: 48px;
    line-height: 1.08;
  }

  .head > p:last-child {
    max-width: 650px;
    margin: 20px auto 0;
    color: var(--text-secondary);
    font-size: 18px;
    line-height: 1.65;
  }

  .categories {
    max-width: 1040px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 18px;
  }

  .category-card {
    padding: 28px;
    border: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
    border-radius: 20px;
    background: var(--bg);
  }

  .category-card:last-child {
    grid-column: 1 / -1;
  }

  .card-head {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 20px;
  }

  .card-head h2 {
    margin: 0;
    font-size: 27px;
  }

  .arrow {
    width: 38px;
    height: 38px;
    flex: 0 0 auto;
    display: grid;
    place-items: center;
    border-radius: 50%;
    background: color-mix(in srgb, var(--accent) 11%, transparent);
    color: var(--accent);
  }

  .description {
    margin: 14px 0 0;
    color: var(--text-secondary);
    line-height: 1.55;
  }

  .category-card ul {
    margin: 22px 0 0;
    padding: 18px 0 0;
    list-style: none;
    border-top: 1px solid color-mix(in srgb, var(--border) 40%, transparent);
  }

  .category-card li + li {
    margin-top: 10px;
  }

  .category-card li a {
    color: var(--text);
    font-size: 14px;
    line-height: 1.45;
  }

  .category-card li a:hover {
    color: var(--accent);
  }

  .explore {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    margin-top: 22px;
    color: var(--accent);
    font-size: 14px;
    font-weight: 700;
  }

  .empty {
    margin: 22px 0 0;
    color: var(--text-secondary);
    font-size: 14px;
  }

  .trust {
    max-width: 800px;
    margin: 56px auto 0;
    padding: 28px;
    border-radius: 18px;
    background: color-mix(in srgb, var(--accent) 7%, transparent);
    text-align: center;
  }

  .trust h2 {
    margin: 0;
    font-size: 27px;
  }

  .trust p {
    margin: 12px auto 0;
    max-width: 680px;
    color: var(--text-secondary);
    line-height: 1.65;
  }

  .trust a {
    color: var(--accent);
    text-decoration: underline;
    text-underline-offset: 3px;
  }

  @media (max-width: 699px) {
    .head h1 {
      font-size: 34px;
    }

    .head > p:last-child {
      font-size: 16px;
    }

    .categories {
      grid-template-columns: 1fr;
    }

    .category-card:last-child {
      grid-column: auto;
    }
  }
</style>
