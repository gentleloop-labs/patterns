<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
</script>

<section id="everyday-moments" class="moments section-pad content-below-fold" aria-labelledby="moments-title">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="head">
        <span class="eyebrow">PATTERNS FOR ORDINARY MOMENTS</span>
        <h2 id="moments-title" class="serif">Support that fits into a real day.</h2>
        <p>
          Make room to notice what happened, or pause before responding to an urge. Patterns is
          designed to help briefly, then let you return to your life.
        </p>
      </div>
    </AnimatedOnScroll>

    <div class="grid">
      <AnimatedOnScroll delay={80}>
        <figure class="moment-card">
          <picture>
            <source
              type="image/webp"
              srcset="/assets/people/reflection-v1-640.webp 640w, /assets/people/reflection-v1-1024.webp 1024w, /assets/people/reflection-v1-1536.webp 1536w"
              sizes="(max-width: 759px) calc(100vw - 32px), 42vw"
            />
            <img
              src="/assets/people/reflection-v1-1024.jpg"
              srcset="/assets/people/reflection-v1-640.jpg 640w, /assets/people/reflection-v1-1024.jpg 1024w, /assets/people/reflection-v1-1536.jpg 1536w"
              sizes="(max-width: 759px) calc(100vw - 32px), 42vw"
              alt="A person writing in a notebook at a kitchen table with a phone nearby"
              width="1536"
              height="1024"
              loading="lazy"
              decoding="async"
            />
          </picture>
          <figcaption>
            <strong>Reflect when you have room</strong>
            <span>Write the thought down without carrying it through the rest of the day.</span>
          </figcaption>
        </figure>
      </AnimatedOnScroll>

      <AnimatedOnScroll delay={140}>
        <figure class="moment-card">
          <picture>
            <source
              type="image/webp"
              srcset="/assets/people/everyday-pause-v1-640.webp 640w, /assets/people/everyday-pause-v1-1024.webp 1024w, /assets/people/everyday-pause-v1-1536.webp 1536w"
              sizes="(max-width: 759px) calc(100vw - 32px), 42vw"
            />
            <img
              src="/assets/people/everyday-pause-v1-1024.jpg"
              srcset="/assets/people/everyday-pause-v1-640.jpg 640w, /assets/people/everyday-pause-v1-1024.jpg 1024w, /assets/people/everyday-pause-v1-1536.jpg 1536w"
              sizes="(max-width: 759px) calc(100vw - 32px), 42vw"
              alt="A person taking a quiet pause with a phone while travelling on a city tram"
              width="1536"
              height="1024"
              loading="lazy"
              decoding="async"
            />
          </picture>
          <figcaption>
            <strong>Pause when the urge arrives</strong>
            <span>Give yourself one more moment before the automatic response.</span>
          </figcaption>
        </figure>
      </AnimatedOnScroll>
    </div>
  </ContentContainer>
</section>

<style>
  .moments {
    background: var(--surface);
  }

  .head {
    max-width: 680px;
    margin: 0 auto 48px;
    text-align: center;
  }

  .eyebrow {
    color: var(--accent);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.1em;
  }

  h2 {
    margin: 16px 0 0;
    font-size: 44px;
    line-height: 1.12;
  }

  .head p {
    margin: 18px auto 0;
    color: var(--text-secondary);
    font-size: 17px;
    line-height: 1.65;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 24px;
  }

  .moment-card {
    margin: 0;
    overflow: hidden;
    border: 1px solid color-mix(in srgb, var(--border) 65%, transparent);
    border-radius: 22px;
    background: var(--bg);
  }

  .moment-card img {
    width: 100%;
    aspect-ratio: 3 / 2;
    object-fit: cover;
  }

  figcaption {
    padding: 22px 24px 24px;
  }

  figcaption strong,
  figcaption span {
    display: block;
  }

  figcaption strong {
    color: var(--text);
    font-size: 18px;
  }

  figcaption span {
    margin-top: 7px;
    color: var(--text-secondary);
    font-size: 14px;
    line-height: 1.55;
  }

  @media (max-width: 759px) {
    .grid {
      grid-template-columns: 1fr;
    }
  }

  @media (max-width: 599px) {
    h2 {
      font-size: 32px;
    }
  }
</style>
