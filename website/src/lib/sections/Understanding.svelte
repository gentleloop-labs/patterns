<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { loopSteps } from '$lib/data/homepage';
  import { ArrowRight } from 'lucide-svelte';

  let activeIndex = $state(0);
  let stepButtons: HTMLButtonElement[] = [];

  function selectStep(index: number, focus = false) {
    activeIndex = (index + loopSteps.length) % loopSteps.length;
    if (focus) stepButtons[activeIndex]?.focus();
  }

  function handleStepKey(event: KeyboardEvent, index: number) {
    const moves: Record<string, number> = {
      ArrowRight: index + 1,
      ArrowDown: index + 1,
      ArrowLeft: index - 1,
      ArrowUp: index - 1,
      Home: 0,
      End: loopSteps.length - 1
    };

    if (event.key in moves) {
      event.preventDefault();
      selectStep(moves[event.key], true);
    }
  }
</script>

<section id="understanding" class="understanding section-pad content-below-fold" aria-labelledby="understanding-title">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <span class="eyebrow">You're not alone</span>
        <h2 id="understanding-title" class="title serif">
          OCD is a loop.<br />Naming it is how you loosen it.
        </h2>
        <p class="subtitle">
          Intrusive thoughts aren't who you are. OCD keeps you stuck by making one
          thought feel like a threat - and making a ritual feel like the only way out.
          The relief never lasts, so the loop tightens. Seeing the pattern clearly is the
          first step to breaking it.
        </p>
      </div>
    </AnimatedOnScroll>

    <AnimatedOnScroll delay={100}>
      <ul class="cycle" aria-label="Explore the four steps in the OCD cycle">
        {#each loopSteps as step, i}
          <li class="step">
            <button
              type="button"
              class:active={i === activeIndex}
              aria-pressed={i === activeIndex}
              aria-controls="loop-detail"
              tabindex={i === activeIndex ? 0 : -1}
              bind:this={stepButtons[i]}
              onclick={() => selectStep(i)}
              onkeydown={(event) => handleStepKey(event, i)}
            >
              <span class="num">{i + 1}</span>
              <span class="step-label">{step.label}</span>
              <span class="step-note">{step.note}</span>
            </button>
          </li>
          {#if i < loopSteps.length - 1}
            <li class="arrow" aria-hidden="true"><ArrowRight size={18} /></li>
          {/if}
        {/each}
      </ul>

      <div id="loop-detail" class="detail" aria-live="polite">
        <div>
          <span>What is happening</span>
          <p>{loopSteps[activeIndex].detail}</p>
        </div>
        <div>
          <span>How the loop tightens</span>
          <p>{loopSteps[activeIndex].reinforcement}</p>
        </div>
        <div>
          <span>A possible next response</span>
          <p>{loopSteps[activeIndex].nextResponse}</p>
        </div>
      </div>
      <p class="education-note">General education, not personalized treatment advice.</p>
    </AnimatedOnScroll>

    <AnimatedOnScroll delay={150}>
      <div class="cta-row">
        <a href="/ocd" class="link-pill">Understand the OCD cycle <ArrowRight size={16} /></a>
        <a href="/erp" class="link-pill ghost">How ERP helps <ArrowRight size={16} /></a>
        <a href="/blog" class="link-pill ghost">From the blog <ArrowRight size={16} /></a>
      </div>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .understanding {
    background: var(--bg);
  }

  .header {
    text-align: center;
    max-width: 680px;
    margin: 0 auto 48px;
  }

  .eyebrow {
    display: inline-block;
    padding: 6px 14px;
    border-radius: 100px;
    border: 1px solid color-mix(in srgb, var(--accent) 25%, transparent);
    font-size: 12px;
    font-weight: 600;
    color: var(--accent);
    letter-spacing: 1.5px;
    text-transform: uppercase;
  }

  .title {
    margin: 20px 0 0;
    font-size: 44px;
    line-height: 1.12;
  }

  .subtitle {
    margin: 20px auto 0;
    max-width: 600px;
    font-size: 18px;
    line-height: 1.65;
    color: var(--text-secondary);
  }

  .cycle {
    display: flex;
    flex-wrap: wrap;
    align-items: stretch;
    justify-content: center;
    gap: 12px;
    margin: 0 auto;
    padding: 0;
    max-width: 880px;
    list-style: none;
  }

  .step {
    flex: 1 1 170px;
    min-width: 0;
  }

  .step button {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 6px;
    padding: 20px;
    cursor: pointer;
    text-align: left;
    border-radius: 16px;
    border: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
    background: var(--surface);
    font: inherit;
    transition: border-color 0.2s, background 0.2s, transform 0.2s;
  }

  .step button:hover,
  .step button.active {
    border-color: color-mix(in srgb, var(--accent) 60%, var(--border));
    background: color-mix(in srgb, var(--accent) 7%, var(--surface));
  }

  .step button:focus-visible {
    outline: 3px solid color-mix(in srgb, var(--accent) 72%, transparent);
    outline-offset: 3px;
  }

  .step button.active {
    transform: translateY(-3px);
  }

  .num {
    width: 24px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    font-size: 12px;
    font-weight: 700;
    color: #000;
    background: var(--accent);
  }

  .step-label {
    font-size: 16px;
    font-weight: 700;
    color: var(--text);
  }

  .step-note {
    font-size: 13px;
    line-height: 1.45;
    color: var(--text-secondary);
  }

  .arrow {
    display: flex;
    align-items: center;
    color: color-mix(in srgb, var(--accent) 70%, transparent);
  }

  .detail {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 1px;
    max-width: 880px;
    margin: 20px auto 0;
    overflow: hidden;
    border: 1px solid color-mix(in srgb, var(--accent) 22%, var(--border));
    border-radius: 18px;
    background: color-mix(in srgb, var(--border) 55%, transparent);
  }

  .detail > div {
    padding: 22px;
    background: color-mix(in srgb, var(--accent) 5%, var(--surface));
  }

  .detail span {
    color: var(--accent);
    font-size: 11px;
    font-weight: 800;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  .detail p {
    margin: 9px 0 0;
    color: var(--text-secondary);
    font-size: 14px;
    line-height: 1.55;
  }

  .education-note {
    margin: 12px 0 0;
    color: var(--text-secondary);
    font-size: 12px;
    text-align: center;
  }

  .cta-row {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 14px;
    margin-top: 40px;
  }

  .link-pill {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 12px 22px;
    border-radius: 100px;
    font-size: 15px;
    font-weight: 600;
    color: #000;
    background: var(--accent);
    transition: opacity 0.2s, background 0.2s, color 0.2s;
  }

  .link-pill:hover {
    opacity: 0.9;
  }

  .link-pill.ghost {
    color: var(--text);
    background: transparent;
    border: 1px solid color-mix(in srgb, var(--border) 80%, transparent);
  }

  .link-pill.ghost:hover {
    border-color: color-mix(in srgb, var(--accent) 55%, transparent);
    color: var(--accent);
    opacity: 1;
  }

  @media (max-width: 760px) {
    .arrow {
      display: none;
    }

    .step {
      flex-basis: calc(50% - 12px);
    }

    .detail {
      grid-template-columns: 1fr;
    }
  }

  @media (max-width: 599px) {
    .title {
      font-size: 30px;
    }

    .subtitle {
      font-size: 16px;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .step button {
      transition: none;
    }

    .step button.active {
      transform: none;
    }
  }
</style>
