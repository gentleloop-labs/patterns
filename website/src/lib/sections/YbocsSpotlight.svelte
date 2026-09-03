<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { ArrowRight, Clock3, FileDown, LineChart, LockKeyhole } from 'lucide-svelte';

  const facts = [
    { icon: Clock3, label: 'About ten minutes' },
    { icon: LineChart, label: 'Separate impact and trends' },
    { icon: LockKeyhole, label: 'Saved locally on your device' },
    { icon: FileDown, label: 'Optional PDF for a clinician' }
  ];
</script>

<section id="ybocs" class="ybocs section-pad content-below-fold" aria-labelledby="ybocs-title">
  <ContentContainer>
    <div class="layout">
      <AnimatedOnScroll>
        <div class="copy">
          <span class="eyebrow">OCD SEVERITY SELF-CHECK</span>
          <h2 id="ybocs-title" class="serif">Track change across weeks - not one difficult hour.</h2>
          <p class="lead">
            Patterns includes a plain-language self-check informed by the severity dimensions used
            in the Yale-Brown Obsessive Compulsive Scale (Y-BOCS). Record how obsessions and
            compulsions affect your week, then notice what changes across later check-ins.
          </p>

          <ul class="facts">
            {#each facts as fact}
              {@const Icon = fact.icon}
              <li><Icon size={18} strokeWidth={1.8} /><span>{fact.label}</span></li>
            {/each}
          </ul>

          <aside class="disclaimer" aria-label="Y-BOCS self-check disclaimer">
            This is a self-check, not a diagnosis. A qualified professional should interpret
            symptoms in context.
          </aside>

          <div class="actions">
            <a class="primary" href="#download">Get Patterns <ArrowRight size={16} /></a>
            <a href="/blog/what-happens-during-an-ocd-assessment">How OCD assessments work</a>
          </div>

          <p class="source">
            Background: <a href="https://doi.org/10.1001/archpsyc.1989.01810110048007" target="_blank" rel="noopener noreferrer">the original Y-BOCS publication</a>.
          </p>
        </div>
      </AnimatedOnScroll>

      <AnimatedOnScroll delay={100}>
        <div class="visual" aria-label="Patterns OCD severity self-check results shown with demonstration data">
          <div class="halo" aria-hidden="true"></div>
          <div class="phone">
            <picture>
              <source type="image/webp" srcset="/assets/mockups/ybocs-app-ui-v1.webp" />
              <img
                src="/assets/mockups/ybocs-app-ui-v1.png"
                alt="Patterns self-check results showing separate obsession and compulsion impact using demonstration data"
                width="1170"
                height="2532"
                loading="lazy"
                decoding="async"
              />
            </picture>
          </div>
          <span class="demo">DEMONSTRATION DATA</span>
        </div>
      </AnimatedOnScroll>
    </div>
  </ContentContainer>
</section>

<style>
  .ybocs {
    overflow: hidden;
    background: var(--surface);
  }

  .layout {
    display: grid;
    grid-template-columns: minmax(0, 1.05fr) minmax(300px, 0.75fr);
    align-items: center;
    gap: 80px;
  }

  .copy {
    max-width: 650px;
  }

  .eyebrow {
    color: var(--accent);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.1em;
  }

  h2 {
    margin: 18px 0 0;
    font-size: 48px;
    line-height: 1.08;
  }

  .lead {
    margin: 20px 0 0;
    color: var(--text-secondary);
    font-size: 17px;
    line-height: 1.65;
  }

  .facts {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 12px;
    margin: 28px 0 0;
    padding: 0;
    list-style: none;
  }

  .facts li {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 13px 14px;
    border: 1px solid color-mix(in srgb, var(--border) 70%, transparent);
    border-radius: 13px;
    color: var(--text);
    background: var(--bg);
    font-size: 13px;
    font-weight: 600;
  }

  .facts :global(svg) {
    flex: 0 0 auto;
    color: var(--accent);
  }

  .disclaimer {
    margin-top: 20px;
    padding: 15px 17px;
    border-left: 3px solid var(--accent);
    border-radius: 0 12px 12px 0;
    color: var(--text-secondary);
    background: color-mix(in srgb, var(--accent) 7%, transparent);
    font-size: 13px;
    line-height: 1.55;
  }

  .actions {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 20px;
    margin-top: 26px;
  }

  .actions a {
    color: var(--accent);
    font-size: 14px;
    font-weight: 700;
  }

  .actions .primary {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    padding: 13px 18px;
    border-radius: 12px;
    color: #000;
    background: var(--accent);
  }

  .source {
    margin: 18px 0 0;
    color: var(--text-secondary);
    font-size: 12px;
  }

  .source a {
    color: var(--text);
    text-decoration: underline;
    text-underline-offset: 3px;
  }

  .visual {
    position: relative;
    display: grid;
    place-items: center;
    min-height: 620px;
  }

  .halo {
    position: absolute;
    inset: 10% -22%;
    border-radius: 50%;
    background: radial-gradient(circle, color-mix(in srgb, var(--accent) 18%, transparent), transparent 68%);
    filter: blur(18px);
  }

  .phone {
    position: relative;
    width: min(330px, 82vw);
    padding: 10px;
    overflow: hidden;
    border: 1px solid color-mix(in srgb, #fff 14%, transparent);
    border-radius: 42px;
    background: #050505;
    box-shadow: 0 32px 80px rgba(0, 0, 0, 0.55);
    transform: rotate(2.2deg);
  }

  .phone img {
    width: 100%;
    border-radius: 33px;
  }

  .demo {
    position: absolute;
    right: 0;
    bottom: 9%;
    padding: 8px 11px;
    border: 1px solid color-mix(in srgb, var(--accent) 38%, transparent);
    border-radius: 999px;
    color: var(--accent);
    background: color-mix(in srgb, var(--bg) 92%, transparent);
    font-size: 10px;
    font-weight: 800;
    letter-spacing: 0.09em;
  }

  @media (max-width: 900px) {
    .layout {
      grid-template-columns: 1fr;
      gap: 48px;
    }

    .copy {
      margin: 0 auto;
      text-align: center;
    }

    .actions {
      justify-content: center;
    }

    .disclaimer {
      text-align: left;
    }

    .visual {
      min-height: auto;
    }

    .demo {
      right: calc(50% - 210px);
    }
  }

  @media (max-width: 599px) {
    h2 {
      font-size: 34px;
    }

    .facts {
      grid-template-columns: 1fr;
    }

    .phone {
      width: min(300px, 82vw);
    }

    .demo {
      right: 0;
      bottom: 6%;
    }
  }
</style>
