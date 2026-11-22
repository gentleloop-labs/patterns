<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { CloudOff, BarChart3, Code } from 'lucide-svelte';

  const points = [
    {
      icon: CloudOff,
      title: 'OCD Data Stays Local',
      description: 'Your journal, exposures, compulsions, notes, and ratings stay on your device.'
    },
    {
      icon: BarChart3,
      title: 'Optional Usage Analytics',
      description: 'Default-off, first-party feature-use events with no personal OCD content.'
    },
    {
      icon: Code,
      title: 'Open Source',
      description: 'Fully auditable code. Verify it yourself.'
    }
  ];

  const policyBlocks = [
    {
      title: 'What Patterns stores',
      body: 'Patterns stores journal entries, OCD event notes, obsession or compulsion category, distress ratings, strategy notes, dates, timestamps, and basic app preferences such as theme and onboarding completion.'
    },
    {
      title: 'Local storage',
      body: 'Patterns does not create accounts, upload journal entries or OCD records, provide cloud sync, or include advertising or a third-party analytics SDK. Patterns does not sell, share, or send your entries to third parties. Manual exports go only where you choose to save them.'
    },
    {
      title: 'Anonymous product analytics',
      body: 'Share Anonymous Usage Analytics is optional and off by default. If you enable it, Patterns sends a random installation UUID, coarse platform, app version, and a closed set of feature event names, schema versions, and timestamps to a first-party Cloudflare Worker and D1 database. It never sends journal entries, intrusive thoughts, obsessions, compulsions, exposures, notes, ratings, Y-BOCS answers, recovery text, price, receipts, transaction identifiers, account identifiers, advertising IDs, device fingerprints, or location. The UUID is random, is not based on your device or an account, and is used only for this service.'
    },
    {
      title: 'Analytics retention and opt-out',
      body: 'Uploaded analytics events are automatically deleted within 90 days of the server receiving them. Turning analytics off stops new collection and immediately deletes the pending queue and analytics UUID from your device. Because Patterns has no account and discards that UUID, previously uploaded rows cannot be looked up or deleted for an individual; they expire through the automatic cleanup.'
    },
    {
      title: 'Purchases',
      body: 'Apple App Store and Google Play process in-app purchases under their own terms. Patterns receives the purchase result needed to unlock Pro and stores that entitlement locally. Anonymous analytics may record only that a purchase was started or completed. It never includes price, receipt data, transaction identifiers, StoreKit identifiers, RevenueCat identity, financial information, journal entries, or OCD records.'
    },
    {
      title: 'Export and import',
      body: 'Manual export creates a JSON backup file in the location you choose. After export, that file may be handled by your device, cloud storage, email, or another document provider. Importing a backup replaces the current local journal and OCD entries in the app.'
    },
    {
      title: 'Health and safety',
      body: 'Patterns is for personal reflection and self-tracking. It does not diagnose, treat, prevent, or cure any condition, and it is not a replacement for care from a qualified clinician.'
    },
    {
      title: 'Data deletion',
      body: 'You can delete individual OCD events in the app. Settings also includes a Wipe all data action that deletes local journal entries, OCD events, app preferences, pending analytics events, and the local analytics UUID from the device. Already uploaded anonymous analytics events remain only until the automatic 90-day expiry described above.'
    }
  ];
</script>

<section class="privacy section-pad" aria-labelledby="privacy-title">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <p class="eyebrow">Privacy</p>
        <h1 id="privacy-title" class="title serif">Your data stays yours.</h1>
        <p class="intro">
          Patterns is local-first. No accounts or cloud sync. Your journal and OCD records live on
          your device. Optional, default-off anonymous product analytics contain only feature-use
          events and never include personal OCD content.
        </p>
      </div>

      <div class="points" data-stagger>
        {#each points as point (point.title)}
          {@const Icon = point.icon}
          <article class="point">
            <span class="point-icon" aria-hidden="true">
              <Icon size={20} strokeWidth={1.75} />
            </span>
            <h2>{point.title}</h2>
            <p>{point.description}</p>
          </article>
        {/each}
      </div>
    </AnimatedOnScroll>

    <!-- One centred reading column: the policy is long-form text, so it gets
         a comfortable measure instead of a mostly empty side column. -->
    <AnimatedOnScroll delay={80}>
      <div class="policy">
        <header class="policy-head">
          <h2 class="serif">Privacy policy</h2>
          <p class="updated">Last updated: August 25, 2026</p>
        </header>
        <ol class="blocks">
          {#each policyBlocks as block, index (block.title)}
            <li>
              <span class="num" aria-hidden="true">{String(index + 1).padStart(2, '0')}</span>
              <div>
                <h3>{block.title}</h3>
                <p>{block.body}</p>
              </div>
            </li>
          {/each}
        </ol>
      </div>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .privacy {
    background: var(--bg);
  }

  .header {
    max-width: 680px;
    margin: 0 auto;
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
    max-width: 600px;
    font-size: 18px;
    line-height: 1.6;
    color: color-mix(in srgb, var(--text) 74%, var(--bg));
  }

  /* Summary cards, styled like the homepage Features cards. */
  .points {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 20px;
    max-width: 1080px;
    margin: 52px auto 0;
  }

  .point {
    padding: 28px;
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    background: linear-gradient(180deg, var(--surface-alt), var(--bg));
    box-shadow: inset 0 1px 0 color-mix(in srgb, var(--text) 6%, transparent);
  }

  .point-icon {
    display: grid;
    place-items: center;
    width: 44px;
    height: 44px;
    margin-bottom: 20px;
    border: 1px solid color-mix(in srgb, var(--accent) 30%, transparent);
    border-radius: 12px;
    background: color-mix(in srgb, var(--accent) 16%, transparent);
    color: var(--accent);
  }

  .point h2 {
    margin: 0;
    font-family: var(--font-body);
    font-size: 17px;
    font-weight: 600;
    letter-spacing: -0.01em;
  }

  .point p {
    margin: 8px 0 0;
    font-size: 15px;
    line-height: 1.6;
    color: color-mix(in srgb, var(--text) 74%, var(--bg));
  }

  /* Policy: a single reading column, centred like the header above it. */
  /* Same width as the summary cards above, so the page has one edge. */
  .policy {
    max-width: 1080px;
    margin: 72px auto 0;
    padding-top: 48px;
    border-top: 1px solid var(--border);
  }

  .policy-head {
    margin-bottom: 32px;
    text-align: center;
  }

  .policy-head h2 {
    margin: 0;
    font-size: clamp(26px, 3vw, 32px);
    line-height: 1.15;
  }

  .updated {
    margin: 8px 0 0;
    color: var(--text-secondary);
    font-size: 14px;
  }

  .blocks {
    margin: 0;
    padding: 0;
    list-style: none;
  }

  .blocks li {
    display: grid;
    grid-template-columns: 36px 1fr;
    gap: 12px;
    padding: 24px 0;
    border-bottom: 1px solid var(--border);
  }

  .blocks li:first-child {
    padding-top: 0;
  }

  .blocks li:last-child {
    border-bottom: 0;
  }

  .num {
    padding-top: 2px;
    color: var(--accent);
    font-size: 13px;
    font-weight: 600;
    font-variant-numeric: tabular-nums;
  }

  .blocks h3 {
    margin: 0;
    font-size: 17px;
    line-height: 1.4;
  }

  .blocks p {
    margin: 8px 0 0;
    font-size: 16px;
    line-height: 1.7;
    color: color-mix(in srgb, var(--text) 76%, var(--bg));
  }

  @media (max-width: 899px) {
    .points {
      grid-template-columns: 1fr;
      gap: 14px;
    }

    .policy {
      margin-top: 56px;
      padding-top: 36px;
    }
  }

  @media (max-width: 599px) {
    .blocks li {
      grid-template-columns: 28px 1fr;
      gap: 8px;
    }
  }
</style>
