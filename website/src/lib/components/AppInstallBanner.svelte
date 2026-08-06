<script lang="ts">
  import { onMount } from 'svelte';
  import { X } from 'lucide-svelte';
  import StoreLink from '$lib/components/StoreLink.svelte';
  import { logEvent } from '$lib/utils/analytics';
  import {
    dismissInstallBanner,
    isAndroid,
    shouldShowCustomInstallBanner
  } from '$lib/utils/platform';

  let visible = $state(false);

  const store = $derived(isAndroid() ? ('play_store' as const) : ('app_store' as const));
  const storeLabel = $derived(isAndroid() ? 'Google Play' : 'App Store');

  onMount(() => {
    visible = shouldShowCustomInstallBanner();
    if (visible) {
      logEvent('app_install_banner_view', { platform: isAndroid() ? 'android' : 'ios' });
      document.body.classList.add('has-install-banner');
    }

    return () => {
      document.body.classList.remove('has-install-banner');
    };
  });

  // The banner's own view/dismiss events stay; the store click itself is emitted
  // by <StoreLink> so it is counted the same way as every other placement.
  function handleDismiss() {
    dismissInstallBanner();
    visible = false;
    document.body.classList.remove('has-install-banner');
    logEvent('app_install_banner_dismiss', { platform: isAndroid() ? 'android' : 'ios' });
  }
</script>

{#if visible}
  <aside class="install-banner" aria-label="Get the Patterns app">
    <img src="/assets/logo.png" alt="" width="44" height="44" class="icon" />
    <div class="copy">
      <strong>Patterns</strong>
      <span>OCD tracker & journal · {storeLabel}</span>
    </div>
    <StoreLink {store} placement="sticky_banner" class="install-btn">Get</StoreLink>
    <button type="button" class="dismiss-btn" aria-label="Dismiss app install banner" onclick={handleDismiss}>
      <X size={18} />
    </button>
  </aside>
{/if}

<style>
  .install-banner {
    position: fixed;
    left: 12px;
    right: 12px;
    bottom: calc(12px + env(safe-area-inset-bottom, 0px));
    z-index: 200;
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 14px;
    border-radius: 14px;
    border: 1px solid var(--border);
    background: color-mix(in srgb, var(--surface) 94%, transparent);
    backdrop-filter: blur(16px);
    box-shadow: 0 8px 32px color-mix(in srgb, #000 35%, transparent);
  }

  .icon {
    flex-shrink: 0;
    border-radius: 10px;
  }

  .copy {
    flex: 1;
    min-width: 0;
    display: flex;
    flex-direction: column;
    gap: 2px;
  }

  .copy strong {
    font-size: 15px;
    font-weight: 600;
    color: var(--text);
  }

  .copy span {
    font-size: 12px;
    color: var(--text-secondary);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  /* :global because the anchor is rendered by <StoreLink>. */
  .install-banner :global(.install-btn) {
    flex-shrink: 0;
    display: inline-flex;
    align-items: center;
    padding: 8px 16px;
    border-radius: 999px;
    font-size: 14px;
    font-weight: 700;
    color: #000;
    background: var(--accent);
  }

  .install-banner :global(.install-btn:focus-visible) {
    outline: 3px solid var(--text);
    outline-offset: 2px;
  }

  .dismiss-btn {
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 4px;
    color: var(--text-secondary);
  }
</style>
