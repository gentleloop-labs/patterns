<script lang="ts">
  import { onMount } from 'svelte';
  import Seo from '$lib/components/Seo.svelte';
  import BrandIcon from '$lib/components/BrandIcon.svelte';
  import StoreLink from '$lib/components/StoreLink.svelte';
  import { links } from '$lib/data/links';
  import { deviceCategory, ensureAnalyticsLoaded, logEvent } from '$lib/utils/analytics';
  import { getAttribution } from '$lib/utils/attribution';
  import { captureReferral } from '$lib/utils/referral';
  import { siAppstore, siGoogleplay } from 'simple-icons';

  /**
   * Platform emphasis is applied by CSS from `data-platform` on <html>, which the
   * inline head script below sets before first paint. Detecting it in JS after
   * hydration would reorder the store buttons under the visitor's thumb; this way
   * the correct order is the only order ever painted, so there is no layout shift.
   */
  const platformScript =
    '(function(){var u=navigator.userAgent;var t=navigator.maxTouchPoints||0;' +
    "var p=/Android/.test(u)?'android':(/iPad|iPhone|iPod/.test(u)||(navigator.platform==='MacIntel'&&t>1))?'ios':'desktop';" +
    "document.documentElement.setAttribute('data-platform',p);})();";

  onMount(() => {
    // One-decision page: a store tap can beat the idle callback, and a same-tab
    // hand-off to the store would take the queued event with it.
    ensureAnalyticsLoaded();

    const attribution = getAttribution();
    // Capture here so the landing event has `ref` even if this mounts before
    // the layout navigation hook. First valid value still wins for the tab.
    const ref = captureReferral(window.location.search);
    logEvent('get_landing_view', {
      device_category: deviceCategory(),
      click_source: attribution.source,
      click_medium: attribution.medium,
      click_campaign: attribution.campaign,
      click_content: attribution.content,
      click_term: attribution.term,
      ref
    });
  });

  const trust = [
    'Free to download',
    'No account required',
    'Private and local-first',
    'Available on iPhone and Android'
  ];

  const jsonLd = [
    {
      '@context': 'https://schema.org',
      '@type': 'MobileApplication',
      name: 'Patterns: OCD & ERP Journal',
      operatingSystem: 'iOS, Android',
      applicationCategory: 'HealthApplication',
      url: `${links.site}get`,
      offers: { '@type': 'Offer', price: '0', priceCurrency: 'USD' },
      downloadUrl: [links.ios, links.playStore]
    }
  ];
</script>

<Seo
  title="Patterns: OCD & ERP Journal - free for iPhone & Android"
  description="A private app for tracking triggers, delaying compulsions, and practising ERP between therapy sessions. Free, no account required, and local-first."
  path="get"
  {jsonLd}
/>

<svelte:head>
  {@html `<script>${platformScript}<\/script>`}
</svelte:head>

<main class="lp">
  <div class="grid">
    <section class="pitch">
      <a class="brand" href="/" aria-label="Patterns home">
        <img src="/assets/logo.png" alt="" width="56" height="56" />
      </a>

      <h1 class="headline serif">Patterns: OCD &amp; ERP Journal</h1>

      <p class="sub">
        A private app for tracking triggers, delaying compulsions, and practising ERP
        between therapy sessions.
      </p>

      <ul class="trust" aria-label="What to expect">
        {#each trust as point}
          <li>
            <svg viewBox="0 0 16 16" width="14" height="14" aria-hidden="true" focusable="false">
              <path
                d="M2.5 8.5l3.5 3.5 7.5-8"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
            <span>{point}</span>
          </li>
        {/each}
      </ul>

      <!-- Both stores always render. `order` and the accent ring are the only
           things platform detection changes, so nobody is ever dead-ended. -->
      <div class="stores" role="group" aria-label="Download Patterns">
        <StoreLink store="app_store" placement="hero" class="store store-ios">
          <span class="store-inner">
            <BrandIcon icon={siAppstore} size={28} color="#fff" />
            <span class="store-text">
              <small>Download on the</small>
              <strong>App Store</strong>
            </span>
          </span>
        </StoreLink>

        <StoreLink store="play_store" placement="hero" class="store store-android">
          <span class="store-inner">
            <BrandIcon icon={siGoogleplay} size={28} color="#fff" />
            <span class="store-text">
              <small>Get it on</small>
              <strong>Google Play</strong>
            </span>
          </span>
        </StoreLink>
      </div>

      <p class="reqs">
        Requires iOS 14 or later · Android 8 or later
        <span aria-hidden="true">·</span>
        <a href="/privacy">Privacy</a>
      </p>
    </section>

    <section class="media" aria-label="Patterns app preview">
      <img
        class="shot"
        src="/assets/mockups/mobile-hero.jpg"
        alt="The Patterns home screen, showing the recovery score, ERP practice, and quick actions"
        width="443"
        height="960"
        fetchpriority="high"
        decoding="async"
      />

      <!-- Desktop only: a scan target so a laptop visitor can move to the phone
           they will actually install on. -->
      <div class="qr">
        <img src="/assets/qr-get.svg" alt="QR code linking to patternsocd.com/get" width="132" height="132" />
        <p>Scan to open this page<br />on your phone</p>
      </div>
    </section>
  </div>
</main>

<style>
  .lp {
    min-height: 100svh;
    background: var(--hero-gradient, var(--bg));
    color: var(--text);
  }

  /* One viewport, no scrolling to reach a store button. The media row is the
     only flexible track, so on short screens the screenshot gives up height
     instead of pushing the buttons down. */
  .grid {
    min-height: 100svh;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0;
    padding: 20px 20px calc(20px + env(safe-area-inset-bottom, 0px));
    max-width: 1120px;
    margin: 0 auto;
  }

  .pitch {
    /* Never shrinks: the store buttons live here and must stay above the fold. */
    flex: 0 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    width: 100%;
    max-width: 520px;
  }

  .brand img {
    border-radius: 14px;
    box-shadow: 0 8px 24px color-mix(in srgb, #000 45%, transparent);
  }

  .headline {
    margin: 14px 0 0;
    font-size: clamp(26px, 6.4vw, 34px);
    line-height: 1.12;
    letter-spacing: -0.01em;
  }

  .sub {
    margin: 10px 0 0;
    max-width: 40ch;
    font-size: clamp(14.5px, 3.7vw, 16px);
    line-height: 1.5;
    color: var(--text-secondary);
  }

  .trust {
    list-style: none;
    margin: 14px 0 0;
    padding: 0;
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 6px 14px;
    width: 100%;
    max-width: 420px;
  }

  .trust li {
    display: flex;
    align-items: center;
    gap: 7px;
    text-align: left;
    font-size: 12.5px;
    line-height: 1.3;
    color: var(--text);
  }

  .trust svg {
    flex-shrink: 0;
    color: var(--accent);
  }

  /* Media sits between the pitch and nothing else; it absorbs leftover height
     and is allowed to collapse on short viewports. */
  .media {
    flex: 1 1 auto;
    min-height: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 32px;
    width: 100%;
    padding-top: 14px;
    overflow: hidden;
  }

  .shot {
    height: auto;
    width: auto;
    max-height: 100%;
    max-width: 100%;
    border-radius: 16px;
    border: 1px solid color-mix(in srgb, var(--border) 70%, transparent);
    box-shadow: 0 18px 48px color-mix(in srgb, #000 50%, transparent);
  }

  .qr {
    display: none;
  }

  .stores {
    margin-top: 18px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    width: 100%;
  }

  /* Both buttons keep identical geometry, so emphasis never changes layout. */
  .stores :global(.store) {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 60px;
    padding: 12px 20px;
    border-radius: 15px;
    background: #000;
    border: 1px solid color-mix(in srgb, #fff 22%, transparent);
    color: #fff;
    transition: transform 0.15s ease, border-color 0.2s ease, box-shadow 0.2s ease;
  }

  .stores :global(.store:hover) {
    border-color: color-mix(in srgb, #fff 55%, transparent);
    transform: translateY(-1px);
  }

  .stores :global(.store:focus-visible) {
    outline: 3px solid var(--accent);
    outline-offset: 3px;
  }

  .store-inner {
    display: inline-flex;
    align-items: center;
    gap: 12px;
  }

  .store-text {
    display: flex;
    flex-direction: column;
    text-align: left;
    line-height: 1.1;
  }

  .store-text small {
    font-size: 10.5px;
    opacity: 0.85;
  }

  .store-text strong {
    font-size: 18px;
    font-weight: 700;
  }

  .reqs {
    margin: 12px 0 0;
    font-size: 12px;
    color: var(--text-secondary);
  }

  .reqs a {
    color: var(--text-secondary);
    text-decoration: underline;
    text-underline-offset: 3px;
  }

  .reqs a:hover {
    color: var(--accent);
  }

  /* --- Device-aware emphasis -------------------------------------------
     Set from <html data-platform> before first paint. The non-matching store
     stays fully visible and tappable; it just loses the accent ring. */
  :global(html[data-platform='android']) .stores :global(.store-android) {
    order: -1;
  }

  :global(html[data-platform='android']) .stores :global(.store-ios) {
    opacity: 0.86;
  }

  :global(html[data-platform='ios']) .stores :global(.store-android) {
    opacity: 0.86;
  }

  :global(html[data-platform='android']) .stores :global(.store-android),
  :global(html[data-platform='ios']) .stores :global(.store-ios) {
    border-color: var(--accent);
    box-shadow: 0 6px 26px color-mix(in srgb, var(--accent) 26%, transparent);
  }

  /* --- Desktop / tablet -------------------------------------------------- */
  @media (min-width: 900px) {
    .grid {
      flex-direction: row;
      align-items: center;
      justify-content: center;
      gap: 56px;
      padding: 40px;
    }

    .pitch {
      align-items: flex-start;
      text-align: left;
      max-width: 520px;
    }

    .headline {
      font-size: 46px;
    }

    .sub {
      font-size: 18px;
      margin-top: 14px;
    }

    .trust {
      margin-top: 20px;
      max-width: none;
    }

    .trust li {
      font-size: 14px;
    }

    .stores {
      flex-direction: row;
      margin-top: 26px;
    }

    .stores :global(.store) {
      flex: 1 1 0;
    }

    .media {
      flex: 0 0 auto;
      /* Must drop the mobile `width: 100%`, or the media column claims the full
         row next to the pitch and pushes the page into horizontal overflow. */
      width: auto;
      max-height: 74svh;
      padding-top: 0;
      gap: 28px;
    }

    .shot {
      max-height: 74svh;
    }

    .qr {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 10px;
      padding: 16px;
      border-radius: 16px;
      border: 1px solid var(--border);
      background: color-mix(in srgb, var(--surface) 80%, transparent);
    }

    .qr img {
      border-radius: 8px;
      background: #fff;
      padding: 6px;
    }

    .qr p {
      margin: 0;
      font-size: 12px;
      line-height: 1.4;
      text-align: center;
      color: var(--text-secondary);
    }
  }

  /* Short viewports (in-app browsers carry a lot of chrome): trim the vertical
     rhythm rather than let anything fall below the fold. */
  @media (max-height: 700px) and (max-width: 899px) {
    .grid {
      padding-top: 14px;
    }

    .brand img {
      width: 44px;
      height: 44px;
    }

    .headline {
      margin-top: 10px;
    }

    .sub {
      margin-top: 8px;
    }

    .trust {
      margin-top: 10px;
      gap: 4px 12px;
    }

    .media {
      padding-top: 8px;
    }

    .stores {
      margin-top: 12px;
    }

    .stores :global(.store) {
      min-height: 54px;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .stores :global(.store) {
      transition: none;
    }

    .stores :global(.store:hover) {
      transform: none;
    }
  }
</style>
