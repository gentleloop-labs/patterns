<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import MedicalDisclaimer from '$lib/components/MedicalDisclaimer.svelte';
  import { links } from '$lib/data/links';
  import {
    Map,
    CheckCircle2,
    Rocket,
    Telescope,
    ArrowRight,
    PenLine,
    ListChecks,
    Flame,
    FolderLock,
    BarChart3,
    Crown,
    MonitorSmartphone,
    Sparkles,
    Sun,
    GitBranch,
    Brain,
    Eraser,
    HeartHandshake,
    Compass,
    BookOpen,
    ChevronRight
  } from 'lucide-svelte';

  // Shipped in the current release - kept expanded so the newest work reads first.
  const releasedRecent = [
    {
      icon: MonitorSmartphone,
      title: 'Patterns on Android',
      body: 'New: Patterns is on the Play Store now. Same app, same tools, and the same promise that nothing you write leaves your device. If you have been waiting on an Android phone, this is it.'
    },
    {
      icon: Sparkles,
      title: 'A gentler first few minutes',
      body: 'New on phones: instead of swiping through a slideshow, the app asks what would help right now and takes you straight there. You can start delaying a compulsion, or writing, within a minute of opening it.'
    },
    {
      icon: CheckCircle2,
      title: 'A soft landing afterwards',
      body: 'New on phones: when you finish that first exercise, there is a quiet screen to notice how it went instead of being dropped back at a menu. The app also waits to ask about notifications until it has a reason to.'
    },
    {
      icon: BarChart3,
      title: 'A home screen that keeps up',
      body: 'New on phones: your practice shows up the moment you do it. The old "recovery score" is gone, replaced by practice progress, because recovery is not a number you can be graded on.'
    },
    {
      icon: FolderLock,
      title: 'Counting that stays on your phone',
      body: 'New everywhere: the app keeps a small private tally of which features get used, so I can tell what is worth building next. Those numbers never leave your device and never reach me.'
    },
    {
      icon: Eraser,
      title: 'Clearing a day you wrote by mistake',
      body: 'If an entry went onto the wrong date, open that day, tap the bin, and confirm. The day goes blank again and nothing else is touched.'
    },
    {
      icon: Crown,
      title: 'What Pro costs',
      body: 'Pro is now $39.99 in the US, with local pricing elsewhere. Still one payment, still lifetime, still no subscription. If you already own Pro, nothing changes and you pay nothing again.'
    }
  ];

  // The foundation, shipped across earlier versions. Collapsed by default so the
  // Released column does not tower over the other two.
  const releasedEarlier = [
    {
      icon: PenLine,
      title: 'A private daily journal',
      body: 'Somewhere to write, one day at a time, with bold and italic when a word needs the weight. On the days a blank page feels like too much, there are prompts to write against instead.'
    },
    {
      icon: ListChecks,
      title: 'A place to log what OCD did today',
      body: 'Write down an obsession or a compulsion as it happens, and rate how distressing it was from 0 to 10. It is the same scale therapists use in ERP, so your notes travel well.'
    },
    {
      icon: Flame,
      title: 'Tools for practising ERP',
      body: 'Build a fear ladder and climb it a rung at a time. Delay a compulsion, ride out an urge, sit with not knowing, and test what OCD swears will happen.'
    },
    {
      icon: Brain,
      title: 'A way to check where things stand',
      body: 'The Y-BOCS, the questionnaire clinicians use to gauge how heavy OCD is right now. Take it whenever you want a read on whether things are shifting.'
    },
    {
      icon: HeartHandshake,
      title: 'Help for the hard moments',
      body: 'Coping strategies, a panic-button toolkit, and space to decide in advance what you will do the next time a trigger lands, so you are not deciding while flooded.'
    },
    {
      icon: BarChart3,
      title: 'Your own patterns, over time',
      body: 'Charts that turn scattered entries into something you can actually see. You can save it all as a PDF to bring to a therapist, only if you want to.'
    },
    {
      icon: FolderLock,
      title: 'Private by design',
      body: 'Everything stays on your device. No account, no cloud. Lock the app behind your face or fingerprint, and keep your own backup copy whenever you like.'
    },
    {
      icon: Crown,
      title: 'Patterns Pro',
      body: 'Pay once, keep it. No subscription, no renewal. Scan a code to carry it across to your other devices.'
    },
  ];

  const comingSoon = [
    {
      icon: Brain,
      title: 'Your Y-BOCS scores over time',
      body: 'The self-check stops being a one-off number. You get a line you can follow across months, and the scores land in the PDF you take to a therapist.'
    },
    {
      icon: Compass,
      title: 'Tracks for your kind of OCD',
      body: 'Contamination, checking, harm and taboo thoughts, relationship doubt, and just-right. Each one is a few weeks of exposures written for that theme, instead of a blank ladder to fill in yourself.'
    },
    {
      icon: HeartHandshake,
      title: 'Kinder wording when something is missing',
      body: 'A pass over every screen that can stop you saving, so the message reads like a nudge rather than a telling-off. Nobody needs that from an app about OCD.'
    }
  ];

  const exploring = [
    {
      icon: Sun,
      title: 'A light theme',
      body: 'A proper light mode, made with the same care as the dark one. Calm, easy to read, and kinder on tired eyes.'
    },
    {
      icon: GitBranch,
      title: 'A clearer path through the app',
      body: 'Reworking how it all fits together so the next useful thing is always obvious, and you never open Patterns and wonder where to start.'
    },
    {
      icon: BookOpen,
      title: 'More to read about OCD itself',
      body: 'The themed tracks cover the practice. What is still missing is the reading around it: why ERP works the way it does, and what to expect from it, written plainly.'
    },
    {
      icon: Sparkles,
      title: 'From journal to daily companion',
      body: 'The long-term hope: that the main thing you do in Patterns is practise, not just record. Writing helps, but doing the work is what shifts things.'
    }
  ];

  const columns = [
    {
      id: 'released',
      title: 'In the app now',
      caption: 'You can open Patterns and use all of this today',
      icon: CheckCircle2,
      items: releasedRecent,
      more: releasedEarlier,
      moreLabel: 'Everything added before this'
    },
    {
      id: 'coming',
      title: 'Almost ready',
      caption: 'Finished and being tested, coming in the next update',
      icon: Rocket,
      items: comingSoon
    },
    {
      id: 'exploring',
      title: 'Thinking about',
      caption: 'Ideas I would like to build. No dates, no promises',
      icon: Telescope,
      items: exploring
    }
  ];

  const jsonLd = [
    {
      '@context': 'https://schema.org',
      '@type': 'WebPage',
      name: 'Patterns roadmap - shipped, coming soon, and what\u2019s next',
      description:
        'The Patterns roadmap: what the OCD and ERP app can do today, what is almost ready in the next update including Y-BOCS scores over time and ERP tracks for specific OCD themes, and the ideas being considered after that.',
      url: `${links.site}roadmap`,
      isPartOf: { '@type': 'WebSite', name: 'Patterns', url: links.site }
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'Roadmap', item: `${links.site}roadmap` }
      ]
    }
  ];
</script>

<Seo
  title="Patterns Roadmap - Shipped, Coming Soon & What's Next"
  description="The Patterns roadmap: what this OCD and ERP app can do today (journaling, ERP tools, Y-BOCS, private tracking), what is almost ready in the next update (Y-BOCS scores over time, ERP tracks for specific OCD themes), and the ideas being considered after that."
  path="roadmap"
  keywords="Patterns roadmap, OCD app roadmap, ERP app updates, Patterns Pro, OCD tracker features, coming soon"
  {jsonLd}
/>

<article class="roadmap section-pad">
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="head">
        <div class="icon-tile">
          <Map size={34} color="var(--accent)" strokeWidth={1.75} />
        </div>
        <p class="eyebrow">Roadmap</p>
        <h1 class="title serif">Where Patterns has been, and where it is going.</h1>
        <p class="intro">
          I build Patterns on my own, and I have OCD myself. This page is the honest version
          of where things are: what you can use today, what is nearly ready, and what I am
          still turning over. If something here matters to you, or is missing, tell me and it
          will shape what comes next.
        </p>
      </div>
    </AnimatedOnScroll>

    <AnimatedOnScroll delay={80}>
      <div class="board" role="list" aria-label="Roadmap board">
        {#each columns as column}
          {@const ColumnIcon = column.icon}
          <section class="column {column.id}" role="listitem" aria-labelledby="{column.id}-title">
            <header class="column-head">
              <div class="column-title-row">
                <span class="dot" aria-hidden="true"></span>
                <h2 id="{column.id}-title">{column.title}</h2>
                <span class="count">{column.items.length + (column.more?.length ?? 0)}</span>
              </div>
              <p class="column-caption">
                <ColumnIcon size={13} />
                {column.caption}
              </p>
            </header>
            <div class="cards">
              {#each column.items as item}
                {@const Icon = item.icon}
                <article class="card">
                  <div class="card-top">
                    <div class="icon-wrap">
                      <Icon size={18} color="var(--accent)" strokeWidth={1.75} />
                    </div>
                    <h3>{item.title}</h3>
                  </div>
                  <p>{item.body}</p>
                </article>
              {/each}

              {#if column.more}
                <details class="more">
                  <summary>
                    <ChevronRight size={15} strokeWidth={2} />
                    <span>{column.moreLabel}</span>
                    <span class="more-count">{column.more.length}</span>
                  </summary>
                  <div class="cards more-cards">
                    {#each column.more as item}
                      {@const Icon = item.icon}
                      <article class="card">
                        <div class="card-top">
                          <div class="icon-wrap">
                            <Icon size={18} color="var(--accent)" strokeWidth={1.75} />
                          </div>
                          <h3>{item.title}</h3>
                        </div>
                        <p>{item.body}</p>
                      </article>
                    {/each}
                  </div>
                </details>
              {/if}
            </div>
          </section>
        {/each}
      </div>
    </AnimatedOnScroll>

    <AnimatedOnScroll delay={120}>
      <section class="cta-banner" aria-labelledby="cta-title">
        <h2 id="cta-title">Try what is already here</h2>
        <p>
          Everything in the first column is free to start with today. No account, no cloud,
          no ads. You can be writing or delaying an urge a minute after you open it.
        </p>
        <div class="actions">
          <a href="/#download" class="link-pill">Download Patterns <ArrowRight size={16} /></a>
          <a href="/toolkit" class="link-pill ghost">Tour the toolkit <ArrowRight size={16} /></a>
        </div>
      </section>
    </AnimatedOnScroll>

    <div class="disclaimer-wrap">
      <MedicalDisclaimer />
    </div>

    <div class="back-wrap"><a href="/">← Back to Home</a></div>
  </ContentContainer>
</article>

<style>
  .roadmap {
    background: var(--surface);
  }

  .head {
    max-width: 720px;
    margin: 0 auto 56px;
    text-align: center;
  }

  .icon-tile {
    width: 80px;
    height: 80px;
    margin: 0 auto 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 20px;
    background: color-mix(in srgb, var(--accent) 10%, transparent);
  }

  .eyebrow {
    margin: 0 0 12px;
    font-size: 13px;
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--accent);
  }

  .title {
    margin: 0;
    font-size: 46px;
    line-height: 1.1;
  }

  .intro {
    margin: 20px auto 0;
    max-width: 640px;
    font-size: 19px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  .board {
    display: grid;
    grid-template-columns: 1fr;
    gap: 16px;
    max-width: 1200px;
    margin: 0 auto 64px;
    align-items: start;
  }

  .column {
    display: flex;
    flex-direction: column;
    border-radius: 18px;
    border: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
    background: color-mix(in srgb, var(--surface-alt) 70%, transparent);
    overflow: hidden;
  }

  .column-head {
    padding: 16px 18px 14px;
    border-bottom: 1px solid color-mix(in srgb, var(--border) 55%, transparent);
  }

  .column-title-row {
    display: flex;
    align-items: center;
    gap: 9px;
  }

  .column-title-row h2 {
    margin: 0;
    font-size: 17px;
    line-height: 1.2;
  }

  .dot {
    flex-shrink: 0;
    width: 10px;
    height: 10px;
    border-radius: 50%;
  }

  .released .dot {
    background: #4ade80;
    box-shadow: 0 0 8px color-mix(in srgb, #4ade80 55%, transparent);
  }

  .coming .dot {
    background: var(--accent);
    box-shadow: 0 0 8px color-mix(in srgb, var(--accent) 55%, transparent);
  }

  .exploring .dot {
    background: #60a5fa;
    box-shadow: 0 0 8px color-mix(in srgb, #60a5fa 55%, transparent);
  }

  .count {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 22px;
    height: 20px;
    padding: 0 7px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 700;
  }

  .released .count {
    color: #4ade80;
    background: color-mix(in srgb, #4ade80 12%, transparent);
  }

  .coming .count {
    color: var(--accent);
    background: color-mix(in srgb, var(--accent) 12%, transparent);
  }

  .exploring .count {
    color: #60a5fa;
    background: color-mix(in srgb, #60a5fa 12%, transparent);
  }

  /* The icon sits in the same 19px gutter the dot occupies above it (13px icon
     + 6px gap matches 10px dot + 9px gap), so the caption text lines up with the
     column title rather than being indented past it. */
  .column-caption {
    display: flex;
    align-items: flex-start;
    gap: 6px;
    margin: 8px 0 0;
    font-size: 12.5px;
    line-height: 1.5;
    color: var(--text-secondary);
  }

  /* Hold the icon on the first line when the caption wraps, instead of letting
     it centre itself against the whole block. */
  .column-caption :global(svg) {
    flex-shrink: 0;
    margin-top: 3px;
  }

  .cards {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 12px;
  }

  .card {
    padding: 16px;
    border-radius: 12px;
    border: 1px solid color-mix(in srgb, var(--border) 50%, transparent);
    background: var(--bg);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.12);
    transition: border-color 0.25s, transform 0.25s, box-shadow 0.25s;
  }

  /* Collapsed group of older shipped work, so the Released column stays in
     proportion with the other two. */
  .more summary {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 11px 12px;
    border-radius: 10px;
    border: 1px dashed color-mix(in srgb, var(--border) 70%, transparent);
    color: var(--text-secondary);
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    list-style: none;
    transition: border-color 0.25s, color 0.25s;
  }

  .more summary::-webkit-details-marker {
    display: none;
  }

  .more summary:hover {
    border-color: color-mix(in srgb, var(--accent) 30%, transparent);
    color: var(--text);
  }

  .more summary:focus-visible {
    outline: 2px solid var(--accent);
    outline-offset: 2px;
  }

  .more summary :global(svg) {
    flex-shrink: 0;
    transition: transform 0.25s;
  }

  .more[open] summary :global(svg) {
    transform: rotate(90deg);
  }

  .more-count {
    margin-left: auto;
    padding: 1px 7px;
    border-radius: 999px;
    background: color-mix(in srgb, var(--border) 45%, transparent);
    font-size: 11.5px;
    font-weight: 700;
  }

  .more-cards {
    padding: 10px 0 0;
  }

  @media (prefers-reduced-motion: reduce) {
    .more summary :global(svg) {
      transition: none;
    }
  }

  .card:hover {
    border-color: color-mix(in srgb, var(--accent) 25%, transparent);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.18);
  }

  .card-top {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .icon-wrap {
    flex-shrink: 0;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 9px;
    background: color-mix(in srgb, var(--accent) 10%, transparent);
  }

  .card h3 {
    margin: 0;
    font-size: 15px;
    font-weight: 700;
    line-height: 1.3;
  }

  .card p {
    margin: 10px 0 0;
    font-size: 13.5px;
    line-height: 1.55;
    color: var(--text-secondary);
  }

  .cta-banner {
    max-width: 960px;
    margin: 0 auto 56px;
    padding: 36px;
    border-radius: 20px;
    border: 1px solid color-mix(in srgb, var(--accent) 22%, transparent);
    background: color-mix(in srgb, var(--accent) 6%, transparent);
  }

  .cta-banner h2 {
    margin: 0;
    font-size: 24px;
  }

  .cta-banner p {
    margin: 12px 0 0;
    max-width: 680px;
    font-size: 16px;
    line-height: 1.6;
    color: var(--text-secondary);
  }

  .actions {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-top: 24px;
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
    transition: opacity 0.2s, border-color 0.2s, color 0.2s;
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

  .disclaimer-wrap {
    max-width: 720px;
    margin: 0 auto;
  }

  .back-wrap {
    text-align: center;
    margin-top: 48px;
  }

  .back-wrap a {
    font-weight: 600;
    color: var(--accent);
  }

  @media (min-width: 1024px) {
    .board {
      grid-template-columns: repeat(3, 1fr);
    }
  }

  @media (max-width: 599px) {
    .title {
      font-size: 34px;
    }

    .intro {
      font-size: 16px;
    }
  }
</style>
