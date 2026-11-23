<script lang="ts" module>
  // Blocks still waiting to appear, each with the callback that reveals it.
  const pending = new Map<HTMLElement, () => void>();
  let ticking = false;

  // Reveal anything that has reached, or already passed, a point a little
  // below the screen. Checking on every scroll frame matters: a fast scroll
  // can carry a block from below the screen to above it between two frames,
  // and an IntersectionObserver never reports a crossing it did not see.
  function check() {
    ticking = false;
    const limit = window.innerHeight * 1.2;
    for (const [el, reveal] of pending) {
      if (el.getBoundingClientRect().top < limit) {
        pending.delete(el);
        reveal();
      }
    }
    if (pending.size === 0) window.removeEventListener('scroll', onScroll);
  }

  function onScroll() {
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(check);
  }

  function watch(el: HTMLElement, reveal: () => void) {
    if (pending.size === 0) window.addEventListener('scroll', onScroll, { passive: true });
    pending.set(el, reveal);
    check();
    return () => pending.delete(el);
  }
</script>

<script lang="ts">
  import type { Snippet } from 'svelte';

  let { children }: { children: Snippet } = $props();

  let visible = $state(false);
  let el: HTMLElement;

  $effect(() => {
    if (!el) return;
    return watch(el, () => (visible = true));
  });
</script>

<div bind:this={el} class="animate-on-scroll" class:visible>
  {@render children()}
</div>
