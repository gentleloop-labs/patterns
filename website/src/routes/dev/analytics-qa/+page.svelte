<script lang="ts">
  import { onMount } from 'svelte';
  import StoreLink from '$lib/components/StoreLink.svelte';
  import { links } from '$lib/data/links';
  import {
    clearDebugLog,
    deviceCategory,
    getDebugLog,
    isGtagAvailable,
    resetStoreClickDedupe,
    subscribeDebug,
    type DebugEventRecord,
    type StorePlacement
  } from '$lib/utils/analytics';
  import { captureAttribution, clearAttribution, getAttribution, type Attribution } from '$lib/utils/attribution';

  /**
   * Analytics QA harness.
   *
   * Renders every store placement on one page and reports exactly what each tap
   * produces, without leaving the page: a capturing listener cancels the store
   * navigation and counts it instead. That is what makes "one navigation per
   * click" observable — in the real pages the anchor navigates away and takes
   * the evidence with it.
   *
   * Not linked from anywhere, `noindex`, and disallowed in robots.txt.
   */

  const placements: { placement: StorePlacement; note: string }[] = [
    { placement: 'hero', note: '/get store buttons and the homepage hero image overlay' },
    { placement: 'body', note: 'Download section badges on /' },
    { placement: 'sticky_banner', note: 'Mobile install banner' },
    { placement: 'footer', note: 'Reserved: no footer store link ships today' },
    { placement: 'qr_code', note: 'Desktop QR hand-off' }
  ];

  let events = $state<readonly DebugEventRecord[]>([]);
  let attribution = $state<Attribution>({});
  let device = $state<'mobile' | 'tablet' | 'desktop'>('desktop');
  let gtagReady = $state(false);

  /** Navigations the harness intercepted, keyed by destination URL. */
  let navigations = $state<{ url: string; at: number }[]>([]);

  let utmSource = $state('youtube');
  let utmMedium = $state('paid_video');
  let utmCampaign = $state('patterns_august');
  let utmContent = $state('creative_a');
  let utmTerm = $state('');

  const emitted = $derived(events.filter((event) => !event.suppressed));
  const suppressed = $derived(events.filter((event) => event.suppressed));
  const storeClicks = $derived(
    emitted.filter((event) => event.name === 'app_store_click' || event.name === 'play_store_click')
  );

  function refresh() {
    events = [...getDebugLog()];
    attribution = getAttribution();
    gtagReady = isGtagAvailable();
  }

  function applyUtms() {
    clearAttribution();
    const params = new URLSearchParams();
    if (utmSource) params.set('utm_source', utmSource);
    if (utmMedium) params.set('utm_medium', utmMedium);
    if (utmCampaign) params.set('utm_campaign', utmCampaign);
    if (utmContent) params.set('utm_content', utmContent);
    if (utmTerm) params.set('utm_term', utmTerm);
    captureAttribution(`?${params.toString()}`, '/dev/analytics-qa');
    refresh();
  }

  function resetAll() {
    clearDebugLog();
    clearAttribution();
    resetStoreClickDedupe();
    navigations = [];
    refresh();
  }

  onMount(() => {
    device = deviceCategory();
    refresh();
    const unsubscribe = subscribeDebug(refresh);

    // Must be the capture phase. StoreLink calls stopPropagation(), and Svelte 5
    // delegates from the document root, so a bubble-phase listener here would
    // never run and the store navigation would really happen. Capturing runs
    // first, and preventDefault does not stop propagation, so the delegated
    // handler still fires and the event is still reported.
    const onClick = (event: MouseEvent) => {
      const anchor = (event.target as HTMLElement | null)?.closest?.('a[href]');
      if (!anchor) return;
      const href = anchor.getAttribute('href') ?? '';
      if (!/^https?:/.test(href)) return;
      event.preventDefault();
      navigations = [{ url: href, at: Date.now() }, ...navigations].slice(0, 50);
    };
    document.addEventListener('click', onClick, true);

    const poll = window.setInterval(refresh, 1000);
    return () => {
      unsubscribe();
      document.removeEventListener('click', onClick, true);
      window.clearInterval(poll);
    };
  });
</script>

<svelte:head>
  <title>Analytics QA harness</title>
  <meta name="robots" content="noindex, nofollow" />
</svelte:head>

<main class="qa">
  <h1>Analytics QA harness</h1>
  <p class="lede">
    Every store placement, wired to the real <code>StoreLink</code> component. Store
    navigation is intercepted so the page stays put and each tap can be inspected.
  </p>

  <section>
    <h2>1. Test campaign</h2>
    <div class="fields">
      <label>utm_source <input data-testid="utm-source" bind:value={utmSource} /></label>
      <label>utm_medium <input data-testid="utm-medium" bind:value={utmMedium} /></label>
      <label>utm_campaign <input data-testid="utm-campaign" bind:value={utmCampaign} /></label>
      <label>utm_content <input data-testid="utm-content" bind:value={utmContent} /></label>
      <label>utm_term <input data-testid="utm-term" bind:value={utmTerm} /></label>
    </div>
    <div class="actions">
      <button type="button" data-testid="apply-utms" onclick={applyUtms}>Apply campaign</button>
      <button type="button" data-testid="reset" onclick={resetAll}>Reset everything</button>
    </div>
    <p class="hint">
      Applying replaces the stored attribution so you can retest. In the real site the
      first campaign of the session wins and cannot be overwritten.
    </p>
  </section>

  <section>
    <h2>2. Environment</h2>
    <dl class="kv">
      <dt>Detected device</dt>
      <dd data-testid="device">{device}</dd>
      <dt>GA4 tag</dt>
      <dd data-testid="gtag-state">{gtagReady ? 'available' : 'not loaded or blocked'}</dd>
      <dt>Stored attribution</dt>
      <dd data-testid="attribution">
        {attribution.source ? JSON.stringify(attribution) : 'direct / unattributed'}
      </dd>
    </dl>
  </section>

  <section>
    <h2>3. Placements</h2>
    <table class="placements">
      <thead>
        <tr><th>Placement</th><th>App Store</th><th>Google Play</th><th>Used by</th></tr>
      </thead>
      <tbody>
        {#each placements as row}
          <tr>
            <td><code>{row.placement}</code></td>
            <td>
              <StoreLink
                store="app_store"
                placement={row.placement}
                class="qa-btn"
                ariaLabel={`App Store, ${row.placement}`}
              >App Store</StoreLink>
            </td>
            <td>
              <StoreLink
                store="play_store"
                placement={row.placement}
                class="qa-btn"
                ariaLabel={`Google Play, ${row.placement}`}
              >Google Play</StoreLink>
            </td>
            <td class="note">{row.note}</td>
          </tr>
        {/each}
      </tbody>
    </table>
  </section>

  <section>
    <h2>4. Results</h2>
    <dl class="kv">
      <dt>Store click events</dt>
      <dd data-testid="store-click-count">{storeClicks.length}</dd>
      <dt>Navigations intercepted</dt>
      <dd data-testid="navigation-count">{navigations.length}</dd>
      <dt>Duplicates blocked</dt>
      <dd data-testid="suppressed-count">{suppressed.length}</dd>
    </dl>
    {#if storeClicks.length > 0 && storeClicks.length !== navigations.length}
      <p class="alarm" data-testid="mismatch">
        Mismatch: {storeClicks.length} store click event(s) vs {navigations.length}
        navigation(s). Expect exactly one navigation per store click event.
      </p>
    {/if}
  </section>

  <section>
    <h2>5. Event log</h2>
    <p class="hint">Most recent first. Suppressed rows are duplicate taps the dedupe window blocked.</p>
    <ol class="log" data-testid="event-log">
      {#each events as event}
        <li class:suppressed={event.suppressed}>
          <div class="log-head">
            <code>{event.name}</code>
            {#if event.suppressed}<span class="tag">suppressed duplicate</span>{/if}
            {#if !event.gtagAvailable}<span class="tag">gtag unavailable</span>{/if}
          </div>
          <pre>{JSON.stringify(event.params, null, 1)}</pre>
        </li>
      {:else}
        <li class="empty">No events yet. Tap a store button above.</li>
      {/each}
    </ol>
  </section>

  <section>
    <h2>6. Destinations</h2>
    <dl class="kv">
      <dt>App Store</dt>
      <dd><code>{links.ios}</code></dd>
      <dt>Google Play</dt>
      <dd><code>{links.playStore}</code></dd>
      <dt>QR target</dt>
      <dd><img src="/assets/qr-get.svg" alt="QR code for the /get landing page" width="96" height="96" /></dd>
    </dl>
  </section>
</main>

<style>
  .qa {
    max-width: 900px;
    margin: 0 auto;
    padding: 32px 20px 80px;
    font-size: 14px;
    color: var(--text);
  }

  h1 {
    font-size: 24px;
    margin: 0 0 6px;
  }

  h2 {
    font-size: 15px;
    margin: 0 0 10px;
    color: var(--text-secondary);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .lede {
    margin: 0 0 28px;
    color: var(--text-secondary);
  }

  section {
    margin-bottom: 32px;
    padding: 18px;
    border-radius: 12px;
    border: 1px solid var(--border);
    background: color-mix(in srgb, var(--surface) 60%, transparent);
  }

  .fields {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 10px;
  }

  label {
    display: flex;
    flex-direction: column;
    gap: 4px;
    font-size: 12px;
    color: var(--text-secondary);
  }

  input {
    padding: 7px 9px;
    border-radius: 7px;
    border: 1px solid var(--border);
    background: var(--bg);
    color: var(--text);
    font-family: ui-monospace, monospace;
    font-size: 12px;
  }

  .actions {
    display: flex;
    gap: 10px;
    margin-top: 14px;
  }

  button {
    padding: 8px 14px;
    border-radius: 8px;
    border: 1px solid var(--border);
    background: var(--surface-alt);
    color: var(--text);
    font-size: 13px;
    font-weight: 600;
  }

  .hint {
    margin: 12px 0 0;
    font-size: 12px;
    color: var(--text-secondary);
  }

  .kv {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 6px 16px;
    margin: 0;
  }

  .kv dt {
    color: var(--text-secondary);
    white-space: nowrap;
  }

  .kv dd {
    margin: 0;
    overflow-wrap: anywhere;
    font-family: ui-monospace, monospace;
    font-size: 12px;
  }

  .placements {
    width: 100%;
    border-collapse: collapse;
  }

  .placements th {
    text-align: left;
    font-size: 12px;
    color: var(--text-secondary);
    padding: 6px 8px;
    border-bottom: 1px solid var(--border);
  }

  .placements td {
    padding: 8px;
    border-bottom: 1px solid color-mix(in srgb, var(--border) 50%, transparent);
    vertical-align: middle;
  }

  .note {
    font-size: 12px;
    color: var(--text-secondary);
  }

  .placements :global(.qa-btn) {
    display: inline-block;
    padding: 7px 12px;
    border-radius: 8px;
    background: #000;
    border: 1px solid color-mix(in srgb, #fff 22%, transparent);
    color: #fff;
    font-size: 12px;
    white-space: nowrap;
  }

  .placements :global(.qa-btn:focus-visible) {
    outline: 3px solid var(--accent);
    outline-offset: 2px;
  }

  .log {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: 8px;
  }

  .log li {
    padding: 10px;
    border-radius: 8px;
    border: 1px solid var(--border);
    background: var(--bg);
  }

  .log li.suppressed {
    opacity: 0.6;
    border-style: dashed;
  }

  .log-head {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-wrap: wrap;
    margin-bottom: 6px;
  }

  .tag {
    padding: 1px 7px;
    border-radius: 100px;
    font-size: 10px;
    font-weight: 700;
    text-transform: uppercase;
    color: #000;
    background: var(--accent);
  }

  .log .empty {
    color: var(--text-secondary);
    border-style: dashed;
  }

  pre {
    margin: 0;
    font-family: ui-monospace, monospace;
    font-size: 11px;
    white-space: pre-wrap;
    overflow-wrap: anywhere;
  }

  code {
    font-family: ui-monospace, monospace;
    font-size: 12px;
  }

  .alarm {
    margin: 12px 0 0;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid var(--accent);
    color: var(--accent);
    font-size: 12px;
  }
</style>
