import { defineConfig, devices } from '@playwright/test';

/**
 * Browser tests run against the real production build, not the dev server, so
 * what is verified is the artifact that actually deploys — including the
 * prerendered HTML and the pre-paint platform detection script.
 */
export default defineConfig({
  testDir: './e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  reporter: process.env.CI ? 'line' : [['list']],
  use: {
    baseURL: 'http://localhost:4173',
    trace: 'on-first-retry'
  },
  webServer: {
    command: 'npm run build && npx vite preview --port 4173 --strictPort',
    url: 'http://localhost:4173/get',
    reuseExistingServer: !process.env.CI,
    timeout: 120_000
  },
  projects: [
    {
      name: 'desktop-chrome',
      use: { ...devices['Desktop Chrome'], viewport: { width: 1280, height: 800 } }
    },
    {
      // Chromium emulating iPhone metrics + UA, so data-platform resolves to ios.
      name: 'iphone',
      use: { ...devices['iPhone 13'], browserName: 'chromium' }
    },
    {
      name: 'android',
      use: { ...devices['Pixel 5'], browserName: 'chromium' }
    }
  ]
});
