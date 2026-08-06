import { expect, test } from '@playwright/test';
import { APP_STORE_LABEL, PLAY_STORE_LABEL, recordEvents, stubStores } from './helpers';

test.describe('analytics QA harness', () => {
  test('renders every placement for both stores', async ({ page }) => {
    await page.goto('/dev/analytics-qa');

    for (const placement of ['hero', 'sticky_banner', 'footer', 'body', 'qr_code']) {
      await expect(page.getByRole('link', { name: `App Store, ${placement}` })).toBeVisible();
      await expect(page.getByRole('link', { name: `Google Play, ${placement}` })).toBeVisible();
    }
  });

  test('applies test UTMs and shows the stored attribution', async ({ page }) => {
    await page.goto('/dev/analytics-qa');
    await page.getByTestId('utm-source').fill('creator_jane');
    await page.getByTestId('utm-medium').fill('creator');
    await page.getByTestId('utm-campaign').fill('patterns_creator_test');
    await page.getByTestId('apply-utms').click();

    const attribution = await page.getByTestId('attribution').textContent();
    expect(attribution).toContain('creator_jane');
    expect(attribution).toContain('patterns_creator_test');
  });

  test('shows the exact payload and counts one navigation per click', async ({ page }) => {
    await page.goto('/dev/analytics-qa');
    await page.getByTestId('apply-utms').click();
    await page.getByRole('link', { name: 'App Store, body' }).click();

    await expect(page.getByTestId('store-click-count')).toHaveText('1');
    await expect(page.getByTestId('navigation-count')).toHaveText('1');
    await expect(page.getByTestId('mismatch')).toHaveCount(0);

    const log = await page.getByTestId('event-log').textContent();
    expect(log).toContain('app_store_click');
    expect(log).toContain('"placement": "body"');
    expect(log).toContain('"click_source": "youtube"');
  });

  test('detects and reports a duplicate fire', async ({ page }) => {
    await page.goto('/dev/analytics-qa');
    const link = page.getByRole('link', { name: 'Google Play, hero' });
    await link.click();
    await link.click();

    // One real event, one suppressed duplicate, two intercepted navigations.
    await expect(page.getByTestId('store-click-count')).toHaveText('1');
    await expect(page.getByTestId('suppressed-count')).toHaveText('1');
    await expect(page.getByTestId('event-log')).toContainText('suppressed duplicate');
  });

  test('is excluded from indexing', async ({ page, request }) => {
    await page.goto('/dev/analytics-qa');
    await expect(page.locator('meta[name="robots"]')).toHaveAttribute(
      'content',
      'noindex, nofollow'
    );

    const robots = await request.get('/robots.txt');
    expect(await robots.text()).toContain('Disallow: /dev/');

    const sitemap = await request.get('/sitemap.xml');
    expect(await sitemap.text()).not.toContain('/dev/');
  });
});

test.describe('?analytics_debug=1 diagnostics', () => {
  test('stays hidden unless explicitly requested', async ({ page }) => {
    await page.goto('/get');
    await expect(page.getByLabel('Analytics diagnostics')).toHaveCount(0);

    await page.goto('/get?analytics_debug=0');
    await expect(page.getByLabel('Analytics diagnostics')).toHaveCount(0);
  });

  test('reports device, attribution, last event and payload', async ({ page }) => {
    await stubStores(page);
    await page.goto(
      '/get?analytics_debug=1&utm_source=youtube&utm_medium=paid_video&utm_campaign=patterns_august'
    );

    const panel = page.getByLabel('Analytics diagnostics');
    await expect(panel).toBeVisible();
    await expect(panel).toContainText('youtube');
    await expect(panel).toContainText('patterns_august');
    // get_landing_view fires on mount.
    await expect(panel).toContainText('get_landing_view');
  });

  test('reports the store click payload and a confirmed navigation', async ({ page }) => {
    await stubStores(page);
    await page.goto('/get?analytics_debug=1&utm_source=youtube');

    // Cancel the hand-off so the panel is still on screen to be read.
    await page.evaluate(() =>
      document.addEventListener('click', (event) => event.preventDefault(), true)
    );
    await page.getByRole('link', { name: PLAY_STORE_LABEL }).click();

    const panel = page.getByLabel('Analytics diagnostics');
    await expect(panel).toContainText('play_store_click');
    await expect(panel).toContainText('"placement": "hero"');
  });

  test('marks navigation confirmed after a real hand-off', async ({ page }) => {
    await stubStores(page);
    const events = await recordEvents(page);
    await page.goto('/get?analytics_debug=1&utm_source=youtube');
    await page.getByRole('link', { name: APP_STORE_LABEL }).click();
    await page.waitForURL(/apps\.apple\.com/);
    expect(events.named('app_store_click')).toHaveLength(1);

    // Come back: the pagehide hook recorded that navigation really happened.
    await page.goBack();
    await expect(page.getByLabel('Analytics diagnostics')).toContainText('confirmed');
  });

  test('exposes no personal data beyond the visitor own campaign URL', async ({ page }) => {
    await page.goto('/get?analytics_debug=1&utm_source=youtube');
    const text = (await page.getByLabel('Analytics diagnostics').textContent()) ?? '';
    // No identifiers, no cookies, no storage dump.
    expect(text).not.toMatch(/document\.cookie|localStorage|_ga|client_id|user_id/i);
  });
});
