<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { proPricing } from '$lib/data/pricing';
  import { Check } from 'lucide-svelte';

  // Mirrors the pricing answer in faq.ts; keep the two in step.
  const free = [
    'Private daily journal',
    'OCD log with 0–10 distress ratings',
    'Y-BOCS self-check',
    'Guided ERP and the compulsion delay tool',
    'Emergency toolkit and coping library'
  ];

  const pro = [
    'Exposure ladders and exposure materials',
    'Structured ERP programs',
    'Urge surfing and response prevention',
    'Uncertainty training',
    'Extra insights'
  ];
</script>

<section
  id="pricing"
  class="pricing section-pad section-scroll-margin content-below-fold"
  aria-labelledby="pricing-title"
>
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <p class="eyebrow">Pricing</p>
        <h2 id="pricing-title" class="title serif">Free to use. Pro if you want more.</h2>
        <p class="subtitle">
          No subscription, no ads, and no account. Pro is a single purchase that unlocks the
          deeper ERP tools, on iPhone and Android alike.
        </p>
      </div>

      <div class="plans">
        <article class="plan">
          <h3>Patterns</h3>
          <p class="price"><span class="amount">Free</span></p>
          <p class="plan-note">Everything you need to notice the loop and practise.</p>
          <ul>
            {#each free as item}
              <li><Check size={16} strokeWidth={2} aria-hidden="true" />{item}</li>
            {/each}
          </ul>
        </article>

        <article class="plan pro">
          <h3>Patterns Pro</h3>
          <p class="price">
            <span class="amount">{proPricing.currentUsd}</span>
            <span class="once">once</span>
            <span class="was">
              <span class="sr-only">Previously</span>
              <s>{proPricing.previousUsd}</s>
            </span>
          </p>
          <p class="plan-note">Everything in Patterns, plus structured ERP practice.</p>
          <ul>
            {#each pro as item}
              <li><Check size={16} strokeWidth={2} aria-hidden="true" />{item}</li>
            {/each}
          </ul>
          <a href="/toolkit" class="plan-link">See every Pro tool</a>
        </article>
      </div>

      <p class="footnote">
        US price shown. Your app store shows the price for your country. Already own Pro? Nothing
        changes and you are never charged again.
      </p>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .pricing {
    background: var(--bg);
  }

  .header {
    max-width: 640px;
    margin: 0 auto;
    text-align: center;
  }

  .title {
    margin: 14px 0 0;
    font-size: clamp(32px, 4.4vw, 46px);
    line-height: 1.1;
  }

  .subtitle {
    margin: 16px auto 0;
    color: var(--text-secondary);
    font-size: 17px;
    line-height: 1.65;
  }

  .plans {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 20px;
    max-width: 860px;
    margin: 48px auto 0;
  }

  .plan {
    display: flex;
    flex-direction: column;
    padding: 32px;
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    background: var(--surface);
  }

  .plan.pro {
    border-color: color-mix(in srgb, var(--accent) 45%, var(--border));
  }

  .plan h3 {
    margin: 0;
    font-size: 16px;
  }

  .price {
    display: flex;
    align-items: baseline;
    flex-wrap: wrap;
    gap: 8px;
    margin: 14px 0 0;
  }

  .amount {
    font-family: var(--font-display);
    font-size: 44px;
    font-weight: 500;
    line-height: 1;
    letter-spacing: -0.02em;
  }

  .once,
  .was {
    color: var(--text-secondary);
    font-size: 14px;
  }

  .plan-note {
    margin: 12px 0 0;
    color: var(--text-secondary);
    font-size: 15px;
  }

  ul {
    display: grid;
    gap: 10px;
    margin: 24px 0 0;
    padding: 24px 0 0;
    border-top: 1px solid var(--border);
    list-style: none;
  }

  li {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    font-size: 15px;
    line-height: 1.45;
  }

  li :global(svg) {
    flex-shrink: 0;
    margin-top: 2px;
    color: var(--accent);
  }

  .plan-link {
    margin-top: auto;
    padding-top: 24px;
    color: var(--accent);
    font-size: 14px;
    font-weight: 600;
  }

  .plan-link:hover {
    text-decoration: underline;
    text-underline-offset: 3px;
  }

  .footnote {
    max-width: 560px;
    margin: 24px auto 0;
    color: var(--text-secondary);
    font-size: 13px;
    text-align: center;
  }

  .sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
  }

  @media (max-width: 699px) {
    .plans {
      grid-template-columns: 1fr;
    }

    .plan {
      padding: 24px;
    }
  }
</style>
