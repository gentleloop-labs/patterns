import { fileURLToPath } from 'node:url';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import { defineConfig } from 'vitest/config';

export default defineConfig({
  plugins: [svelte({ hot: false })],
  resolve: {
    // Mirrors the SvelteKit alias so tests import the same modules the app does.
    alias: {
      $lib: fileURLToPath(new URL('./src/lib', import.meta.url))
    },
    // Component tests run the browser build of Svelte under jsdom.
    conditions: ['browser']
  },
  test: {
    environment: 'jsdom',
    include: ['src/**/*.test.ts'],
    globals: false
  }
});
