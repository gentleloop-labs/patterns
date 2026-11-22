<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import StoreButton from '$lib/components/StoreButton.svelte';
  import BrandIcon from '$lib/components/BrandIcon.svelte';
  import { site } from '$lib/data/site';
  import { siApple, siAndroid } from 'simple-icons';

  const { ios, android } = site.platforms;
</script>

<section
  id="download"
  class="download section-pad section-scroll-margin content-below-fold"
  aria-labelledby="download-title"
>
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <p class="eyebrow">Download</p>
        <h2 id="download-title" class="title serif">Take Patterns with you</h2>
        <p class="subtitle">
          Free on iPhone and Android. No account, no cloud sync, and nothing you write leaves
          your phone unless you export it.
        </p>
      </div>

      <div class="cards">
        <article class="card" aria-labelledby="download-ios">
          <div class="card-head">
            <span class="platform-icon"><BrandIcon icon={siApple} size={20} color="currentColor" /></span>
            <div>
              <h3 id="download-ios">iPhone</h3>
              <p class="version">Version {ios.version}</p>
            </div>
          </div>
          <p class="body">
            Rebuilt as a native app in {ios.shortVersion}. Works with your iPhone settings: text
            size, Bold Text, VoiceOver, Reduce Motion, and Dark Mode.
          </p>
          <StoreButton store="app_store" placement="body" />
          <p class="requires">Requires {ios.requires}</p>
        </article>

        <article class="card" aria-labelledby="download-android">
          <div class="card-head">
            <span class="platform-icon"><BrandIcon icon={siAndroid} size={20} color="currentColor" /></span>
            <div>
              <h3 id="download-android">Android</h3>
              <p class="version">Version {android.version}</p>
            </div>
          </div>
          <p class="body">
            The same tools and the same privacy promise, with light and dark themes and six
            languages.
          </p>
          <StoreButton store="play_store" placement="body" />
          <p class="requires">Requires {android.requires}</p>
        </article>
      </div>

      <p class="footnote">
        Your records stay on the phone you write them on. There is no account to sync them, so
        use the backup file in Settings if you move to a new phone.
      </p>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .download {
    background: var(--surface);
    border-top: 1px solid var(--border);
    /* The Support line follows on the same background, so the gap is short. */
    padding-bottom: 56px;
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

  .cards {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 20px;
    max-width: 860px;
    margin: 44px auto 0;
  }

  /* Centred to match the section heading; the button and requirement line
     sit at the bottom so both cards end level whatever the text length. */
  .card {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    padding: 32px 28px 28px;
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    background: var(--bg);
  }

  .card-head {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
  }

  .platform-icon {
    display: grid;
    place-items: center;
    width: 44px;
    height: 44px;
    border-radius: 12px;
    background: var(--surface-alt);
    color: var(--text);
  }

  h3 {
    margin: 0;
    font-size: 18px;
  }

  .version {
    margin: 2px 0 0;
    color: var(--text-secondary);
    font-size: 14px;
    font-variant-numeric: tabular-nums;
  }

  .body {
    flex: 1;
    max-width: 340px;
    margin: 16px 0 24px;
    color: var(--text-secondary);
    font-size: 15px;
    line-height: 1.6;
  }

  .requires {
    margin: 12px 0 0;
    color: var(--text-secondary);
    font-size: 12px;
  }

  .footnote {
    max-width: 560px;
    margin: 24px auto 0;
    color: var(--text-secondary);
    font-size: 13px;
    text-align: center;
  }

  @media (max-width: 699px) {
    .cards {
      grid-template-columns: 1fr;
    }

    .card {
      padding: 24px;
    }
  }
</style>
