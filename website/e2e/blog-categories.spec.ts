import { expect, test } from '@playwright/test';

const gettingHelpArticles = [
  'what-happens-during-an-ocd-assessment',
  'how-to-find-an-ocd-therapist',
  'medication-for-ocd',
  'what-to-expect-first-erp-sessions'
];

test('offers six blog categories and a populated Getting Help collection', async ({ page, request }) => {
  await page.goto('/blog');
  const categoryNav = page.getByRole('navigation', { name: 'Browse the OCD information library' });
  await expect(categoryNav.getByRole('link')).toHaveCount(6);
  await categoryNav.getByRole('link', { name: /Getting Help/ }).click();

  await expect(page).toHaveURL(/\/learn\/getting-help$/);
  await expect(page.getByRole('heading', { level: 1, name: 'Getting Help' })).toBeVisible();
  await expect(page.locator('.post-card')).toHaveCount(4);

  for (const slug of gettingHelpArticles) {
    await expect(page.locator(`.post-card h2 a[href="/blog/${slug}"]`)).toHaveCount(1);
    const article = await request.get(`/blog/${slug}`);
    expect(article.ok(), slug).toBe(true);
    expect(await article.text(), slug).toContain('href="/learn/getting-help"');
  }

  const sitemap = await (await request.get('/sitemap.xml')).text();
  expect(sitemap).toContain('https://patternsocd.com/learn/getting-help');
});

test('keeps all six library cards in the viewport', async ({ page }) => {
  await page.goto('/learn');
  await expect(page.locator('.category-card')).toHaveCount(6);
  await expect(page.locator('.category-card .explore[href="/learn/getting-help"]')).toBeVisible();
  expect(
    await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)
  ).toBe(true);
});
