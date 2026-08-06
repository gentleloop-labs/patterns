<script lang="ts">
  import { onMount } from 'svelte';
  import { afterNavigate } from '$app/navigation';
  import { page } from '$app/stores';
  import { captureAttribution } from '$lib/utils/attribution';
  import '../app.css';
  import AnalyticsDebugPanel from '$lib/components/AnalyticsDebugPanel.svelte';
  import AppInstallBanner from '$lib/components/AppInstallBanner.svelte';
  import Navbar from '$lib/components/Navbar.svelte';
  import { theme } from '$lib/stores/theme';

  let { children } = $props();

  // Dedicated ad/landing routes render "bare": no navbar or install banner, so the
  // page is a clean, distraction-free destination with store links front and centre.
  const bareRoutes = ['/get'];
  const bare = $derived(bareRoutes.includes($page.url.pathname.replace(/\/$/, '') || '/'));

  // Internal tooling under /dev sets its own noindex tag. Emitting the global
  // index directive here too would leave the page with two conflicting robots
  // metas, and crawlers may honour either one.
  const internal = $derived($page.url.pathname.startsWith('/dev'));

  // Campaign params are captured on every entry, not just /get, and the first
  // valid one wins for the session — so a visitor who lands on an ad URL and
  // then browses to /erp still has their store click credited to the ad.
  afterNavigate(() => {
    captureAttribution(window.location.search, window.location.pathname);
  });

  onMount(() => {
    captureAttribution(window.location.search, window.location.pathname);
    theme.init();

    if (window.location.hash === '#/privacy') {
      window.history.replaceState(null, '', '/privacy');
      window.location.href = '/privacy';
    }

    if ($page.url.hash) {
      const id = $page.url.hash.slice(1);
      requestAnimationFrame(() => {
        document.getElementById(id)?.scrollIntoView({ behavior: 'smooth' });
      });
    }
  });
</script>

<svelte:head>
  <!-- Global, always-on tags. Per-page title/description/canonical/OG/JSON-LD
       are set by the <Seo> component in each route. -->
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="author" content="MaskedSyntax" />
  {#if !internal}
    <meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1" />
    <meta name="googlebot" content="index, follow, max-image-preview:large, max-snippet:-1" />
  {/if}
  <meta name="application-name" content="Patterns" />
  <meta name="theme-color" content="#0A0A0A" />
  <meta name="color-scheme" content="dark light" />
  <meta property="og:site_name" content="Patterns" />
  <meta property="og:locale" content="en_US" />
  <meta name="mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  <meta name="apple-mobile-web-app-title" content="Patterns" />
</svelte:head>

{#if bare}
  {@render children()}
{:else}
  <Navbar />
  <AppInstallBanner />
  <main>
    {@render children()}
  </main>
{/if}

<!-- Renders nothing unless ?analytics_debug=1 is on the URL. -->
<AnalyticsDebugPanel />

<style>
  main {
    padding-top: 68px;
  }
</style>
