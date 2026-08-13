<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import StoreLink from '$lib/components/StoreLink.svelte';
  import BrandIcon from '$lib/components/BrandIcon.svelte';
  import { siAppstore, siGoogleplay } from 'simple-icons';
</script>

<section
  id="download"
  class="download section-pad section-scroll-margin content-below-fold"
  aria-labelledby="download-title"
>
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <span class="tag">iPhone &amp; Android</span>
        <h2 id="download-title" class="title serif">Take Patterns with you</h2>
        <p class="subtitle">
          Track obsessions, delay compulsions, and journal in a calm private space on your phone.
          No account, no cloud sync, and nothing you write leaves your device.
        </p>
      </div>

      <div class="mobile-card">
        <div class="phone-wrap">
          <img
            src="/assets/mockups/mobile-hero.jpg"
            alt="Patterns mobile app home screen showing ERP practice and quick actions"
            width="443"
            height="960"
            loading="lazy"
          />
        </div>

        <div class="mobile-copy">
          <h3 class="serif">Available on iOS and Android</h3>
          <p>
            Capture a trigger when it happens, keep your ERP notes close, and review your patterns
            wherever your day takes you.
          </p>

          <div class="store-badges" role="group" aria-label="Download Patterns for mobile">
            <StoreLink store="app_store" placement="body" newTab class="store-badge">
              <BrandIcon icon={siAppstore} size={24} color="#fff" />
              <span>
                <small>Download on the</small>
                <strong>App Store</strong>
              </span>
            </StoreLink>
            <StoreLink store="play_store" placement="body" newTab class="store-badge">
              <BrandIcon icon={siGoogleplay} size={24} color="#fff" />
              <span>
                <small>Get it on</small>
                <strong>Google Play</strong>
              </span>
            </StoreLink>
          </div>

          <p class="requirements">Requires iOS 14 or later · Android 8 or later</p>
        </div>
      </div>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .download {
    background: var(--bg);
  }

  .header {
    max-width: 680px;
    margin: 0 auto 48px;
    text-align: center;
  }

  .tag {
    display: inline-block;
    padding: 5px 11px;
    border: 1px solid color-mix(in srgb, var(--accent) 25%, transparent);
    border-radius: 999px;
    background: color-mix(in srgb, var(--accent) 10%, transparent);
    color: var(--accent);
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  .title {
    margin: 18px 0 0;
    font-size: 48px;
    line-height: 1.1;
  }

  .subtitle {
    margin: 16px auto 0;
    color: var(--text-secondary);
    font-size: 17px;
    line-height: 1.65;
  }

  .mobile-card {
    max-width: 880px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 30px;
    padding: 32px 24px;
    border: 1px solid color-mix(in srgb, var(--border) 50%, transparent);
    border-radius: 24px;
    background: var(--surface-alt);
  }

  .phone-wrap {
    width: min(190px, 54vw);
    overflow: hidden;
    border: 1px solid color-mix(in srgb, #fff 8%, transparent);
    border-radius: 24px;
    box-shadow: 0 18px 40px color-mix(in srgb, #000 45%, transparent);
    flex-shrink: 0;
  }

  .phone-wrap img {
    display: block;
    width: 100%;
    height: auto;
  }

  .mobile-copy {
    max-width: 480px;
    text-align: center;
  }

  .mobile-copy h3 {
    margin: 0;
    font-size: 34px;
    line-height: 1.15;
  }

  .mobile-copy > p {
    margin: 14px 0 0;
    color: var(--text-secondary);
    font-size: 15px;
    line-height: 1.6;
  }

  .store-badges {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 12px;
    margin-top: 26px;
  }

  .store-badges :global(.store-badge) {
    display: inline-flex;
    align-items: center;
    gap: 12px;
    padding: 12px 18px;
    border: 1px solid color-mix(in srgb, #fff 18%, transparent);
    border-radius: 12px;
    background: #000;
    color: #fff;
    transition: border-color 0.2s, transform 0.2s;
  }

  .store-badges :global(.store-badge:hover) {
    border-color: color-mix(in srgb, #fff 50%, transparent);
    transform: translateY(-1px);
  }

  .store-badges :global(.store-badge:focus-visible) {
    outline: 3px solid var(--accent);
    outline-offset: 3px;
  }

  .store-badges :global(.store-badge span) {
    display: flex;
    flex-direction: column;
    text-align: left;
  }

  .store-badges :global(.store-badge small) {
    font-size: 10px;
    line-height: 1;
    opacity: 0.8;
  }

  .store-badges :global(.store-badge strong) {
    font-size: 17px;
    font-weight: 700;
    line-height: 1.2;
  }

  .requirements {
    margin-top: 16px !important;
    font-size: 12px !important;
  }

  @media (min-width: 700px) {
    .mobile-card {
      flex-direction: row;
      justify-content: center;
      gap: 64px;
      padding: 48px;
    }

    .mobile-copy {
      text-align: left;
    }

    .store-badges {
      justify-content: flex-start;
    }
  }

  @media (max-width: 599px) {
    .title {
      font-size: 34px;
    }

    .subtitle {
      font-size: 15px;
    }

    .mobile-copy h3 {
      font-size: 28px;
    }
  }
</style>
