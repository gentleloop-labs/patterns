<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import MedicalDisclaimer from '$lib/components/MedicalDisclaimer.svelte';
  import { faqs, faqGroups, type FaqItem } from '$lib/data/faq';
  import { links } from '$lib/data/links';
  import { ArrowRight, LifeBuoy, MessageCircle, Plus } from 'lucide-svelte';

  let { items = faqs, variant = 'page' }: { items?: FaqItem[]; variant?: 'page' | 'home' } = $props();

  const groups = $derived(
    faqGroups
      .map((group) => ({ ...group, items: items.filter((item) => item.group === group.id) }))
      .filter((group) => group.items.length > 0)
  );
</script>

{#snippet question(item: FaqItem)}
  <details class="item">
    <summary>
      <span>{item.question}</span>
      <Plus class="chev" size={18} strokeWidth={2} aria-hidden="true" />
    </summary>
    <p>{item.answer}</p>
  </details>
{/snippet}

{#if variant === 'home'}
  <section
    id="home-faq"
    class="faq compact section-pad content-below-fold"
    aria-labelledby="home-faq-title"
  >
    <ContentContainer>
      <AnimatedOnScroll>
        <div class="head">
          <p class="eyebrow">Common questions</p>
          <h2 id="home-faq-title" class="title serif">A few things worth knowing.</h2>
          <p class="intro">
            Clear answers about privacy, the self-check, pricing, and where the app's limits are.
          </p>
        </div>

        <div class="list">
          {#each items as item (item.question)}
            {@render question(item)}
          {/each}
        </div>

        <div class="all-faq-wrap"><a href="/faq">Read every question and answer →</a></div>
      </AnimatedOnScroll>
    </ContentContainer>
  </section>
{:else}
  <section id="faq" class="faq page section-pad" aria-labelledby="faq-title">
    <ContentContainer>
      <div class="head">
        <p class="eyebrow">Frequently asked questions</p>
        <h1 id="faq-title" class="title serif">Questions, answered.</h1>
        <p class="intro">
          Common questions about OCD, ERP, and how Patterns works, and what it is not.
        </p>
        <p class="urgent">
          <LifeBuoy size={16} strokeWidth={1.75} aria-hidden="true" />
          <span>
            <strong>Need help right now?</strong> Patterns is not a crisis service.
            <a href="https://findahelpline.com/" target="_blank" rel="noopener noreferrer"
              >Find a helpline near you</a
            >.
          </span>
        </p>
      </div>

      <!-- Each topic is one full-width row: its title on the left, its
           questions on the right, so neither side is left empty. -->
      <div class="rows">
        {#each groups as group (group.id)}
          <section id="faq-{group.id}" class="row" aria-labelledby="faq-{group.id}-title">
            <header class="row-head">
              <h2 id="faq-{group.id}-title" class="serif">{group.title}</h2>
              <p>{group.blurb}</p>
            </header>
            <div class="row-body">
              {#each group.items as item (item.question)}
                {@render question(item)}
              {/each}
            </div>
          </section>
        {/each}

        <section class="row" aria-labelledby="faq-more-title">
          <header class="row-head">
            <h2 id="faq-more-title" class="serif">Still have a question?</h2>
          </header>
          <div class="row-body more">
            <p>
              Ask in the open on GitHub, where the answer can help the next person too. For OCD
              itself, the guides below go deeper.
            </p>
            <div class="more-links">
              <a href={links.issues} target="_blank" rel="noopener noreferrer" class="more-link">
                <MessageCircle size={16} strokeWidth={1.75} aria-hidden="true" /> Ask on GitHub
              </a>
              <a href="/ocd" class="more-link">Understanding OCD <ArrowRight size={15} aria-hidden="true" /></a>
              <a href="/erp" class="more-link">How ERP works <ArrowRight size={15} aria-hidden="true" /></a>
            </div>
          </div>
        </section>
      </div>

      <div class="disclaimer-wrap">
        <MedicalDisclaimer />
      </div>
    </ContentContainer>
  </section>
{/if}

<style>
  .faq {
    background: var(--bg);
  }

  .head {
    max-width: 680px;
    margin: 0 auto 40px;
    text-align: center;
  }

  .eyebrow {
    margin: 0 0 12px;
  }

  .title {
    margin: 0;
    font-size: clamp(34px, 5vw, 48px);
    line-height: 1.1;
  }

  .intro {
    margin: 18px auto 0;
    max-width: 560px;
    font-size: 18px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  /* Accordion rows, shared by the homepage list and the page's topic rows. */
  .item + .item {
    border-top: 1px solid var(--border);
  }

  .item summary {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    padding: 20px 0;
    cursor: pointer;
    list-style: none;
    font-size: 17px;
    font-weight: 600;
    line-height: 1.4;
    color: var(--text);
    transition: color 0.2s;
  }

  .item summary:hover {
    color: var(--accent);
  }

  .item summary:focus-visible {
    outline: 3px solid var(--accent);
    outline-offset: 4px;
    border-radius: 6px;
  }

  .item summary::-webkit-details-marker {
    display: none;
  }

  .item summary :global(.chev) {
    flex-shrink: 0;
    display: grid;
    place-items: center;
    color: var(--accent);
    transition: transform 0.25s ease;
  }

  .item[open] summary :global(.chev) {
    transform: rotate(45deg);
  }

  .item p {
    margin: 0;
    padding: 0 32px 22px 0;
    font-size: 16px;
    line-height: 1.7;
    color: color-mix(in srgb, var(--text) 76%, var(--bg));
  }

  /* Homepage variant */
  .list {
    max-width: 760px;
    margin: 0 auto;
    border-top: 1px solid var(--border);
    border-bottom: 1px solid var(--border);
  }

  .all-faq-wrap {
    margin-top: 32px;
    text-align: center;
  }

  .all-faq-wrap a {
    color: var(--accent);
    font-size: 14px;
    font-weight: 600;
  }

  /* Full page */
  .urgent {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    margin: 28px 0 0;
    padding: 10px 16px;
    border: 1px solid color-mix(in srgb, var(--accent) 35%, var(--border));
    border-radius: 999px;
    background: var(--surface);
    color: var(--text-secondary);
    font-size: 14px;
    line-height: 1.45;
    text-align: left;
  }

  .urgent :global(svg) {
    flex-shrink: 0;
    color: var(--accent);
  }

  .urgent strong {
    color: var(--text);
    font-weight: 600;
  }

  .urgent a {
    color: var(--text);
    text-decoration: underline;
    text-decoration-color: color-mix(in srgb, var(--accent) 70%, transparent);
    text-underline-offset: 3px;
  }

  .rows {
    max-width: 1080px;
    margin: 64px auto 0;
    border-bottom: 1px solid var(--border);
  }

  .row {
    display: grid;
    grid-template-columns: minmax(0, 1fr) minmax(0, 2fr);
    gap: 56px;
    padding: 44px 0;
    border-top: 1px solid var(--border);
    scroll-margin-top: 88px;
  }

  .row-head {
    position: sticky;
    top: 104px;
    align-self: start;
  }

  .row-head h2 {
    margin: 0;
    font-size: clamp(24px, 2.6vw, 30px);
    line-height: 1.15;
  }

  .row-head p {
    margin: 10px 0 0;
    max-width: 300px;
    color: var(--text-secondary);
    font-size: 15px;
    line-height: 1.55;
  }

  .row-body {
    margin-top: -14px;
  }

  .more {
    margin-top: 0;
  }

  .more p {
    margin: 4px 0 0;
    font-size: 16px;
    line-height: 1.65;
    color: color-mix(in srgb, var(--text) 76%, var(--bg));
  }

  .more-links {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 20px;
  }

  .more-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    min-height: 42px;
    padding: 0 16px;
    border: 1px solid var(--border);
    border-radius: 12px;
    background: var(--surface);
    color: var(--text);
    font-size: 14px;
    font-weight: 600;
    transition: border-color 0.2s;
  }

  .more-link:hover {
    border-color: color-mix(in srgb, var(--text) 30%, transparent);
  }

  .more-link :global(svg) {
    color: var(--accent);
  }

  .disclaimer-wrap {
    max-width: 1080px;
    margin: 48px auto 0;
  }

  @media (max-width: 799px) {
    .row {
      grid-template-columns: 1fr;
      gap: 16px;
      padding: 36px 0 28px;
    }

    .row-head {
      position: static;
    }

    .row-body {
      margin-top: 0;
    }

    .urgent {
      border-radius: var(--radius);
    }
  }

  @media (max-width: 599px) {
    .item summary {
      font-size: 16px;
    }

    .item p {
      padding-right: 0;
    }
  }
</style>
