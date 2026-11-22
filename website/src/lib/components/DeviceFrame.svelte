<script lang="ts">
  /**
   * A real app screen inside real hardware: Apple's iPhone 17 Pro frame and
   * Google's Pixel 10 Pro device art, composited offline into one transparent
   * WebP per screen (static/assets/screens). Android screens are captured on a
   * Pixel 10 Pro emulator so the status bar sits inside that phone's corners.
   */
  let {
    platform,
    src,
    alt,
    loading = 'lazy',
    fetchpriority
  }: {
    platform: 'ios' | 'android';
    src: string;
    alt: string;
    loading?: 'lazy' | 'eager';
    fetchpriority?: 'high' | 'low' | 'auto';
  } = $props();

  const size = $derived(
    platform === 'ios' ? { width: 640, height: 1308 } : { width: 640, height: 1347 }
  );
</script>

<img
  class="device"
  {src}
  {alt}
  width={size.width}
  height={size.height}
  {loading}
  {fetchpriority}
  decoding="async"
/>

<style>
  .device {
    display: block;
    width: 100%;
    height: auto;
    filter: drop-shadow(0 28px 36px rgba(20, 16, 8, 0.22)) drop-shadow(0 6px 10px rgba(20, 16, 8, 0.12));
  }

  :global([data-theme='dark']) .device {
    filter: drop-shadow(0 28px 40px rgba(0, 0, 0, 0.55)) drop-shadow(0 4px 10px rgba(0, 0, 0, 0.35));
  }
</style>
