<script lang="ts">
  import type { Snippet } from 'svelte';
  import { links } from '$lib/data/links';
  import { trackStoreClick, type StorePlacement, type StoreTarget } from '$lib/utils/analytics';

  /**
   * The single path by which a store link is rendered and measured.
   *
   * Every App Store / Play Store destination on the site goes through here, so
   * there is exactly one click handler per link (no anchor-plus-window.open
   * double navigation) and every click is stamped with placement and campaign.
   */
  let {
    store,
    placement,
    newTab = false,
    class: className = '',
    ariaLabel,
    children
  }: {
    store: StoreTarget;
    placement: StorePlacement;
    /** Leave false on landing pages: same-tab hand-off is the most reliable way
        out of an in-app webview into the native store app. */
    newTab?: boolean;
    class?: string;
    ariaLabel?: string;
    children?: Snippet;
  } = $props();

  const href = $derived(store === 'app_store' ? links.ios : links.playStore);
  const label = $derived(
    ariaLabel ??
      (store === 'app_store'
        ? 'Download Patterns on the App Store'
        : 'Get Patterns on Google Play')
  );

  function handleClick(event: MouseEvent) {
    // Stop a wrapping card/section handler from re-reporting the same tap.
    event.stopPropagation();
    trackStoreClick(store, placement, href);
    // No preventDefault: the anchor's own navigation is the only navigation.
  }
</script>

<a
  {href}
  class={className}
  aria-label={label}
  rel={newTab ? 'noopener noreferrer' : 'noopener'}
  target={newTab ? '_blank' : undefined}
  onclick={handleClick}
>
  {@render children?.()}
</a>
