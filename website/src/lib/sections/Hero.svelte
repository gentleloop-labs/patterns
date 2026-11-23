<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import DeviceFrame from '$lib/components/DeviceFrame.svelte';
  import StoreButton from '$lib/components/StoreButton.svelte';
  import BrandIcon from '$lib/components/BrandIcon.svelte';
  import { site } from '$lib/data/site';
  import { logEvent } from '$lib/utils/analytics';
  import { ArrowRight } from 'lucide-svelte';
  import { siApple, siAndroid } from 'simple-icons';

  const { ios, android } = site.platforms;

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
        A private OCD app built around ERP, the CBT-based approach for OCD. Notice the loop as
        it starts, put space between the urge and the ritual, and see what changes over the
        weeks. No account, and nobody else reading your notes.
      </p>

      <ul class="facts" aria-label="At a glance">
        <li>Free to download</li>
        <li>Stays on your phone</li>
        <li>Optional one-time Pro</li>
      </ul>
    </div>

    <div class="platforms">
      <article class="platform ios" aria-labelledby="hero-ios">
        <!-- Results, not effort: each pair shows what the user has done and how
             it has changed. iPhone: urge surfing history in front, Today's
             recent activity behind. -->
        <div class="device-wrap pair">
          <div class="back">
            <DeviceFrame
              platform="ios"
              src="/assets/screens/hero-ios-today.webp"
              alt="Patterns {ios.shortVersion} on iPhone: Today, listing recent activity such as 5 journal entries, 3 compulsion delays, and 1 exposure completed"
              loading="eager"
            />
          </div>
          <div class="front">
            <DeviceFrame
              platform="ios"
              src="/assets/screens/hero-ios-urgesurf.webp"
              alt="Patterns {ios.shortVersion} on iPhone: Urge Surfing history, each past urge showing where it started, peaked, and ended, such as started at 7, highest 8, ended at 3"
              loading="eager"
                fetchpriority="high"
            />
          </div>
        </div>
        <div class="meta">
          <h2 id="hero-ios" class="platform-name">
            <BrandIcon icon={siApple} size={17} color="currentColor" />
            Patterns for iPhone
          </h2>
          <p class="version">Version {ios.shortVersion} · Native app</p>
          <p class="shows">Watch each urge rise and fall · See what you have done</p>
          <StoreButton store="app_store" placement="hero" />
          <p class="requires">Requires {ios.requires}</p>
        </div>
      </article>

      <article class="platform android" aria-labelledby="hero-android">
        <!-- Android: Insights trends in front, ladder progress behind. -->
        <div class="device-wrap pair">
          <div class="back">
            <DeviceFrame
              platform="android"
              src="/assets/screens/hero-android-ladder.webp"
              alt="Patterns {android.shortVersion} on Android: an exposure ladder with one step done, one in progress, and one not started"
              loading="eager"
            />
          </div>
          <div class="front">
            <DeviceFrame
              platform="android"
              src="/assets/screens/hero-android-insights.webp"
              alt="Patterns {android.shortVersion} on Android: Insights with recent activity, mood over time, and Y-BOCS scores over time"
              loading="eager"
            />
          </div>
        </div>
        <div class="meta">
          <h2 id="hero-android" class="platform-name">
            <BrandIcon icon={siAndroid} size={18} color="currentColor" />
            Patterns for Android
          </h2>
          <p class="version">Version {android.version}</p>
          <p class="shows">See what has changed over weeks · One step done at a time</p>
          <StoreButton store="play_store" placement="hero" />
          <p class="requires">Requires {android.requires}</p>
        </div>
      </article>
    </div>

    <!-- Small screens: one large phone (the visitor's own platform, chosen
         by CSS from html[data-platform]) and both store buttons here, so
         nobody is shut out. The per-phone details above are hidden there. -->
    <div class="mobile-stores" role="group" aria-label="Download Patterns">
      <div class="mobile-store">
        <StoreButton store="app_store" placement="hero" />
        <p>iPhone · Version {ios.shortVersion} · {ios.requires}</p>
      </div>
      <div class="mobile-store">
        <StoreButton store="play_store" placement="hero" />
        <p>Android · Version {android.version} · {android.requires}</p>
      </div>
    </div>
  </ContentContainer>
</section>

<style>
  .hero {
    padding: 72px 0 88px;
    background: var(--bg);
    overflow-x: clip;
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
    gap: 32px;
    max-width: 1140px;
    margin: 64px auto 0;
  }

  .platform {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 28px;
  }

  :global(html[data-platform='android']) .android {
    order: -1;
  }

  .mobile-stores {
    display: none;
  }

  /* Tablets: one pair per row, so neither has to shrink. */
  @media (max-width: 959px) {
    .platforms {
      grid-template-columns: 1fr;
      gap: 72px;
      max-width: 560px;
    }
  }

  /* Entrance on load: the text settles in line by line, then the phones
     rise into place. Disabled under reduced motion. */
  .intro > * {
    animation: fade-up var(--dur-slow) var(--ease-out) both;
  }

  .intro > :nth-child(2) {
    animation-delay: 70ms;
  }

  .intro > :nth-child(3) {
    animation-delay: 140ms;
  }

  .intro > :nth-child(4) {
    animation-delay: 210ms;
  }

  .platform {
    animation: rise-in 1s var(--ease-out) both;
    animation-delay: 260ms;
  }

  .platform + .platform {
    animation-delay: 380ms;
  }

  .pair .back,
  .pair .front {
    transition: transform 600ms var(--ease-out);
  }

  /* On hover the two phones ease apart a little. */
  .platform:hover .pair .back {
    transform: translate(-6px, -4px) rotate(-1.5deg);
  }

  .platform:hover .pair .front {
    transform: translate(6px, -6px) rotate(1deg);
  }

  /* The front phone settles in just after the back one. */
  .pair .front {
    animation: rise-in 1s var(--ease-out) both;
    animation-delay: 520ms;
  }

  .platform + .platform .pair .front {
    animation-delay: 640ms;
  }

  @media (prefers-reduced-motion: reduce) {
    .intro > *,
    .platform {
      animation: none;
    }

    .pair .front {
      animation: none;
    }

    .platform:hover .pair .back,
    .platform:hover .pair .front {
      transform: none;
    }
  }

  /* An overlapping pair: the back phone sits up and to the left, the front
     phone lower and to the right. Phones are large enough that their screens
     can actually be read. */
  .pair {
    position: relative;
    width: min(100%, 540px);
    aspect-ratio: 100 / 150;
    /* Bottom-align the pairs so both platform labels line up. */
    margin-top: auto;
  }

  .pair .back,
  .pair .front {
    position: absolute;
    width: 66%;
  }

  .pair .back {
    top: 0;
    left: 0;
    opacity: 0.92;
  }

  .pair .front {
    right: 0;
    bottom: 0;
    z-index: 1;
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

  .shows {
    margin: -8px 0 16px;
    color: var(--text-secondary);
    font-size: 13px;
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

    /* One phone, big enough to read, instead of two shrunk side by side. */
    .platforms {
      grid-template-columns: 1fr;
      margin-top: 40px;
    }

    .platform .meta,
    .platform.android {
      display: none;
    }

    :global(html[data-platform='android']) .platform.android {
      display: flex;
    }

    :global(html[data-platform='android']) .platform.ios {
      display: none;
    }

    /* On phones both phones stay fully inside the screen: the front one is
       large enough to read, the smaller back one sits up and to the left. */
    .pair {
      width: 100%;
      aspect-ratio: 100 / 158;
    }

    .pair .front {
      width: 70%;
    }

    .pair .back {
      width: 58%;
      top: 2%;
    }

    .mobile-stores {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 14px;
      margin-top: 32px;
    }

    :global(html[data-platform='android']) .mobile-store:last-child {
      order: -1;
    }

    .mobile-store {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 6px;
    }

    .mobile-store :global(.store-button) {
      min-width: 200px;
      justify-content: center;
    }

    .mobile-store p {
      margin: 0;
      color: var(--text-secondary);
      font-size: 12px;
    }
  }
</style>
