<script lang="ts">
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import { trustItems } from '$lib/data/homepage';
  import { ArrowRight, BookOpenCheck, Code2, HeartHandshake } from 'lucide-svelte';

  const icons = [HeartHandshake, BookOpenCheck, Code2];
</script>

<section id="trust" class="trust" aria-label="Why people can trust Patterns">
  <ContentContainer>
    <div class="grid">
      {#each trustItems as item, index}
        {@const Icon = icons[index]}
        <a class="item" href={item.href}>
          <span class="icon"><Icon size={21} strokeWidth={1.8} /></span>
          <span class="copy">
            <strong>{item.title}</strong>
            <span>{item.description}</span>
            <span class="link">{item.linkLabel} <ArrowRight size={14} /></span>
          </span>
        </a>
      {/each}
    </div>
  </ContentContainer>
</section>

<style>
  .trust {
    padding: 0 0 56px;
    background: var(--bg);
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    overflow: hidden;
    border: 1px solid color-mix(in srgb, var(--border) 65%, transparent);
    border-radius: 20px;
    background: var(--surface);
  }

  .item {
    display: flex;
    gap: 15px;
    padding: 24px;
    min-width: 0;
    transition: background 0.2s;
  }

  .item + .item {
    border-left: 1px solid color-mix(in srgb, var(--border) 65%, transparent);
  }

  .item:hover {
    background: color-mix(in srgb, var(--accent) 5%, var(--surface));
  }

  .item:focus-visible {
    outline: 2px solid var(--accent);
    outline-offset: -3px;
  }

  .icon {
    width: 42px;
    height: 42px;
    flex: 0 0 auto;
    display: grid;
    place-items: center;
    border-radius: 13px;
    color: var(--accent);
    background: color-mix(in srgb, var(--accent) 10%, transparent);
  }

  .copy,
  .copy > span,
  .copy > strong {
    display: block;
  }

  .copy strong {
    color: var(--text);
    font-size: 15px;
  }

  .copy > span:not(.link) {
    margin-top: 5px;
    color: var(--text-secondary);
    font-size: 13px;
    line-height: 1.45;
  }

  .link {
    display: inline-flex !important;
    align-items: center;
    gap: 5px;
    margin-top: 10px;
    color: var(--accent);
    font-size: 12px;
    font-weight: 700;
  }

  @media (max-width: 840px) {
    .grid {
      grid-template-columns: 1fr;
    }

    .item + .item {
      border-top: 1px solid color-mix(in srgb, var(--border) 65%, transparent);
      border-left: 0;
    }
  }

  @media (max-width: 599px) {
    .trust {
      padding-bottom: 40px;
    }

    .item {
      padding: 20px;
    }
  }
</style>
