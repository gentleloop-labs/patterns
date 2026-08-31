<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { proPricing } from '$lib/data/pricing';
  import { ArrowRight, Wallet, RefreshCwOff, Infinity as InfinityIcon } from 'lucide-svelte';

  // $39.99 to $19.99, so the badge is exactly half. Derived rather than typed
  // out so it cannot disagree with the figures above it.
  const percentOff = Math.round(
    (1 - Number(proPricing.currentUsd.slice(1)) / Number(proPricing.previousUsd.slice(1))) * 100
  );

  const promises = [
    { icon: Wallet, label: 'One payment' },
    { icon: RefreshCwOff, label: 'No subscription' },
    { icon: InfinityIcon, label: 'Yours for good' }
  ];
</script>

<section
  id="pricing"
  class="price-drop section-scroll-margin content-below-fold"
  aria-labelledby="price-drop-title"
>
  <ContentContainer padding="56px 0">
    <AnimatedOnScroll>
      <div class="card">
        <div class="glow" aria-hidden="true"></div>

        <h2 id="price-drop-title" class="sr-only">
          Patterns Pro price drop: was {proPricing.previousUsd}, now {proPricing.currentUsd}
        </h2>

        <span class="tag">Price drop</span>

        <div class="price-row">
          <span class="was" aria-hidden="true">{proPricing.previousUsd}</span>
          <ArrowRight class="arrow" size={28} aria-hidden="true" />
          <span class="now" aria-hidden="true">{proPricing.currentUsd}</span>
          <span class="badge" aria-hidden="true">{percentOff}% off</span>
        </div>

        <p class="unit">Patterns Pro, one time, in the US</p>

        <ul class="promises">
          {#each promises as promise}
            {@const Icon = promise.icon}
            <li>
              <span class="promise-tile"><Icon size={20} strokeWidth={1.75} /></span>
              {promise.label}
            </li>
          {/each}
        </ul>

        <div class="actions">
          <a href="/#download" class="btn primary">Get Patterns</a>
          <a href="/toolkit" class="btn ghost">See what Pro adds</a>
        </div>

        <p class="note">Already own Pro? Nothing changes and you are never charged again.</p>
      </div>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .price-drop {
    background: var(--bg);
  }

  .card {
    position: relative;
    overflow: hidden;
    max-width: 680px;
    margin: 0 auto;
    padding: 56px 40px 48px;
    text-align: center;
    border-radius: 24px;
    border: 1px solid var(--border);
    background: linear-gradient(180deg, var(--surface-alt) 0%, var(--surface) 100%);
  }

  .glow {
    position: absolute;
    top: -140px;
    left: 50%;
    width: 360px;
    height: 360px;
    transform: translateX(-50%);
    border-radius: 50%;
    background: color-mix(in srgb, var(--accent) 16%, transparent);
    filter: blur(80px);
    pointer-events: none;
  }

  .tag,
  .price-row,
  .unit,
  .promises,
  .actions,
  .note {
    position: relative;
  }

  .tag {
    display: inline-block;
    margin-bottom: 28px;
    padding: 5px 12px;
    font-size: 0.72rem;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--accent);
    border: 1px solid color-mix(in srgb, var(--accent) 35%, transparent);
    border-radius: 999px;
    background: color-mix(in srgb, var(--accent) 10%, transparent);
  }

  .price-row {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-wrap: wrap;
    gap: 16px;
    margin-bottom: 12px;
  }

  .was {
    font-family: var(--font-display);
    font-size: clamp(1.6rem, 4vw, 2.2rem);
    line-height: 1;
    color: var(--text-secondary);
    text-decoration: line-through;
    text-decoration-thickness: 2px;
  }

  .price-row :global(.arrow) {
    color: var(--text-secondary);
    flex-shrink: 0;
  }

  .now {
    font-family: var(--font-display);
    font-size: clamp(3.2rem, 9vw, 4.6rem);
    line-height: 1;
    color: var(--accent);
  }

  .badge {
    align-self: center;
    padding: 6px 12px;
    font-size: 0.8rem;
    font-weight: 700;
    letter-spacing: 0.02em;
    color: var(--bg);
    border-radius: 999px;
    background: var(--accent);
  }

  .unit {
    margin: 0 0 36px;
    font-size: 0.9rem;
    color: var(--text-secondary);
  }

  .promises {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 12px;
    max-width: 460px;
    margin: 0 auto 36px;
    padding: 0;
    list-style: none;
  }

  .promises li {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
    padding: 18px 10px;
    font-size: 0.85rem;
    font-weight: 500;
    color: var(--text);
    border: 1px solid var(--border);
    border-radius: 16px;
    background: color-mix(in srgb, var(--surface-alt) 60%, transparent);
  }

  .promise-tile {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    border-radius: 12px;
    color: var(--accent);
    background: color-mix(in srgb, var(--accent) 12%, transparent);
  }

  .actions {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    justify-content: center;
    margin-bottom: 22px;
  }

  .btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 13px 24px;
    font-size: 0.95rem;
    font-weight: 600;
    text-decoration: none;
    border-radius: 999px;
    transition: transform 0.15s ease;
  }

  .btn:hover {
    transform: translateY(-1px);
  }

  .primary {
    color: var(--bg);
    background: var(--accent);
  }

  .ghost {
    color: var(--text);
    border: 1px solid var(--border);
    background: transparent;
  }

  .note {
    margin: 0;
    font-size: 0.82rem;
    color: var(--text-secondary);
  }

  .sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0 0 0 0);
    white-space: nowrap;
    border: 0;
  }

  @media (max-width: 560px) {
    .card {
      padding: 44px 22px 38px;
    }

    .promises {
      grid-template-columns: 1fr;
      max-width: 320px;
    }

    .promises li {
      flex-direction: row;
      justify-content: flex-start;
      gap: 14px;
      padding: 14px 16px;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .btn:hover {
      transform: none;
    }
  }
</style>
