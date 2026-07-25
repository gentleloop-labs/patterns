<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { CloudOff, EyeOff, Code, Lock } from 'lucide-svelte';

  const points = [
    {
      icon: CloudOff,
      title: 'No Cloud',
      description: 'Your journal and OCD records stay on your device.'
    },
    {
      icon: EyeOff,
      title: 'No Remote Analytics',
      description: 'No ads, trackers, third-party analytics, or remote telemetry.'
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
      body: 'Patterns does not create accounts, upload journal entries or OCD records, provide cloud sync, or include advertising and third-party analytics. The app keeps a small set of product-usage counters and recent events on your device to improve the first-session experience; these are not uploaded as remote telemetry. Patterns does not sell, share, or send your entries to third parties. Manual exports go only where you choose to save them.'
    },
    {
      title: 'Purchases',
      body: 'Apple App Store and Google Play process in-app purchases under their own terms. Patterns receives the purchase result needed to unlock Pro and stores that entitlement locally. Patterns does not use purchase information for advertising, analytics, or profiling, and your journal and OCD records are never included.'
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
      body: 'You can delete individual OCD events in the app. Settings also includes a Wipe all data action that deletes local journal entries, OCD events, and app preferences from the device.'
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
          Patterns is local-first. No accounts, no cloud sync, and no remote analytics. Your journal
          and OCD records live on your device; product-usage counters remain on-device.
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
        <p class="updated">Last updated: May 3, 2026</p>
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
