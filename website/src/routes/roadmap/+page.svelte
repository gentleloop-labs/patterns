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
    Compass
  } from 'lucide-svelte';

  const released = [
    {
      icon: PenLine,
      title: 'Rich-text daily journaling',
      body: 'A private, dated journal with bold and italic formatting, plus guided journal flows for the days when a blank page feels heavy.'
    },
    {
      icon: ListChecks,
      title: 'OCD event tracker',
      body: 'Log obsessions and compulsions as they happen and rate distress on the 0–10 SUDS scale - the same language used in ERP.'
    },
    {
      icon: Flame,
      title: 'ERP toolkit',
      body: 'Exposure hierarchy, compulsion delay, urge surfing, response prevention, uncertainty training, and behavioral experiments.'
    },
    {
      icon: Brain,
      title: 'Y-BOCS self-assessment',
      body: 'The gold-standard OCD severity scale, built into the app so you can check in on where things stand over time.'
    },
    {
      icon: HeartHandshake,
      title: 'Recovery toolkit',
      body: 'Coping library, emergency toolkit, action planner, implementation intentions, and structured ERP programs.'
    },
    {
      icon: BarChart3,
      title: 'Analytics & reports',
      body: 'Charts and insights that turn entries into trends, plus PDF report export to share with a therapist if you choose.'
    },
    {
      icon: FolderLock,
      title: 'Private by design',
      body: 'Local-first storage, JSON export/import backup, biometric app lock, and notifications. Your records stay on your device unless you export them.'
    },
    {
      icon: Crown,
      title: 'Patterns Pro',
      body: 'A one-time unlock - no subscription - with QR pairing to carry Pro across your devices.'
    },
    {
      icon: MonitorSmartphone,
      title: 'Everywhere you are',
      body: 'Shipped for iOS, macOS, Windows, and Linux, with the same privacy promise on every platform.'
    }
  ];

  const comingSoon = [
    {
      icon: Sparkles,
      title: 'Activation-first onboarding',
      body: 'Two calm intro screens replace the old carousel, then "What would help right now?" routes you straight into a first activity - compulsion delay, guided journal, ERP, or Y-BOCS.'
    },
    {
      icon: CheckCircle2,
      title: 'First-run activity flows',
      body: 'Every starter activity ends with a gentle reflection screen, and the notification-permission ask waits until it actually makes sense.'
    },
    {
      icon: BarChart3,
      title: 'Today & Insights upgrades',
      body: 'A live streak card reflects your practice immediately, and "Practice progress" replaces the old recovery score with non-clinical framing.'
    },
    {
      icon: Crown,
      title: 'Patterns Desktop Pro',
      body: 'A native desktop paywall with Lemon Squeezy license activation - $9.99, one time, yours for good.'
    },
    {
      icon: MonitorSmartphone,
      title: 'Android launch readiness',
      body: 'Updated Play Billing and target API, plus a server-side backstop that verifies purchases so Pro status stays reliable.'
    },
    {
      icon: FolderLock,
      title: 'On-device-only telemetry',
      body: 'Anonymous funnel counters that never leave your device, so the app can improve without watching you.'
    }
  ];

  const exploring = [
    {
      icon: Sun,
      title: 'Light theme',
      body: 'A full light theme for the app, designed with the same care as the dark one - calm, readable, and easy on tired eyes.'
    },
    {
      icon: GitBranch,
      title: 'A much improved flow',
      body: 'Reworking how the whole app fits together so the next right action is always obvious, from check-in to practice to review.'
    },
    {
      icon: Compass,
      title: 'A deeper OCD section',
      body: 'Taking the existing OCD exercises and materials further - more depth, more structure, and more room to grow the practice beyond everyday journaling.'
    },
    {
      icon: Eraser,
      title: 'Clear a date\u2019s journal entry',
      body: 'An explicit reset action (with confirmation) so an entry written on the wrong date can be cleared and the day started fresh.'
    },
    {
      icon: HeartHandshake,
      title: 'Gentler validation messages',
      body: 'Auditing every save flow so missing-field messages stay warm and encouraging - never blunt or scolding.'
    },
    {
      icon: Sparkles,
      title: 'From journal to daily ERP companion',
      body: 'The long-term direction: active ERP practice over passive tracking. The primary action in Patterns should be doing ERP, not just writing about it.'
    }
  ];

  const columns = [
    {
      id: 'released',
      title: 'Released',
      caption: 'Through v1.5, live in the app today',
      icon: CheckCircle2,
      items: released
    },
    {
      id: 'coming',
      title: 'Coming soon',
      caption: 'Built, shipping in the next release',
      icon: Rocket,
      items: comingSoon
    },
    {
      id: 'exploring',
      title: 'Exploring',
      caption: 'Future plans - no dates, no promises',
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
        'The Patterns product roadmap: everything shipped through version 1.5, the features coming soon in the next release, and what the app is exploring next - light theme, an improved flow, and a deeper OCD section.',
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
  description="The Patterns roadmap: everything shipped through v1.5 (ERP toolkit, journaling, Y-BOCS, recovery tools), what is coming soon in the next release, and what we are exploring next - light theme, improved flow, and a deeper OCD section."
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
          Patterns is built in the open by a person with OCD, for people with OCD. Here is
          everything that has shipped so far, what is coming in the next release, and what
          we are exploring after that.
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
                <span class="count">{column.items.length}</span>
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
            </div>
          </section>
        {/each}
      </div>
    </AnimatedOnScroll>

    <AnimatedOnScroll delay={120}>
      <section class="cta-banner" aria-labelledby="cta-title">
        <h2 id="cta-title">Try what is already here</h2>
        <p>
          Everything in the Released column is free to start with today - no account, no
          cloud, no ads. Download Patterns and see how far the toolkit has already come.
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

  .column-caption {
    display: flex;
    align-items: center;
    gap: 6px;
    margin: 8px 0 0 19px;
    font-size: 12.5px;
    color: var(--text-secondary);
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
