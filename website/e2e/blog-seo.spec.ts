import { expect, test } from '@playwright/test';

const slug = 'what-is-erp-exposure-response-prevention';
const title = 'What Is ERP Therapy for OCD? A Plain-English Guide';
const imagePath = `/og/blog/${slug}.png`;

const newArticles = [
  {
    slug: 'can-ocd-go-away',
    title: 'Can OCD Go Away? What Recovery Actually Means',
    contextualLink: '/blog/ocd-flare-up-or-relapse'
  },
  {
    slug: 'how-to-support-someone-with-ocd',
    title: 'How to Support Someone With OCD Without Feeding the Cycle',
    contextualLink: '/blog/reassurance-seeking-ocd'
  },
  {
    slug: 'what-causes-ocd',
    title: 'What Causes OCD? Genetics, Brain, Learning, and Stress',
    contextualLink: '/blog/what-happens-during-an-ocd-assessment'
  },
  {
    slug: 'ocd-at-work',
    title: 'OCD at Work: Symptoms, Disclosure, and Helpful Support',
    contextualLink: '/blog/checking-ocd'
  }
];

test.describe('blog SEO', () => {
  test('renders concise metadata and an article-specific social card', async ({ page, request }) => {
    await page.goto(`/blog/${slug}`);

    await expect(page).toHaveTitle(`${title} | Patterns`);
    await expect(page.locator('h1')).toHaveText(title);
    await expect(page.locator('meta[property="og:image"]')).toHaveAttribute(
      'content',
      `https://patternsocd.com${imagePath}`
    );
    await expect(page.locator('meta[name="twitter:image"]')).toHaveAttribute(
      'content',
      `https://patternsocd.com${imagePath}`
    );
    await expect(page.locator('meta[property="og:image:alt"]')).toHaveAttribute(
      'content',
      `Patterns article card: ${title}`
    );

    const image = await request.get(imagePath);
    expect(image.ok()).toBe(true);
    expect(image.headers()['content-type']).toContain('image/png');
    expect((await image.body()).byteLength).toBeGreaterThan(10_000);

    await expect(page.getByRole('link', { name: 'OCD medication guide' })).toHaveAttribute(
      'href',
      '/blog/medication-for-ocd'
    );
    await expect(page.getByText('Clinically reviewed by')).toHaveCount(0);
  });

  test('publishes article images through the sitemap and RSS feed', async ({ request }) => {
    const sitemap = await request.get('/sitemap.xml');
    const sitemapBody = await sitemap.text();
    expect(sitemap.ok()).toBe(true);
    expect(sitemapBody).toContain(`https://patternsocd.com${imagePath}`);

    const rss = await request.get('/rss.xml');
    const rssBody = await rss.text();
    expect(rss.ok()).toBe(true);
    expect(rssBody).toContain('xmlns:media="http://search.yahoo.com/mrss/"');
    expect(rssBody).toContain(`media:content url="https://patternsocd.com${imagePath}"`);
  });

  for (const article of newArticles) {
    test(`publishes ${article.slug} with metadata, sources, and internal links`, async ({
      page,
      request
    }) => {
      const articleImage = `/og/blog/${article.slug}.png`;
      await page.goto(`/blog/${article.slug}`);

      await expect(page).toHaveTitle(`${article.title} | Patterns`);
      await expect(page.locator('h1')).toHaveText(article.title);
      await expect(page.locator('meta[property="og:image"]')).toHaveAttribute(
        'content',
        `https://patternsocd.com${articleImage}`
      );
      await expect(page.getByRole('heading', { name: 'Sources' })).toBeVisible();
      await expect(page.locator(`a[href="${article.contextualLink}"]`).first()).toBeVisible();

      const image = await request.get(articleImage);
      expect(image.ok()).toBe(true);
      expect(image.headers()['content-type']).toContain('image/png');
    });
  }
});
