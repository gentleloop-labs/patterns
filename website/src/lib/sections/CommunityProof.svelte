<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import {
    testimonials,
    testimonialEditDisclosure,
    testimonialOutcomeDisclosure
  } from '$lib/data/homepage';
  import { ArrowRight, Quote } from 'lucide-svelte';
</script>

<section id="community-proof" class="community section-pad content-below-fold" aria-labelledby="community-title">
  <ContentContainer>
    <div class="founder">
      <AnimatedOnScroll>
        <div class="founder-copy">
          <span class="eyebrow">BUILT FROM LIVED EXPERIENCE</span>
          <h2 id="community-title" class="serif">I live with OCD. I built the tool I needed.</h2>
          <p>
            Patterns grew from the gap between understanding ERP in a session and recognizing the
            loop in ordinary life. I am a developer with lived experience, not a therapist or
            doctor. The app supports reflection and practice; it does not replace professional care.
          </p>
          <div class="founder-links">
            <a href="/blog/why-i-built-patterns">Why I built Patterns <ArrowRight size={15} /></a>
            <a href="/about/aftaab-siddiqui">About Aftaab</a>
          </div>
        </div>
      </AnimatedOnScroll>
    </div>

    <AnimatedOnScroll delay={100}>
      <div class="testimonial-head">
        <span class="eyebrow">EARLY COMMUNITY FEEDBACK</span>
        <h3 class="serif">Made with care. Used in real life.</h3>
      </div>
    </AnimatedOnScroll>

    <div class="quotes">
      {#each testimonials as item, index}
        <AnimatedOnScroll delay={80 + index * 45}>
          <blockquote>
            <Quote size={21} strokeWidth={1.7} aria-hidden="true" />
            <p>“{item.quote}”</p>
            <cite>{item.attribution}</cite>
          </blockquote>
        </AnimatedOnScroll>
      {/each}
    </div>

    <p class="disclosure">{testimonialEditDisclosure} {testimonialOutcomeDisclosure}</p>
  </ContentContainer>
</section>

<style>
  .community {
    background: var(--bg);
  }

  .founder {
    position: relative;
    max-width: 980px;
    margin: 0 auto 88px;
    padding: 48px;
    overflow: hidden;
    border: 1px solid color-mix(in srgb, var(--accent) 23%, var(--border));
    border-radius: 24px;
    background:
      radial-gradient(circle at 95% 10%, color-mix(in srgb, var(--accent) 13%, transparent), transparent 38%),
      var(--surface);
  }

  .founder-copy {
    max-width: 680px;
  }

  .eyebrow {
    color: var(--accent);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.1em;
  }

  h2 {
    margin: 17px 0 0;
    font-size: 46px;
    line-height: 1.1;
  }

  .founder-copy p {
    margin: 20px 0 0;
    color: var(--text-secondary);
    font-size: 17px;
    line-height: 1.7;
  }

  .founder-links {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 20px;
    margin-top: 26px;
  }

  .founder-links a {
    color: var(--accent);
    font-size: 14px;
    font-weight: 700;
  }

  .founder-links a:first-child {
    display: inline-flex;
    align-items: center;
    gap: 6px;
  }

  .testimonial-head {
    max-width: 650px;
    margin: 0 auto 36px;
    text-align: center;
  }

  h3 {
    margin: 14px 0 0;
    font-size: 40px;
    line-height: 1.12;
  }

  .quotes {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 18px;
    max-width: 980px;
    margin: 0 auto;
  }

  blockquote {
    height: 100%;
    margin: 0;
    padding: 26px;
    border: 1px solid color-mix(in srgb, var(--border) 65%, transparent);
    border-radius: 18px;
    background: var(--surface);
  }

  blockquote :global(svg) {
    color: var(--accent);
  }

  blockquote p {
    margin: 14px 0 0;
    color: var(--text);
    font-family: var(--font-reading);
    font-size: 17px;
    line-height: 1.65;
  }

  cite {
    display: block;
    margin-top: 18px;
    color: var(--text-secondary);
    font-size: 12px;
    font-style: normal;
    font-weight: 700;
    letter-spacing: 0.05em;
    text-transform: uppercase;
  }

  .disclosure {
    max-width: 760px;
    margin: 24px auto 0;
    color: var(--text-secondary);
    font-size: 12px;
    line-height: 1.6;
    text-align: center;
  }

  @media (max-width: 720px) {
    .quotes {
      grid-template-columns: 1fr;
    }
  }

  @media (max-width: 599px) {
    .founder {
      margin-bottom: 64px;
      padding: 30px 24px;
    }

    h2 {
      font-size: 34px;
    }

    h3 {
      font-size: 31px;
    }
  }
</style>
