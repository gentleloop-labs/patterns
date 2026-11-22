<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import PrivacyContent from '$lib/sections/PrivacyContent.svelte';
  import { links } from '$lib/data/links';

  const jsonLd = [
    {
      '@context': 'https://schema.org',
      '@type': 'WebPage',
      name: 'Privacy Policy - Patterns',
      description:
        'Privacy policy for Patterns, a local-first OCD tracker and journaling app.',
      url: `${links.site}privacy`,
      isPartOf: { '@type': 'WebSite', name: 'Patterns', url: links.site }
    }
  ];
</script>

<Seo
  title="Privacy Policy - Patterns"
  description="Patterns privacy policy: personal OCD data stays on-device, with no accounts or cloud sync and optional privacy-preserving product analytics."
  path="privacy"
  {jsonLd}
/>

<PrivacyContent />

<div class="back-wrap">
  <a href="/">← Back to Home</a>
</div>

<style>
  .back-wrap {
    text-align: center;
    padding: 8px 0 72px;
    background: var(--bg);
  }

  .back-wrap a {
    color: var(--text-secondary);
    font-size: 14px;
    font-weight: 600;
    transition: color 0.2s;
  }

  .back-wrap a:hover {
    color: var(--text);
  }
</style>
