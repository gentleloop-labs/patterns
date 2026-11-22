<script lang="ts">
  import StoreLink from '$lib/components/StoreLink.svelte';
  import BrandIcon from '$lib/components/BrandIcon.svelte';
  import type { StorePlacement, StoreTarget } from '$lib/utils/analytics';
  import { siApple, siGoogleplay } from 'simple-icons';

  /** One store button style for the whole site, measured through StoreLink. */
  let {
    store,
    placement,
    newTab = true
  }: { store: StoreTarget; placement: StorePlacement; newTab?: boolean } = $props();
</script>

<StoreLink {store} {placement} {newTab} class="store-button">
  {#if store === 'app_store'}
    <BrandIcon icon={siApple} size={20} color="currentColor" />
    <span><small>Download on the</small><strong>App Store</strong></span>
  {:else}
    <BrandIcon icon={siGoogleplay} size={18} color="currentColor" />
    <span><small>Get it on</small><strong>Google Play</strong></span>
  {/if}
</StoreLink>

<style>
  :global(.store-button) {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    min-height: 48px;
    padding: 8px 18px 8px 14px;
    border: 1px solid var(--text);
    border-radius: 12px;
    background: var(--text);
    color: var(--bg);
    transition: opacity 0.2s;
  }

  :global(.store-button:hover) {
    opacity: 0.86;
  }

  :global(.store-button:focus-visible) {
    outline: 3px solid var(--accent);
    outline-offset: 3px;
  }

  :global(.store-button span) {
    display: flex;
    flex-direction: column;
    text-align: left;
  }

  :global(.store-button small) {
    font-size: 10px;
    line-height: 1.1;
    opacity: 0.8;
  }

  :global(.store-button strong) {
    font-size: 16px;
    font-weight: 600;
    line-height: 1.2;
    letter-spacing: -0.01em;
  }
</style>
