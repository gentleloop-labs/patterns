<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
</script>

<section
  id="preview"
  class="preview section-pad section-scroll-margin content-below-fold"
  aria-labelledby="preview-title"
>
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <span class="eyebrow">MOBILE PREVIEW</span>
        <h2 id="preview-title" class="title serif">See Patterns in action</h2>
        <p class="subtitle">
          Real screens from Patterns on iPhone and Android, designed for the moments when you need
          to capture a trigger, delay an urge, or reflect on the day.
        </p>
      </div>
    </AnimatedOnScroll>

    <div class="showcases">
      <AnimatedOnScroll delay={100}>
        <div class="showcase">
          <div class="mockup-wrap feature-graphic">
            <img
              src="/assets/mockups/feature-graphic.jpg"
              alt="Patterns mobile screens for OCD tracking, ERP practice, and private journaling"
              width="1024"
              height="500"
              loading="lazy"
            />
          </div>
          <div class="copy">
            <span class="tag">IN YOUR POCKET</span>
            <h3 class="serif">A useful next step, wherever you are</h3>
            <p>
              Capture obsessions, log distress, and write a quick journal entry from your phone.
              Your entries stay on your device, with no account and no cloud upload.
            </p>
          </div>
        </div>
      </AnimatedOnScroll>

      <AnimatedOnScroll delay={200}>
        <div class="showcase reverse">
          <div class="phone-wrap">
            <img
              src="/assets/mockups/mobile-hero.jpg"
              alt="Patterns mobile home screen showing ERP practice and quick actions"
              width="443"
              height="960"
              loading="lazy"
            />
          </div>
          <div class="copy">
            <span class="tag">BUILT FOR MOBILE</span>
            <h3 class="serif">Recovery tools when the moment happens</h3>
            <p>
              Delay a compulsion, practise an exposure, or review your patterns without waiting to
              get back to another device.
            </p>
          </div>
        </div>
      </AnimatedOnScroll>
    </div>
  </ContentContainer>
</section>

<style>
  .preview {
    background: var(--bg);
  }

  .header {
    max-width: 680px;
    margin: 0 auto 72px;
    text-align: center;
  }

  .eyebrow,
  .tag {
    display: inline-block;
    padding: 5px 11px;
    border: 1px solid color-mix(in srgb, var(--accent) 25%, transparent);
    border-radius: 999px;
    background: color-mix(in srgb, var(--accent) 9%, transparent);
    color: var(--accent);
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.08em;
  }

  .title {
    margin: 20px 0 0;
    font-size: 48px;
    line-height: 1.1;
  }

  .subtitle {
    margin: 16px auto 0;
    color: var(--text-secondary);
    font-size: 17px;
    line-height: 1.65;
  }

  .showcases {
    display: grid;
    gap: 88px;
  }

  .showcase {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 34px;
  }

  .mockup-wrap {
    width: 100%;
    overflow: hidden;
    border: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
    border-radius: 24px;
    box-shadow: 0 20px 40px -8px color-mix(in srgb, #000 50%, transparent);
  }

  .mockup-wrap img {
    display: block;
    width: 100%;
    height: auto;
  }

  .feature-graphic {
    max-width: 660px;
  }

  .phone-wrap {
    width: min(220px, 58vw);
    overflow: hidden;
    border: 1px solid color-mix(in srgb, #fff 9%, transparent);
    border-radius: 26px;
    box-shadow: 0 20px 42px color-mix(in srgb, #000 50%, transparent);
    flex-shrink: 0;
  }

  .phone-wrap img {
    display: block;
    width: 100%;
    height: auto;
  }

  .copy {
    max-width: 480px;
    text-align: center;
  }

  .copy h3 {
    margin: 16px 0 0;
    font-size: 34px;
    line-height: 1.15;
  }

  .copy p {
    margin: 14px 0 0;
    color: var(--text-secondary);
    font-size: 16px;
    line-height: 1.65;
  }

  @media (min-width: 760px) {
    .showcase {
      flex-direction: row;
      justify-content: center;
      gap: 64px;
    }

    .showcase.reverse {
      flex-direction: row-reverse;
    }

    .feature-graphic {
      flex: 1 1 60%;
    }

    .copy {
      flex: 1 1 36%;
      text-align: left;
    }
  }

  @media (max-width: 599px) {
    .header {
      margin-bottom: 52px;
    }

    .title {
      font-size: 34px;
    }

    .subtitle {
      font-size: 15px;
    }

    .showcases {
      gap: 60px;
    }

    .copy h3 {
      font-size: 28px;
    }
  }
</style>
