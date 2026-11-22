<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { freeTools, proTools } from '$lib/data/toolkit';
  import { ArrowRight } from 'lucide-svelte';

  // A representative slice on the homepage; the full set lives on /toolkit.
  // Pricing itself is covered by the Pricing section further down.
  const proPreview = proTools.slice(0, 6);

  const tiers = [
    { id: 'free', title: 'Free', note: 'Included for everyone', tools: freeTools },
    { id: 'pro', title: 'Patterns Pro', note: 'One-time unlock', tools: proPreview }
  ];
</script>

<section
  id="toolkit"
  class="toolkit section-pad section-scroll-margin content-below-fold"
  aria-labelledby="toolkit-title"
>
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <p class="eyebrow">Recovery toolkit</p>
        <h2 id="toolkit-title" class="title serif">Tools to practise, not just track.</h2>
        <p class="subtitle">
          The moves a therapist would guide you through in ERP, made into short exercises you
          can do on your own terms. Start free, and unlock the rest when you are ready.
        </p>
      </div>
    </AnimatedOnScroll>

    <AnimatedOnScroll delay={80}>
      <div class="tiers">
        {#each tiers as tier (tier.id)}
          <section class="tier {tier.id}" aria-labelledby="tier-{tier.id}">
            <header class="tier-head">
              <h3 id="tier-{tier.id}">{tier.title}</h3>
              <span class="tier-note">{tier.note}</span>
            </header>
            <ul>
              {#each tier.tools as tool (tool.title)}
                {@const Icon = tool.icon}
                <li>
                  <span class="icon" aria-hidden="true">
                    <Icon size={18} strokeWidth={1.75} />
                  </span>
                  <div>
                    <h4>{tool.title}</h4>
                    <p>{tool.description}</p>
                  </div>
                </li>
              {/each}
            </ul>
            {#if tier.id === 'pro'}
              <a class="tier-foot tier-link" href="/toolkit">
                See every tool <ArrowRight size={15} strokeWidth={2} aria-hidden="true" />
              </a>
            {:else}
              <p class="tier-foot">Free with no time limit. No account needed.</p>
            {/if}
          </section>
        {/each}
      </div>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .toolkit {
    background: var(--bg);
  }

  .header {
    max-width: 660px;
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

  .tiers {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 20px;
    max-width: 1040px;
    margin: 52px auto 0;
  }

  .tier {
    display: flex;
    flex-direction: column;
    padding: 8px 28px 24px;
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    background: var(--surface);
  }

  .tier.pro {
    border-color: color-mix(in srgb, var(--accent) 40%, var(--border));
  }

  .tier-head {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 12px;
    padding: 20px 0 16px;
    border-bottom: 1px solid var(--border);
  }

  .tier-head h3 {
    margin: 0;
    font-size: 17px;
  }

  .tier-note {
    color: var(--text-secondary);
    font-size: 13px;
  }

  .pro .tier-note {
    color: var(--accent);
    font-weight: 600;
  }

  ul {
    margin: 0;
    padding: 0;
    list-style: none;
  }

  li {
    display: grid;
    grid-template-columns: 36px 1fr;
    gap: 14px;
    padding: 18px 0;
    border-bottom: 1px solid color-mix(in srgb, var(--border) 60%, transparent);
  }

  li:last-child {
    border-bottom: 0;
  }

  .icon {
    display: grid;
    place-items: center;
    width: 36px;
    height: 36px;
    border-radius: 10px;
    background: var(--accent-soft);
    color: var(--accent);
  }

  h4 {
    margin: 0;
    font-size: 15px;
    line-height: 1.35;
  }

  li p {
    margin: 4px 0 0;
    color: var(--text-secondary);
    font-size: 14px;
    line-height: 1.55;
  }

  /* Both panels share a footer line pinned to the bottom, so they end level. */
  .tier-foot {
    display: flex;
    align-items: center;
    gap: 6px;
    margin: auto 0 0;
    padding-top: 16px;
    border-top: 1px solid var(--border);
    color: var(--text-secondary);
    font-size: 14px;
  }

  .tier-link {
    color: var(--accent);
    font-weight: 600;
  }

  .tier-link:hover {
    text-decoration: underline;
    text-underline-offset: 3px;
  }

  @media (max-width: 799px) {
    .tiers {
      grid-template-columns: 1fr;
    }

    .tier {
      padding: 4px 20px 20px;
    }
  }
</style>
