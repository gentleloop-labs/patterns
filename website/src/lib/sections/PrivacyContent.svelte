<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { CloudOff, BarChart3, Code, Lock } from 'lucide-svelte';

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
        <div class="lock-icon">
          <Lock size={36} color="var(--accent)" />
        </div>
        <h1 id="privacy-title" class="title serif">Your data stays yours.</h1>
        <p class="intro">
          Patterns is local-first. No accounts or cloud sync. Your journal and OCD records live on
          your device. Optional, default-off anonymous product analytics contain only feature-use
          events and never include personal OCD content.
        </p>
      </div>

      <div class="points-grid">
        {#each points as point}
          {@const Icon = point.icon}
          <article class="point-card">
            <Icon size={28} color="var(--accent)" strokeWidth={1.75} />
            <h2>{point.title}</h2>
            <p>{point.description}</p>
          </article>
        {/each}
      </div>

      <div class="policy">
        <h2 class="serif">Privacy policy</h2>
        <p class="updated">Last updated: August 25, 2026</p>
        {#each policyBlocks as block}
          <div class="policy-block">
            <span class="bullet"></span>
            <div>
              <h3>{block.title}</h3>
              <p>{block.body}</p>
            </div>
          </div>
        {/each}
      </div>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .privacy {
    background: var(--surface);
  }

  .header {
    text-align: center;
    margin-bottom: 56px;
  }

  .lock-icon {
    width: 80px;
    height: 80px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 20px;
    background: color-mix(in srgb, var(--accent) 10%, transparent);
  }

  .title {
    margin: 32px 0 0;
    font-size: 48px;
    line-height: 1.1;
  }

  .intro {
    margin: 16px auto 0;
    max-width: 560px;
    font-size: 17px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  .points-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 16px;
    margin-bottom: 56px;
  }

  @media (min-width: 600px) {
    .points-grid {
      grid-template-columns: repeat(3, 1fr);
      gap: 24px;
    }
  }

  .point-card {
    padding: 28px;
    text-align: center;
    border-radius: 16px;
    border: 1px solid color-mix(in srgb, var(--border) 50%, transparent);
  }

  .point-card h2 {
    margin: 16px 0 0;
    font-size: 16px;
    font-weight: 600;
  }

  .point-card p {
    margin: 8px 0 0;
    font-size: 14px;
    line-height: 1.5;
    color: var(--text-secondary);
  }

  .policy {
    padding: 32px;
    border-radius: 20px;
    border: 1px solid color-mix(in srgb, var(--border) 50%, transparent);
  }

  .policy > h2 {
    margin: 0;
    font-size: 30px;
    line-height: 1.15;
  }

  .updated {
    margin: 8px 0 24px;
    font-size: 14px;
    color: var(--text-secondary);
  }

  .policy-block {
    display: flex;
    gap: 14px;
    margin-bottom: 22px;
  }

  .bullet {
    width: 7px;
    height: 7px;
    margin-top: 9px;
    flex-shrink: 0;
    border-radius: 50%;
    background: var(--accent);
  }

  .policy-block h3 {
    margin: 0;
    font-size: 16px;
    font-weight: 700;
  }

  .policy-block p {
    margin: 6px 0 0;
    font-size: 14px;
    line-height: 1.55;
    color: var(--text-secondary);
  }

  @media (max-width: 599px) {
    .title {
      font-size: 32px;
    }

    .intro {
      font-size: 15px;
    }

    .policy {
      padding: 22px;
    }

    .policy > h2 {
      font-size: 24px;
    }
  }
</style>
