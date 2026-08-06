import { expect, test } from '@playwright/test';
import { APP_STORE_LABEL, PLAY_STORE_LABEL, isAboveFold } from './helpers';

test.describe('/get landing page', () => {
  test('shows the required copy, both stores and a screenshot', async ({ page }) => {
    await page.goto('/get');

    await expect(page.getByRole('heading', { level: 1 })).toHaveText('Patterns: OCD & ERP Journal');
    await expect(
      page.getByText(
        'A private app for tracking triggers, delaying compulsions, and practising ERP between therapy sessions.'
      )
    ).toBeVisible();

    for (const point of [
      'Free to download',
      'No account required',
      'Private and local-first',
      'Available on iPhone and Android'
    ]) {
      await expect(page.getByText(point, { exact: true })).toBeVisible();
    }

    await expect(page.getByRole('link', { name: APP_STORE_LABEL })).toBeVisible();
    await expect(page.getByRole('link', { name: PLAY_STORE_LABEL })).toBeVisible();
    await expect(page.getByAltText(/Patterns home screen/i)).toBeVisible();
  });

  test('never hides a store button below the fold', async ({ page }) => {
    await page.goto('/get');
    expect(await isAboveFold(page, APP_STORE_LABEL)).toBe(true);
    expect(await isAboveFold(page, PLAY_STORE_LABEL)).toBe(true);
  });

  test('does not scroll horizontally', async ({ page }) => {
    await page.goto('/get');
    const overflow = await page.evaluate(
      () => document.documentElement.scrollWidth - document.documentElement.clientWidth
    );
    expect(overflow).toBeLessThanOrEqual(1);
  });

  test('store links are reachable and labelled for keyboard and screen readers', async ({ page }) => {
    await page.goto('/get');

    // Both destinations are named in the accessible name, not just the icon.
    const appStore = page.getByRole('link', { name: APP_STORE_LABEL });
    await appStore.focus();
    await expect(appStore).toBeFocused();

    const play = page.getByRole('link', { name: PLAY_STORE_LABEL });
    await play.focus();
    await expect(play).toBeFocused();
  });
});

test.describe('device-aware emphasis', () => {
  test('desktop shows both stores plus the QR hand-off', async ({ page }, testInfo) => {
    test.skip(testInfo.project.name !== 'desktop-chrome', 'desktop only');
    await page.goto('/get');

    await expect(page.locator('html')).toHaveAttribute('data-platform', 'desktop');
    await expect(page.getByAltText(/QR code/i)).toBeVisible();
  });

  test('iPhone puts the App Store first', async ({ page }, testInfo) => {
    test.skip(testInfo.project.name !== 'iphone', 'iPhone only');
    await page.goto('/get');

    await expect(page.locator('html')).toHaveAttribute('data-platform', 'ios');

    const appStore = await page.getByRole('link', { name: APP_STORE_LABEL }).boundingBox();
    const play = await page.getByRole('link', { name: PLAY_STORE_LABEL }).boundingBox();
    expect(appStore!.y).toBeLessThan(play!.y);

    // The other platform is de-emphasised, never hidden.
    await expect(page.getByRole('link', { name: PLAY_STORE_LABEL })).toBeVisible();
  });

  test('Android puts Google Play first', async ({ page }, testInfo) => {
    test.skip(testInfo.project.name !== 'android', 'Android only');
    await page.goto('/get');

    await expect(page.locator('html')).toHaveAttribute('data-platform', 'android');

    const appStore = await page.getByRole('link', { name: APP_STORE_LABEL }).boundingBox();
    const play = await page.getByRole('link', { name: PLAY_STORE_LABEL }).boundingBox();
    expect(play!.y).toBeLessThan(appStore!.y);

    await expect(page.getByRole('link', { name: APP_STORE_LABEL })).toBeVisible();
  });
});

/**
 * The tightest realistic cases: an in-app browser on a small phone has both a
 * top bar and a bottom bar eating the viewport.
 */
const MOBILE_VIEWPORTS = [
  { name: 'iPhone SE', width: 375, height: 667 },
  { name: 'iPhone SE in-app browser', width: 375, height: 553 },
  { name: 'iPhone 13', width: 390, height: 844 },
  { name: 'iPhone 15 Pro Max', width: 430, height: 932 },
  { name: 'Pixel 5', width: 393, height: 851 },
  { name: 'Galaxy S8 in-app browser', width: 360, height: 620 },
  { name: 'small Android', width: 360, height: 640 }
];

test.describe('both store buttons stay above the fold', () => {
  for (const viewport of MOBILE_VIEWPORTS) {
    test(`${viewport.name} (${viewport.width}x${viewport.height})`, async ({ page }, testInfo) => {
      test.skip(testInfo.project.name !== 'desktop-chrome', 'viewport sweep runs once');
      await page.setViewportSize({ width: viewport.width, height: viewport.height });
      await page.goto('/get');

      expect(await isAboveFold(page, APP_STORE_LABEL)).toBe(true);
      expect(await isAboveFold(page, PLAY_STORE_LABEL)).toBe(true);
    });
  }
});
