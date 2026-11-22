<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import AnimatedOnScroll from '$lib/components/AnimatedOnScroll.svelte';
  import { links } from '$lib/data/links';
  import { logEvent } from '$lib/utils/analytics';
  import { Coffee, Heart } from 'lucide-svelte';

  function tipKofi() {
    logEvent('kofi_click', { source: 'support_section' });
    window.open(links.kofi, '_blank', 'noopener');
  }

  function sponsorGitHub() {
    logEvent('sponsor_click', { source: 'support_section' });
    window.open(links.sponsors, '_blank', 'noopener');
  }
</script>

<section id="support" class="support content-below-fold" aria-labelledby="support-title">
  <ContentContainer padding="0">
    <AnimatedOnScroll>
      <!-- A quiet closing line on the Download section's own background, so it
           reads as part of that section rather than a separate panel. -->
      <div class="row">
        <h2 id="support-title">Support Patterns</h2>
        <p>
          Patterns is open source, independent, and ad-free. If it has helped you, a small
          contribution keeps development going.
        </p>
        <div class="actions">
          <button type="button" class="btn" onclick={tipKofi}>
            <Coffee size={16} strokeWidth={2} />
            <span>Tip on Ko-fi</span>
          </button>
          <button type="button" class="btn" onclick={sponsorGitHub}>
            <Heart size={15} strokeWidth={2} />
            <span>Sponsor on GitHub</span>
          </button>
        </div>
      </div>
    </AnimatedOnScroll>
  </ContentContainer>
</section>

<style>
  .support {
    padding: 0 0 88px;
    background: var(--surface);
  }

  .row {
    max-width: 560px;
    margin: 0 auto;
    padding-top: 48px;
    border-top: 1px solid var(--border);
    text-align: center;
  }

  h2 {
    margin: 0;
    font-family: var(--font-body);
    font-size: 16px;
    font-weight: 600;
    letter-spacing: -0.01em;
  }

  p {
    margin: 8px 0 0;
    color: var(--text-secondary);
    font-size: 15px;
    line-height: 1.6;
  }

  .actions {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
  }

  .btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    min-height: 44px;
    padding: 0 16px;
    border: 1px solid var(--border);
    border-radius: 12px;
    background: transparent;
    color: var(--text);
    font-size: 14px;
    font-weight: 600;
    transition: border-color 0.2s;
  }

  .btn:hover {
    border-color: color-mix(in srgb, var(--text) 35%, transparent);
  }

  .btn:focus-visible {
    outline: 3px solid var(--accent);
    outline-offset: 3px;
  }
</style>
