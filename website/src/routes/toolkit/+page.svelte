<script lang="ts">
  import { proPricing } from '$lib/data/pricing';
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import MedicalDisclaimer from '$lib/components/MedicalDisclaimer.svelte';
  import { freeTools, proTools } from '$lib/data/toolkit';
  import { links } from '$lib/data/links';
  import { ArrowRight, Check } from 'lucide-svelte';

  // Pro tools grouped by when in ERP you reach for them, so eleven tools read
  // as a sequence rather than a wall of identical cards.
  const proGroups = [
    {
      title: 'Plan your exposures',
      tools: ['Exposure Hierarchy', 'Exposure Materials', 'Structured Programs']
    },
    {
      title: 'Stay with it',
      tools: ['Response Prevention', 'Urge Surfing', 'Uncertainty Training']
    },
    {
      title: 'Change the pattern',
      tools: ['Action Planner', 'Implementation Intentions', 'Behavioral Experiments']
    },
    {
      title: 'Look back',
      tools: ['Reflection Journal', 'Recovery Metrics']
    }
  ].map((group) => ({
    ...group,
    tools: group.tools.map((title) => {
      const tool = proTools.find((t) => t.title === title);
      if (!tool) throw new Error(`Unknown Pro tool: ${title}`);
      return tool;
    })
  }));

  const steps = [
    {
      title: 'Journal it',
      body: 'Capture intrusive thoughts, feelings, and daily reflections in a private, dated space. Naming a pattern is the first step to loosening its grip.'
    },
    {
      title: 'Track the moment',
      body: 'Log obsessions and compulsions as they happen and rate the distress on a 0–10 (SUDS) scale - the same language used in ERP.'
    },
    {
      title: 'Delay the urge',
      body: 'Use the Compulsion Delay tool to put a pause between urge and action, and watch the wave rise and fall without acting on it.'
    },
    {
      title: 'Practise recovery',
      body: 'Work through guided ERP and the recovery toolkit - exposure ladders, urge surfing, response prevention - at your own pace.'
    },
    {
      title: 'Review your patterns',
      body: 'Charts and recovery metrics turn your entries into trends, so progress becomes visible even when a single day feels like a loss.'
    }
  ];

  const jsonLd = [
    {
      '@context': 'https://schema.org',
      '@type': 'MedicalWebPage',
      name: 'The Patterns recovery toolkit - every tool, free and Pro',
      description:
        'A full tour of the Patterns recovery toolkit: guided ERP, compulsion delay, emergency toolkit, coping library, and the Patterns Pro tools for exposure hierarchies, urge surfing, response prevention, and more.',
      url: `${links.site}toolkit`,
      about: { '@type': 'MedicalCondition', name: 'Obsessive-Compulsive Disorder' },
      isPartOf: { '@type': 'WebSite', name: 'Patterns', url: links.site }
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'Recovery toolkit', item: `${links.site}toolkit` }
      ]
    }
  ];
</script>

<Seo
  title="The Patterns Recovery Toolkit - Every Tool & Patterns Pro"
  description="Tour every tool in Patterns: guided ERP, compulsion delay, emergency toolkit, coping library, plus the Patterns Pro tools - exposure hierarchies, urge surfing, response prevention, structured programs, and recovery metrics."
  path="toolkit"
  keywords="OCD recovery toolkit, ERP tools app, exposure hierarchy app, urge surfing, response prevention tracker, compulsion delay, Patterns Pro"
  {jsonLd}
/>

<article class="toolkit section-pad">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="head">
        <p class="eyebrow">Recovery toolkit</p>
        <h1 class="title serif">Everything Patterns gives you to do the work.</h1>
        <p class="intro">
          Patterns started as a private OCD tracker. It grew into a full recovery toolkit
          built around ERP - the therapy that actually helps. Here is every tool, how the
          app fits together day to day, and exactly what is free versus what Patterns Pro
          unlocks.
        </p>
      </div>
    </AnimatedOnScroll>

    <AnimatedOnScroll>
      <section class="block" aria-labelledby="how-title">
        <h2 id="how-title" class="block-title">How Patterns works, day to day</h2>
        <p class="block-sub">
          You do not have to use all of it. Most days are just a check-in. But when you
          need more, the toolkit follows the same rhythm ERP asks of you.
        </p>
        <ol class="steps">
          {#each steps as step, i}
            <li class="step">
              <span class="num">{i + 1}</span>
              <div>
                <h3>{step.title}</h3>
                <p>{step.body}</p>
              </div>
            </li>
          {/each}
        </ol>
      </section>
    </AnimatedOnScroll>

    <AnimatedOnScroll>
      <section class="block" aria-labelledby="free-title">
        <div class="tier-head">
          <h2 id="free-title" class="block-title">Free tools</h2>
          <span class="tier-note">Included for everyone, no account</span>
        </div>
        <p class="block-sub">
          Everything you need to start is free: the journal, the OCD tracker, distress charts,
          and these core recovery tools.
        </p>
        <div class="panel">
          <ul class="tools">
            {#each freeTools as tool (tool.title)}
              {@const Icon = tool.icon}
              <li>
                <span class="icon" aria-hidden="true"><Icon size={18} strokeWidth={1.75} /></span>
                <div>
                  <h3>{tool.title}</h3>
                  <p>{tool.description}</p>
                </div>
              </li>
            {/each}
          </ul>
        </div>
      </section>
    </AnimatedOnScroll>

    <AnimatedOnScroll>
      <section class="block" aria-labelledby="pro-title">
        <div class="tier-head">
          <h2 id="pro-title" class="block-title">Patterns Pro tools</h2>
          <span class="tier-note pro">One-time unlock</span>
        </div>
        <p class="block-sub">
          When you are ready to go deeper, Pro adds the structured ERP tools: the ones that
          turn tracking into a real recovery practice.
        </p>
        <div class="panel pro">
          {#each proGroups as group (group.title)}
            <section class="group" aria-label={group.title}>
              <h3 class="group-title">{group.title}</h3>
              <ul class="tools">
                {#each group.tools as tool (tool.title)}
                  {@const Icon = tool.icon}
                  <li>
                    <span class="icon" aria-hidden="true"><Icon size={18} strokeWidth={1.75} /></span>
                    <div>
                      <h4>{tool.title}</h4>
                      <p>{tool.description}</p>
                    </div>
                  </li>
                {/each}
              </ul>
            </section>
          {/each}
        </div>
      </section>
    </AnimatedOnScroll>

    <AnimatedOnScroll>
      <section class="unlock" aria-labelledby="unlock-title">
        <div class="unlock-copy">
          <p class="eyebrow">Patterns Pro</p>
          <h2 id="unlock-title" class="serif">A one-time unlock, yours for good.</h2>
          <p>
            Pro is a single purchase, not a subscription. It works offline and keeps the same
            privacy promise as the rest of the app: nothing leaves your device. Buying Pro is
            also how a person with OCD gets to keep building this, without ever turning your
            hardest moments into an ad.
          </p>
        </div>

        <div class="unlock-card">
          <p class="price">
            <span class="amount">{proPricing.currentUsd}</span>
            <span class="once">one time</span>
          </p>
          <p class="was">
            Down from <s>{proPricing.previousUsd}</s>. Prices vary by country, and your app
            store always shows yours.
          </p>
          <ul class="points">
            <li><Check size={16} strokeWidth={2} aria-hidden="true" /> Every Pro tool on this page</li>
            <li><Check size={16} strokeWidth={2} aria-hidden="true" /> No subscription, no login, no cloud</li>
            <li><Check size={16} strokeWidth={2} aria-hidden="true" /> Restore it from Settings if you change phones</li>
          </ul>
          <div class="actions">
            <a href="/#download" class="btn primary">Download Patterns</a>
            <a href="/erp" class="btn ghost">How ERP works <ArrowRight size={15} strokeWidth={2} /></a>
          </div>
        </div>
      </section>
    </AnimatedOnScroll>

    <div class="disclaimer-wrap">
      <MedicalDisclaimer />
    </div>

    <nav class="related" aria-label="Related pages">
      <a href="/ocd" class="related-card"><span>Understanding the OCD cycle</span><ArrowRight size={18} /></a>
      <a href="/erp" class="related-card"><span>ERP &amp; how Patterns helps</span><ArrowRight size={18} /></a>
    </nav>

    <div class="back-wrap"><a href="/">← Back to Home</a></div>
  </ContentContainer>
</article>

<style>
  .toolkit {
    background: var(--bg);
  }

  .head {
    max-width: 720px;
    margin: 0 auto 72px;
    text-align: center;
  }

  .eyebrow {
    margin: 0 0 12px;
  }

  .title {
    margin: 0;
    font-size: clamp(34px, 5vw, 48px);
    line-height: 1.1;
  }

  .intro {
    margin: 20px auto 0;
    max-width: 640px;
    font-size: 18px;
    line-height: 1.65;
    color: var(--text-secondary);
  }

  .block {
    max-width: 1000px;
    margin: 0 auto 72px;
  }

  .block-title {
    margin: 0;
    font-size: clamp(26px, 3.4vw, 32px);
    line-height: 1.2;
  }

  .tier-head {
    display: flex;
    flex-wrap: wrap;
    align-items: baseline;
    justify-content: space-between;
    gap: 8px 16px;
  }

  .tier-note {
    color: var(--text-secondary);
    font-size: 14px;
  }

  .tier-note.pro {
    color: var(--accent);
    font-weight: 600;
  }

  .block-sub {
    margin: 10px 0 24px;
    max-width: 640px;
    font-size: 16px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  /* Day-to-day steps: one quiet numbered list instead of five boxes. */
  .steps {
    margin: 0;
    padding: 4px 28px;
    list-style: none;
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    background: var(--surface);
  }

  /* Number and title share the first row and are centred on each other;
     the description sits under the title. The text column is a subgrid-free
     contents box so its title and description land in separate rows. */
  .step {
    display: grid;
    grid-template-columns: 32px 1fr;
    grid-template-rows: auto auto;
    column-gap: 16px;
    padding: 20px 0;
    border-bottom: 1px solid color-mix(in srgb, var(--border) 60%, transparent);
  }

  .step:last-child {
    border-bottom: 0;
  }

  .num {
    display: grid;
    place-items: center;
    width: 32px;
    height: 32px;
    border: 1px solid color-mix(in srgb, var(--accent) 45%, var(--border));
    border-radius: 50%;
    color: var(--accent);
    font-size: 14px;
    font-weight: 600;
    font-variant-numeric: tabular-nums;
  }

  .step > div {
    display: contents;
  }

  .num {
    grid-row: 1;
    grid-column: 1;
    align-self: center;
    /* Inter's figures sit a touch low in their line box; lift the digit
       slightly so it lines up with the title's capitals, not just its box. */
    padding-bottom: 1px;
  }

  .step h3 {
    grid-row: 1;
    grid-column: 2;
    align-self: center;
    margin: 0;
    font-size: 16px;
    line-height: 1.35;
  }

  .step p {
    grid-row: 2;
    grid-column: 2;
    margin: 0;
    font-size: 15px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  /* Tool panels: rows with a small icon, two columns on wide screens. */
  .panel {
    padding: 8px 28px;
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    background: var(--surface);
  }

  .panel.pro {
    padding-top: 4px;
    border-color: color-mix(in srgb, var(--accent) 38%, var(--border));
  }

  .group + .group {
    border-top: 1px solid var(--border);
  }

  .group-title {
    margin: 0;
    padding: 22px 0 2px;
    color: var(--text-secondary);
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  .tools {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    column-gap: 40px;
    margin: 0;
    padding: 0;
    list-style: none;
  }

  /* Pro groups hold three tools each, so they get three columns when there
     is room; two columns would strand the third tool on its own row. */
  @media (min-width: 960px) {
    .panel.pro .tools {
      grid-template-columns: repeat(3, minmax(0, 1fr));
      column-gap: 32px;
    }
  }

  .tools li {
    display: grid;
    grid-template-columns: 36px 1fr;
    gap: 14px;
    padding: 18px 0;
  }

  .icon {
    display: grid;
    place-items: center;
    width: 36px;
    height: 36px;
    border-radius: 10px;
    background: var(--accent-soft);
    color: var(--accent);
  }

  .tools h3,
  .tools h4 {
    margin: 0;
    font-size: 15px;
    line-height: 1.35;
  }

  .tools p {
    margin: 4px 0 0;
    font-size: 14px;
    line-height: 1.55;
    color: var(--text-secondary);
  }

  /* Unlock: the case for Pro on the left, the price and actions on the right. */
  .unlock {
    display: grid;
    grid-template-columns: minmax(0, 1.15fr) minmax(0, 1fr);
    align-items: center;
    gap: 48px;
    max-width: 1000px;
    margin: 0 auto 72px;
    padding: 48px;
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    background: var(--surface);
  }

  .unlock-copy h2 {
    margin: 0;
    font-size: clamp(28px, 3.6vw, 36px);
    line-height: 1.15;
  }

  .unlock-copy > p:last-child {
    margin: 16px 0 0;
    font-size: 16px;
    line-height: 1.65;
    color: var(--text-secondary);
  }

  .unlock-card {
    padding: 28px;
    border: 1px solid color-mix(in srgb, var(--accent) 38%, var(--border));
    border-radius: var(--radius);
    background: var(--bg);
  }

  .price {
    display: flex;
    align-items: baseline;
    gap: 10px;
    margin: 0;
  }

  .amount {
    font-family: var(--font-display);
    font-size: 48px;
    font-weight: 500;
    line-height: 1;
    letter-spacing: -0.02em;
  }

  .once {
    color: var(--text-secondary);
    font-size: 15px;
  }

  .was {
    margin: 10px 0 0;
    color: var(--text-secondary);
    font-size: 13px;
    line-height: 1.5;
  }

  .points {
    display: grid;
    gap: 10px;
    margin: 20px 0 0;
    padding: 20px 0 0;
    border-top: 1px solid var(--border);
    list-style: none;
  }

  .points li {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    font-size: 15px;
    line-height: 1.45;
  }

  .points :global(svg) {
    flex-shrink: 0;
    margin-top: 2px;
    color: var(--accent);
  }

  .actions {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 24px;
  }

  .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    min-height: 44px;
    padding: 0 18px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 600;
    transition: background 0.2s, border-color 0.2s;
  }

  .btn.primary {
    background: var(--accent-fill);
    color: var(--on-accent);
  }

  .btn.primary:hover {
    background: var(--accent-fill-hover);
  }

  .btn.ghost {
    border: 1px solid var(--border);
    color: var(--text);
  }

  .btn.ghost:hover {
    border-color: color-mix(in srgb, var(--text) 35%, transparent);
  }

  .btn:focus-visible {
    outline: 3px solid var(--accent);
    outline-offset: 3px;
  }

  .disclaimer-wrap {
    max-width: 1000px;
    margin: 0 auto 24px;
  }

  .related {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 12px;
    max-width: 1000px;
    margin: 0 auto;
  }

  .related-card {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding: 20px 22px;
    border: 1px solid var(--border);
    border-radius: var(--radius);
    background: var(--surface);
    font-size: 15px;
    font-weight: 600;
    transition: border-color 0.2s;
  }

  .related-card:hover {
    border-color: color-mix(in srgb, var(--text) 30%, transparent);
  }

  .related-card :global(svg) {
    color: var(--text-secondary);
  }

  .back-wrap {
    margin-top: 40px;
    text-align: center;
  }

  .back-wrap a {
    color: var(--text-secondary);
    font-size: 14px;
    font-weight: 600;
  }

  .back-wrap a:hover {
    color: var(--text);
  }

  @media (max-width: 799px) {
    .tools {
      grid-template-columns: 1fr;
    }

    .unlock {
      grid-template-columns: 1fr;
      gap: 28px;
      padding: 28px 22px;
    }
  }

  @media (max-width: 599px) {
    .steps,
    .panel {
      padding-inline: 20px;
    }

    .unlock-card {
      padding: 22px;
    }

    .related {
      grid-template-columns: 1fr;
    }
  }
</style>
