<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import DeviceFrame from '$lib/components/DeviceFrame.svelte';
  import StoreButton from '$lib/components/StoreButton.svelte';
  import BrandIcon from '$lib/components/BrandIcon.svelte';
  import { site } from '$lib/data/site';
  import { logEvent } from '$lib/utils/analytics';
  import { isAndroid } from '$lib/utils/platform';
  import { ArrowRight } from 'lucide-svelte';
  import { siApple, siAndroid } from 'simple-icons';

  const { ios, android } = site.platforms;

  // Android visitors see their own phone first; everyone else sees the order
  // below. Decided after hydration so the prerendered page stays identical.
  let androidFirst = $state(false);
  $effect(() => {
    androidFirst = isAndroid();
  });

  function handleRelease() {
    logEvent('hero_release_click', { version: site.latestRelease.version });
  }
</script>

<section id="hero" class="hero section-scroll-margin" aria-labelledby="hero-title">
  <ContentContainer>
    <div class="intro">
      <a class="release" href={site.latestRelease.href} onclick={handleRelease}>
        <span class="release-label">New</span>
        <span>{site.latestRelease.summary}</span>
        <ArrowRight size={14} strokeWidth={2} aria-hidden="true" />
      </a>

      <h1 id="hero-title" class="headline serif">
        See the loop.<br />Choose your next response.
      </h1>

      <p class="subhead">
        Patterns is a private OCD app for journaling, tracking OCD moments, and practising
        CBT-based ERP. No account, no cloud sync, and nobody else reading your notes.
      </p>

      <ul class="facts" aria-label="At a glance">
        <li>Free to download</li>
        <li>Stays on your phone</li>
        <li>Optional one-time Pro</li>
      </ul>
    </div>

    <div class="platforms" class:android-first={androidFirst}>
      <article class="platform ios" aria-labelledby="hero-ios">
        <div class="device-wrap">
          <DeviceFrame
            platform="ios"
            src="/assets/screens/ios-today.webp"
            alt="Patterns {ios.shortVersion} on iPhone: the Today screen with recent activity and a suggested next practice"
            loading="eager"
            fetchpriority="high"
          />
        </div>
        <div class="meta">
          <h2 id="hero-ios" class="platform-name">
            <BrandIcon icon={siApple} size={17} color="currentColor" />
            Patterns for iPhone
          </h2>
          <p class="version">Version {ios.shortVersion} · Native app</p>
          <StoreButton store="app_store" placement="hero" />
          <p class="requires">Requires {ios.requires}</p>
        </div>
      </article>

      <article class="platform android" aria-labelledby="hero-android">
        <div class="device-wrap">
          <DeviceFrame
            platform="android"
            src="/assets/screens/android-today.webp"
            alt="Patterns {android.shortVersion} on Android: the Today screen with recent activity and a suggested next practice"
            loading="eager"
          />
        </div>
        <div class="meta">
          <h2 id="hero-android" class="platform-name">
            <BrandIcon icon={siAndroid} size={18} color="currentColor" />
            Patterns for Android
          </h2>
          <p class="version">Version {android.version}</p>
          <StoreButton store="play_store" placement="hero" />
          <p class="requires">Requires {android.requires}</p>
        </div>
      </article>
    </div>
  </ContentContainer>
</section>

<style>
  .hero {
    padding: 72px 0 88px;
    background: var(--bg);
  }

  .intro {
    display: flex;
    flex-direction: column;
    align-items: center;
    max-width: 820px;
    margin: 0 auto;
    text-align: center;
  }

  .release {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    padding: 6px 14px 6px 6px;
    border: 1px solid var(--border);
    border-radius: 999px;
    background: var(--surface);
    color: var(--text-secondary);
    font-size: 14px;
    font-weight: 500;
    transition: border-color 0.2s, color 0.2s;
  }

  .release:hover {
    border-color: color-mix(in srgb, var(--text) 30%, transparent);
    color: var(--text);
  }

  .release:focus-visible {
    outline: 3px solid var(--accent);
    outline-offset: 3px;
  }

  .release-label {
    padding: 3px 9px;
    border-radius: 999px;
    background: var(--accent-soft);
    color: var(--accent);
    font-size: 12px;
    font-weight: 600;
  }

  .headline {
    margin: 32px 0 0;
    font-size: clamp(40px, 5.4vw, 62px);
    line-height: 1.06;
    font-weight: 500;
    letter-spacing: -0.02em;
  }

  .subhead {
    margin: 22px 0 0;
    max-width: 600px;
    font-size: 18px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  .facts {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 6px 22px;
    margin: 24px 0 0;
    padding: 0;
    list-style: none;
    color: var(--text-secondary);
    font-size: 14px;
  }

  .facts li {
    display: inline-flex;
    align-items: center;
    gap: 8px;
  }

  .facts li::before {
    content: '';
    width: 5px;
    height: 5px;
    border-radius: 50%;
    background: var(--accent);
  }

  .platforms {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 24px;
    max-width: 760px;
    margin: 64px auto 0;
  }

  .platform {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 28px;
  }

  .android-first .android {
    order: -1;
  }

  .device-wrap {
    width: min(100%, 272px);
    /* Bottom-align the phones so both platform labels line up. */
    margin-top: auto;
  }

  .meta {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  .platform-name {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    margin: 0;
    font-family: var(--font-body);
    font-size: 17px;
    font-weight: 600;
    letter-spacing: -0.01em;
  }

  .version {
    margin: 4px 0 16px;
    color: var(--text-secondary);
    font-size: 14px;
  }

  .requires {
    margin: 10px 0 0;
    color: var(--text-secondary);
    font-size: 12px;
  }

  @media (max-width: 599px) {
    .hero {
      padding: 40px 0 56px;
    }

    .release {
      font-size: 13px;
      text-align: left;
    }

    .subhead {
      font-size: 16px;
    }

    .platforms {
      gap: 14px;
      margin-top: 44px;
    }

    .platform {
      gap: 20px;
    }

    .platform-name {
      font-size: 14px;
      gap: 6px;
    }

    .version {
      font-size: 12px;
      margin-bottom: 12px;
    }

    .meta :global(.store-button) {
      padding: 6px 12px 6px 10px;
      gap: 8px;
    }

    .meta :global(.store-button strong) {
      font-size: 14px;
    }
  }
</style>
