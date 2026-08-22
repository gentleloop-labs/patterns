<script lang="ts">
  import { onMount } from 'svelte';
  import {
    deviceCategory,
    getDebugLog,
    getLastStoreNavigation,
    isGtagAvailable,
    subscribeDebug,
    type DebugEventRecord,
    type StoreNavigationRecord
  } from '$lib/utils/analytics';
  import { getAttribution, type Attribution } from '$lib/utils/attribution';
  import { getReferral } from '$lib/utils/referral';

  /**
   * Diagnostics for `?analytics_debug=1`, safe to ship to production.
   *
   * It is opt-in per page load, never persisted, and reads only values this
   * site already produced: the campaign UTMs from the visitor's own URL and the
   * events this page just emitted. It shows no personal data, no identifiers,
   * and nothing from any other origin.
   */
  let visible = $state(false);
  let collapsed = $state(false);
  let device = $state<'mobile' | 'tablet' | 'desktop'>('desktop');
  let attribution = $state<Attribution>({});
  let referral = $state<string | undefined>();
  let gtagReady = $state(false);
  let events = $state<readonly DebugEventRecord[]>([]);
  let navigation = $state<StoreNavigationRecord | null>(null);

  // Skips the deprecated `download` shadow so the panel reports the canonical
  // conversion event, which is the one you are actually verifying.
  const last = $derived(events.find((event) => !event.suppressed && !event.legacy));
  const duplicates = $derived(events.filter((event) => event.suppressed).length);

  function refresh() {
    events = [...getDebugLog()];
    gtagReady = isGtagAvailable();
    navigation = getLastStoreNavigation();
    attribution = getAttribution();
    referral = getReferral();
  }

  onMount(() => {
    if (new URLSearchParams(window.location.search).get('analytics_debug') !== '1') return;
    visible = true;
    device = deviceCategory();
    refresh();

    const unsubscribe = subscribeDebug(refresh);
    // The GA4 tag loads on idle, so poll briefly for it to become available.
    const poll = window.setInterval(refresh, 1000);
    return () => {
      unsubscribe();
      window.clearInterval(poll);
    };
  });
</script>

{#if visible}
  <aside class="panel" class:collapsed aria-label="Analytics diagnostics">
    <header>
      <strong>Analytics debug</strong>
      <button type="button" onclick={() => (collapsed = !collapsed)}>
        {collapsed ? 'Show' : 'Hide'}
      </button>
    </header>

    {#if !collapsed}
      <dl>
        <dt>Device</dt>
        <dd>{device}</dd>

        <dt>GA4 tag</dt>
        <dd class={gtagReady ? 'ok' : 'warn'}>
          {gtagReady ? 'available' : 'not loaded or blocked'}
        </dd>

        <dt>Attribution</dt>
        <dd>
          {#if attribution.source}
            <code>{attribution.source}</code> / <code>{attribution.medium ?? '(none)'}</code>
            <br />campaign: <code>{attribution.campaign ?? '(none)'}</code>
            <br />content: <code>{attribution.content ?? '(none)'}</code>
            <br />landed on: <code>{attribution.landing_page ?? '(none)'}</code>
          {:else}
            <em>direct / unattributed</em>
          {/if}
          {#if referral}
            <br />ref: <code>{referral}</code>
          {/if}
        </dd>

        <dt>Last event</dt>
        <dd>
          {#if last}
            <code>{last.name}</code>
          {:else}
            <em>none yet</em>
          {/if}
        </dd>

        <dt>Payload</dt>
        <dd>
          {#if last}
            <pre>{JSON.stringify(last.params, null, 1)}</pre>
          {:else}
            <em>-</em>
          {/if}
        </dd>

        <dt>Duplicates blocked</dt>
        <dd class={duplicates > 0 ? 'warn' : 'ok'}>{duplicates}</dd>

        <dt>Navigation</dt>
        <dd>
          {#if navigation}
            <span class={navigation.confirmed ? 'ok' : 'warn'}>
              {navigation.confirmed ? 'confirmed' : 'pending'}
            </span>
            <br /><code>{navigation.store}</code>
          {:else}
            <em>no store click yet</em>
          {/if}
        </dd>
      </dl>
    {/if}
  </aside>
{/if}

<style>
  .panel {
    position: fixed;
    right: 8px;
    bottom: calc(8px + env(safe-area-inset-bottom, 0px));
    z-index: 9999;
    width: min(320px, calc(100vw - 16px));
    max-height: 70svh;
    overflow: auto;
    padding: 10px 12px;
    border-radius: 10px;
    border: 1px solid var(--border);
    background: color-mix(in srgb, var(--surface) 96%, transparent);
    backdrop-filter: blur(12px);
    box-shadow: 0 8px 32px color-mix(in srgb, #000 45%, transparent);
    font-size: 11px;
    line-height: 1.4;
    color: var(--text);
  }

  header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 8px;
  }

  header button {
    padding: 2px 8px;
    border-radius: 6px;
    border: 1px solid var(--border);
    color: var(--text-secondary);
    font-size: 11px;
  }

  dl {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 4px 10px;
    margin: 10px 0 0;
  }

  dt {
    color: var(--text-secondary);
    white-space: nowrap;
  }

  dd {
    margin: 0;
    min-width: 0;
    overflow-wrap: anywhere;
  }

  code {
    font-family: ui-monospace, monospace;
    font-size: 10.5px;
  }

  pre {
    margin: 0;
    font-family: ui-monospace, monospace;
    font-size: 10px;
    white-space: pre-wrap;
    overflow-wrap: anywhere;
  }

  .ok {
    color: #4ade80;
  }

  .warn {
    color: var(--accent);
  }
</style>
