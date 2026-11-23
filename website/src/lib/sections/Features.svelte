<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { features } from '$lib/data/features';
</script>

<section id="features" class="features section-pad section-scroll-margin content-below-fold" aria-labelledby="features-title">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <span class="eyebrow">FEATURES</span>
        <h2 id="features-title" class="title serif">
          OCD tracking, ERP support,<br />and private journaling.
        </h2>
        <p class="subtitle">
          Patterns helps you record intrusive thoughts, compulsions, triggers,
          responses, and distress levels without accounts, ads, or cloud uploads.
        </p>
      </div>
    </AnimatedOnScroll>

    <div class="grid">
      {#each features as feature, i}
        {@const Icon = feature.icon}
        <AnimatedOnScroll>
          <article class="card">
            <div class="icon-wrap">
              <Icon size={24} color="var(--accent)" strokeWidth={1.75} />
            </div>
            <h3>{feature.title}</h3>
            <p>{feature.description}</p>
          </article>
        </AnimatedOnScroll>
      {/each}
    </div>
  </ContentContainer>
</section>

<style>
  .features {
    background: var(--surface);
  }

  .header {
    text-align: center;
    margin-bottom: 72px;
  }


  .title {
    margin: 20px 0 0;
    font-size: 48px;
    line-height: 1.1;
  }

  .subtitle {
    margin: 16px auto 0;
    max-width: 520px;
    font-size: 17px;
    color: color-mix(in srgb, var(--text) 74%, var(--bg));
    line-height: 1.5;
  }

  .grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 24px;
  }

  /* Cards sit clearly off the section: their own fill with a soft fall-off,
     a full-strength border, and a hairline highlight along the top edge. */
  .card {
    position: relative;
    padding: 32px;
    border-radius: var(--radius-lg);
    border: 1px solid var(--border);
    background: linear-gradient(180deg, var(--surface-alt), var(--bg));
    box-shadow: inset 0 1px 0 color-mix(in srgb, var(--text) 6%, transparent);
    transition: border-color 0.25s, transform 0.25s;
    height: 100%;
  }

  .card:hover {
    border-color: color-mix(in srgb, var(--accent) 45%, var(--border));
    transform: translateY(-2px);
  }

  .icon-wrap {
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    border: 1px solid color-mix(in srgb, var(--accent) 30%, transparent);
    background: color-mix(in srgb, var(--accent) 16%, transparent);
    margin-bottom: 22px;
  }

  .card h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 700;
  }

  .card p {
    margin: 10px 0 0;
    font-size: 15px;
    line-height: 1.6;
    color: color-mix(in srgb, var(--text) 74%, var(--bg));
  }

  @media (min-width: 600px) {
    .grid {
      grid-template-columns: repeat(2, 1fr);
    }

    .header {
      margin-bottom: 48px;
    }
  }

  @media (min-width: 1024px) {
    .grid {
      grid-template-columns: repeat(3, 1fr);
    }

    .header {
      margin-bottom: 72px;
    }
  }

  @media (max-width: 599px) {
    .title {
      font-size: 32px;
    }

    .subtitle {
      font-size: 15px;
    }
  }
</style>
