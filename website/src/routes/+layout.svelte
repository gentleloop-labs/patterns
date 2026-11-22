<script lang="ts">
  import { onMount } from 'svelte';
  import { afterNavigate, onNavigate } from '$app/navigation';
  import { page } from '$app/stores';
  import { captureAttribution } from '$lib/utils/attribution';
  import { captureReferral } from '$lib/utils/referral';
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

  // Campaign params and creator referrals are captured on every entry, not just
  // /get, and the first valid one wins for the session - so a visitor who lands
  // on an ad or creator URL and then browses to /erp still has their store click
  // credited to that visit.
  afterNavigate(() => {
    captureAttribution(window.location.search, window.location.pathname);
    captureReferral(window.location.search);
  });

  // Soft crossfade between pages where the browser supports view transitions.
  // Skipped for in-page hash jumps and for anyone who prefers reduced motion.
  onNavigate((navigation) => {
    if (!document.startViewTransition) return;
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
    if (navigation.from?.url.pathname === navigation.to?.url.pathname) return;

    return new Promise((resolve) => {
      document.startViewTransition(async () => {
        resolve();
        await navigation.complete;
      });
    });
  });

  onMount(() => {
    captureAttribution(window.location.search, window.location.pathname);
    captureReferral(window.location.search);
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
  <!-- Global chrome only. Title/description/canonical/OG/robots/JSON-LD come
       from <Seo> on each public route. /dev pages set their own noindex. -->
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="author" content="Aftaab Siddiqui" />
  <meta name="application-name" content="Patterns" />
  <meta name="theme-color" content="#0F0F0E" media="(prefers-color-scheme: dark)" />
  <meta name="theme-color" content="#FAF9F6" media="(prefers-color-scheme: light)" />
  <meta name="color-scheme" content="dark light" />
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
