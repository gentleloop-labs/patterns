import { expect, test } from '@playwright/test';
import {
  APP_STORE_LABEL,
  PLAY_STORE_LABEL,
  blockAnalytics,
  recordEvents,
  stubStores,
  type EventRecorder
} from './helpers';

const CAMPAIGN_URL =
  '/get?utm_source=youtube&utm_medium=paid_video&utm_campaign=patterns_august&utm_content=creative_a';

/** The exact parameter set `app_store_click` / `play_store_click` may carry. */
const APPROVED_PARAMS = new Set([
  'placement',
  'page_path',
  'click_campaign',
  'click_source',
  'click_medium',
  'click_content',
  'click_term',
  'device_category',
  'destination_store',
  'external_url',
  'app_platform',
  'transport_type'
]);

test.describe('store click events', () => {
  let events: EventRecorder;

  test.beforeEach(async ({ page }) => {
    events = await recordEvents(page);
    await stubStores(page);
  });

  test('an App Store tap emits app_store_click exactly once', async ({ page }) => {
    await page.goto(CAMPAIGN_URL);
    await page.getByRole('link', { name: APP_STORE_LABEL }).click();
    await page.waitForURL(/apps\.apple\.com/);

    expect(events.named('app_store_click')).toHaveLength(1);
    expect(events.named('play_store_click')).toHaveLength(0);
  });

  test('a Google Play tap emits play_store_click exactly once', async ({ page }) => {
    await page.goto(CAMPAIGN_URL);
    await page.getByRole('link', { name: PLAY_STORE_LABEL }).click();
    await page.waitForURL(/play\.google\.com/);

    expect(events.named('play_store_click')).toHaveLength(1);
    expect(events.named('app_store_click')).toHaveLength(0);
  });

  test('the payload carries placement, store and campaign', async ({ page }) => {
    await page.goto(CAMPAIGN_URL);
    await page.getByRole('link', { name: APP_STORE_LABEL }).click();
    await page.waitForURL(/apps\.apple\.com/);

    const [event] = events.named('app_store_click');
    expect(event.params).toMatchObject({
      placement: 'hero',
      destination_store: 'app_store',
      app_platform: 'ios',
      click_source: 'youtube',
      click_medium: 'paid_video',
      click_campaign: 'patterns_august',
      click_content: 'creative_a',
      transport_type: 'beacon'
    });
    expect(event.params.external_url).toContain('apps.apple.com');
    expect(['mobile', 'tablet', 'desktop']).toContain(event.params.device_category);
  });

  test('sends no parameter outside the approved set', async ({ page }) => {
    await page.goto(CAMPAIGN_URL);
    await page.getByRole('link', { name: PLAY_STORE_LABEL }).click();
    await page.waitForURL(/play\.google\.com/);

    const [event] = events.named('play_store_click');
    for (const key of Object.keys(event.params)) {
      expect(APPROVED_PARAMS.has(key), `unexpected parameter "${key}"`).toBe(true);
    }
    // GA4 caps events at 25 parameters.
    expect(Object.keys(event.params).length).toBeLessThanOrEqual(25);
  });

  test('a hostile utm value cannot smuggle prose into the payload', async ({ page }) => {
    const prose = 'i keep checking the stove because i am afraid of a fire and it never stops';
    await page.goto(`/get?utm_source=youtube&utm_content=${encodeURIComponent(prose)}`);
    await page.getByRole('link', { name: APP_STORE_LABEL }).click();
    await page.waitForURL(/apps\.apple\.com/);

    const [event] = events.named('app_store_click');
    // Capped at the GA4 parameter limit rather than shipped whole.
    expect(String(event.params.click_content).length).toBeLessThanOrEqual(100);
  });

  test('one tap opens exactly one destination, never two tabs', async ({ page, context }) => {
    const opened: string[] = [];
    context.on('page', (popup) => opened.push(popup.url()));

    await page.goto('/get');
    await page.getByRole('link', { name: APP_STORE_LABEL }).click();
    await page.waitForURL(/apps\.apple\.com/);
    await page.waitForTimeout(300);

    // Same-tab hand-off on /get: the current tab navigated and nothing popped.
    expect(opened).toHaveLength(0);
    expect(page.url()).toContain('apps.apple.com');
  });

  test('the homepage hero opens one new tab, not two', async ({ page, context }, testInfo) => {
    test.skip(testInfo.project.name !== 'desktop-chrome', 'hero hotspots are desktop-only');
    await page.goto('/');

    const popupPromise = context.waitForEvent('page');
    await page.locator('#hero').getByRole('link', { name: APP_STORE_LABEL }).click();
    const popup = await popupPromise;
    await page.waitForTimeout(500);

    expect(context.pages()).toHaveLength(2);
    expect(popup.url()).toContain('apps.apple.com');
    // The original page did not also navigate.
    expect(page.url()).not.toContain('apps.apple.com');
    expect(events.named('app_store_click')).toHaveLength(1);
  });

  test('the hero image hotspots are not exposed on mobile', async ({ page }, testInfo) => {
    test.skip(testInfo.project.name === 'desktop-chrome', 'mobile only');
    await page.goto('/');

    // They would scale down to ~57x16px and sit under the sticky install
    // banner, so they are hidden rather than shipped as a dead tap target.
    await expect(page.locator('#hero').getByRole('link', { name: APP_STORE_LABEL })).toBeHidden();
  });

  test('the mobile install banner reaches the store in one navigation', async ({ page }, testInfo) => {
    test.skip(testInfo.project.name === 'desktop-chrome', 'mobile only');
    await page.goto('/');

    const banner = page.getByLabel('Get the Patterns app');
    await expect(banner).toBeVisible();
    await banner.getByRole('link').click();
    await page.waitForURL(/apps\.apple\.com|play\.google\.com/);

    const clicks = [
      ...events.named('app_store_click'),
      ...events.named('play_store_click')
    ];
    expect(clicks).toHaveLength(1);
    expect(clicks[0].params.placement).toBe('sticky_banner');
  });

  test('the download section badges work on mobile', async ({ page, context }, testInfo) => {
    test.skip(testInfo.project.name === 'desktop-chrome', 'mobile only');
    await page.goto('/');

    const popupPromise = context.waitForEvent('page');
    await page.locator('#download').getByRole('link', { name: PLAY_STORE_LABEL }).click();
    await popupPromise;

    const [event] = events.named('play_store_click');
    expect(event.params.placement).toBe('body');
  });

  test('a fast double tap is counted once', async ({ page }) => {
    await page.goto('/get');
    // Cancel navigation so the repeat taps land on the same page.
    await page.evaluate(() =>
      document.addEventListener('click', (event) => event.preventDefault(), true)
    );

    const link = page.getByRole('link', { name: PLAY_STORE_LABEL });
    await link.click();
    await link.click();
    await link.click();

    expect(events.named('play_store_click')).toHaveLength(1);
  });
});

test.describe('campaign attribution across navigation', () => {
  let events: EventRecorder;

  test.beforeEach(async ({ page }) => {
    events = await recordEvents(page);
    await stubStores(page);
  });

  test('is retained after navigating away from /get', async ({ page, context }) => {
    await page.goto(CAMPAIGN_URL);
    // Leave the landing page for a page with no campaign parameters at all.
    await page.goto('/');
    expect(page.url()).not.toContain('utm_');

    const popupPromise = context.waitForEvent('page');
    await page.locator('#download').getByRole('link', { name: PLAY_STORE_LABEL }).click();
    await popupPromise;

    const [event] = events.named('play_store_click');
    expect(event.params).toMatchObject({
      click_source: 'youtube',
      click_medium: 'paid_video',
      click_campaign: 'patterns_august',
      click_content: 'creative_a'
    });
    // Placement reflects where the click happened, not where they landed.
    expect(event.params.placement).toBe('body');
  });

  test('a later campaign does not overwrite the first', async ({ page }) => {
    await page.goto(CAMPAIGN_URL);
    await page.goto('/get?utm_source=newsletter&utm_medium=email&utm_campaign=other');

    const stored = await page.evaluate(() =>
      JSON.parse(sessionStorage.getItem('patterns_attribution') ?? '{}')
    );
    expect(stored.source).toBe('youtube');
    expect(stored.campaign).toBe('patterns_august');
  });

  test('a direct visit stays unattributed rather than half-attributed', async ({ page }) => {
    await page.goto('/get');
    const stored = await page.evaluate(() => sessionStorage.getItem('patterns_attribution'));
    expect(stored).toBeNull();
  });
});

test.describe('resilience', () => {
  test('store navigation still works when analytics is blocked', async ({ page }) => {
    await stubStores(page);
    await blockAnalytics(page);

    await page.goto(CAMPAIGN_URL);
    await page.getByRole('link', { name: APP_STORE_LABEL }).click();
    await page.waitForURL(/apps\.apple\.com/);

    expect(page.url()).toContain('apps.apple.com');
  });

  test('the page renders and links work with JavaScript disabled', async ({ browser }) => {
    const context = await browser.newContext({ javaScriptEnabled: false });
    const page = await context.newPage();
    await stubStores(page);
    await page.goto('/get');

    // Prerendered HTML: the store anchors exist without hydration.
    await expect(page.getByRole('link', { name: APP_STORE_LABEL })).toBeVisible();
    await page.getByRole('link', { name: APP_STORE_LABEL }).click();
    await page.waitForURL(/apps\.apple\.com/);
    expect(page.url()).toContain('apps.apple.com');

    await context.close();
  });

  test('no store click event is lost to the deferred tag load', async ({ page }) => {
    const events = await recordEvents(page);
    await stubStores(page);
    await page.goto(CAMPAIGN_URL);
    // Tap immediately, before requestIdleCallback would have run.
    await page.getByRole('link', { name: APP_STORE_LABEL }).click();
    await page.waitForURL(/apps\.apple\.com/);

    // The event reached the queue regardless of tag load state.
    expect(events.named('app_store_click')).toHaveLength(1);
  });
});
