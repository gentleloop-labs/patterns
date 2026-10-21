import { expect, test } from '@playwright/test';

const imageUrl = 'https://patternsocd.com/og/patterns-share-v2.png';

test('uses the refreshed share card on general website pages', async ({ page, request }) => {
  for (const path of ['/', '/blog', '/learn']) {
    await page.goto(path);
    await expect(page.locator('meta[property="og:image"]')).toHaveAttribute('content', imageUrl);
    await expect(page.locator('meta[name="twitter:image"]')).toHaveAttribute('content', imageUrl);
    await expect(page.locator('meta[property="og:image:width"]')).toHaveAttribute('content', '1200');
    await expect(page.locator('meta[property="og:image:height"]')).toHaveAttribute('content', '630');
    await expect(page.locator('meta[property="og:image:alt"]')).toHaveAttribute(
      'content',
      'Patterns private OCD journal and ERP app share preview'
    );
  }

  const image = await request.get('/og/patterns-share-v2.png');
  expect(image.ok()).toBe(true);
  expect(image.headers()['content-type']).toContain('image/png');
  expect((await image.body()).byteLength).toBeGreaterThan(100_000);

  const sitemap = await (await request.get('/sitemap.xml')).text();
  expect(sitemap).toContain(imageUrl);
});
