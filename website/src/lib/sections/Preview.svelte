<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import DeviceFrame from '$lib/components/DeviceFrame.svelte';
  import BrandIcon from '$lib/components/BrandIcon.svelte';
  import { site } from '$lib/data/site';
  import { isAndroid } from '$lib/utils/platform';
  import { siApple, siAndroid } from 'simple-icons';

  type Platform = 'ios' | 'android';

  // Every screenshot is an unedited capture of the shipping app, taken with the
  // same demonstration data on both platforms so the two can be compared.
  const screens = [
    {
      id: 'today',
      title: 'Today',
      body: 'What you have done so far, and one manageable next step.'
    },
    {
      id: 'practice',
      title: 'Practice',
      body: 'Compulsion delay, coping tools, and ERP planning in one place.'
    },
    {
      id: 'journal',
      title: 'Journal',
      body: 'Private, dated entries that save as you write.'
    },
    {
      id: 'insights',
      title: 'Insights',
      body: 'Plain counts and trends, with no streaks to protect.'
    }
  ] as const;

  let platform = $state<Platform>('ios');
  // Small screens show one phone at a time; this is the one on show.
  let active = $state(0);
  $effect(() => {
    if (isAndroid()) platform = 'android';
  });

  const tabs: { id: Platform; label: string }[] = [
    { id: 'ios', label: 'iPhone' },
    { id: 'android', label: 'Android' }
  ];

  function onKeydown(event: KeyboardEvent) {
    if (event.key !== 'ArrowLeft' && event.key !== 'ArrowRight') return;
    event.preventDefault();
    platform = platform === 'ios' ? 'android' : 'ios';
    document.getElementById(`platform-tab-${platform}`)?.focus();
  }
</script>

<section
  id="preview"
  class="preview section-pad section-scroll-margin content-below-fold"
  aria-labelledby="preview-title"
>
  <ContentContainer>
    <AnimatedOnScroll>
      <div class="header">
        <p class="eyebrow">On your phone</p>
        <h2 id="preview-title" class="title serif">The same Patterns, at home on each phone.</h2>
        <p class="subtitle">
          On iPhone, Patterns {site.platforms.ios.shortVersion} was rebuilt from the ground up as a
          native app, so it uses the controls, text sizes, and gestures you already know. On
          Android, you get the same tools and the same privacy. The two apps look different. What
          you can do in them does not.
        </p>
      </div>
    </AnimatedOnScroll>

    <div class="switch" class:right={platform === 'android'} role="tablist" aria-label="Choose a platform">
      <span class="indicator" aria-hidden="true"></span>
      {#each tabs as tab (tab.id)}
        <button
          id="platform-tab-{tab.id}"
          type="button"
          role="tab"
          aria-selected={platform === tab.id}
          aria-controls="platform-panel"
          tabindex={platform === tab.id ? 0 : -1}
          onclick={() => (platform = tab.id)}
          onkeydown={onKeydown}
        >
          <BrandIcon icon={tab.id === 'ios' ? siApple : siAndroid} size={15} color="currentColor" />
          {tab.label}
          <span class="tab-version">{site.platforms[tab.id].shortVersion}</span>
        </button>
      {/each}
    </div>

    <div class="screen-tabs" role="group" aria-label="Choose a screen">
      {#each screens as screen, index (screen.id)}
        <button
          type="button"
          aria-pressed={active === index}
          aria-controls="platform-panel"
          onclick={() => (active = index)}
        >
          {screen.title}
        </button>
      {/each}
    </div>

    <div
      id="platform-panel"
      class="screens"
      role="tabpanel"
      aria-labelledby="platform-tab-{platform}"
      tabindex="-1"
    >
      {#each screens as screen, index (screen.id)}
        <figure class="screen" class:active={active === index} style="--i: {index}">
          {#key platform}
            <div class="device">
              <DeviceFrame
                {platform}
                src="/assets/screens/{platform}-{screen.id}.webp"
                alt="{screen.title} screen in Patterns for {platform === 'ios'
                  ? 'iPhone'
                  : 'Android'}, shown with demonstration data"
              />
            </div>
          {/key}
          <figcaption>
            <strong>{screen.title}</strong>
            <span>{screen.body}</span>
          </figcaption>
        </figure>
      {/each}
    </div>

    <p class="note">Real screens, captured with demonstration data.</p>
  </ContentContainer>
</section>

<style>
  .preview {
    background: var(--surface);
    border-block: 1px solid var(--border);
  }

  .header {
    max-width: 700px;
    margin: 0 auto;
    text-align: center;
  }

  .title {
    margin: 14px 0 0;
    font-size: clamp(32px, 4.4vw, 46px);
    line-height: 1.1;
  }

  .subtitle {
    margin: 18px auto 0;
    color: var(--text-secondary);
    font-size: 17px;
    line-height: 1.65;
  }

  /* Two equal tabs with a pill that slides between them. */
  .switch {
    position: relative;
    display: grid;
    grid-template-columns: 1fr 1fr;
    width: fit-content;
    margin: 36px auto 0;
    padding: 4px;
    border: 1px solid var(--border);
    border-radius: 999px;
    background: var(--bg);
  }

  .indicator {
    position: absolute;
    top: 4px;
    bottom: 4px;
    left: 4px;
    width: calc(50% - 4px);
    border-radius: 999px;
    background: var(--surface-alt);
    box-shadow: 0 0 0 1px var(--border);
    transition: transform 420ms var(--ease-out);
  }

  .switch.right .indicator {
    transform: translateX(100%);
  }

  .switch button {
    position: relative;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    min-height: 40px;
    padding: 0 20px;
    border-radius: 999px;
    color: var(--text-secondary);
    font-size: 14px;
    font-weight: 600;
    transition: color var(--dur) var(--ease-out);
  }

  .switch button:hover,
  .switch button[aria-selected='true'] {
    color: var(--text);
  }

  .switch button:focus-visible {
    outline: 3px solid var(--accent);
    outline-offset: 2px;
  }

  .tab-version {
    color: var(--text-secondary);
    font-weight: 500;
    font-variant-numeric: tabular-nums;
  }

  .screens {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 28px;
    margin-top: 48px;
  }

  .screens:focus {
    outline: none;
  }

  .screen {
    margin: 0;
  }

  /* On a platform switch each phone swaps in a beat after the one before. */
  .device {
    max-width: 240px;
    margin: 0 auto;
    /* backwards, not both: once finished it lets go so the hover lift works. */
    animation: screen-in 560ms var(--ease-out) backwards;
    animation-delay: calc(var(--i, 0) * 70ms);
    transition: transform 500ms var(--ease-out);
  }

  .screen:hover .device {
    transform: translateY(-6px);
  }

  @keyframes screen-in {
    from {
      opacity: 0;
      transform: translateY(14px) scale(0.98);
    }
    to {
      opacity: 1;
      transform: none;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .device {
      animation: none;
    }

    .indicator {
      transition: none;
    }

    .screen:hover .device {
      transform: none;
    }
  }

  figcaption {
    display: flex;
    flex-direction: column;
    gap: 4px;
    max-width: 240px;
    margin: 22px auto 0;
    text-align: center;
  }

  figcaption strong {
    font-size: 15px;
    font-weight: 600;
  }

  figcaption span {
    color: var(--text-secondary);
    font-size: 14px;
    line-height: 1.5;
  }

  .note {
    margin: 36px 0 0;
    color: var(--text-secondary);
    font-size: 12px;
    text-align: center;
  }

  .screen-tabs {
    display: none;
  }

  /* Small screens: one phone at a time, full size and centred, picked with
     a row of screen tabs. Nothing scrolls sideways or gets cut off. */
  @media (max-width: 899px) {
    .screen-tabs {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 8px;
      margin-top: 16px;
    }

    .screen-tabs button {
      min-height: 36px;
      padding: 0 14px;
      border: 1px solid var(--border);
      border-radius: 999px;
      color: var(--text-secondary);
      font-size: 13px;
      font-weight: 600;
      transition:
        color var(--dur) var(--ease-out),
        border-color var(--dur) var(--ease-out),
        background var(--dur) var(--ease-out);
    }

    .screen-tabs button[aria-pressed='true'] {
      border-color: color-mix(in srgb, var(--accent) 50%, var(--border));
      background: var(--accent-soft);
      color: var(--text);
    }

    .screen-tabs button:focus-visible {
      outline: 3px solid var(--accent);
      outline-offset: 2px;
    }

    .screens {
      grid-template-columns: 1fr;
      margin-top: 32px;
    }

    .screen:not(.active) {
      display: none;
    }

    .screen .device {
      max-width: min(78vw, 300px);
      animation-delay: 0ms;
    }

    figcaption {
      max-width: 300px;
    }
  }


  @media (max-width: 599px) {
    .subtitle {
      font-size: 16px;
    }
  }
</style>
