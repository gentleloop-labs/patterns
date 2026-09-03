import { expect, test } from '@playwright/test';

test.describe('homepage trust and human connection', () => {
  test('keeps the planned section order and fits the viewport', async ({ page }) => {
    await page.goto('/');

    const ids = [
      'hero',
      'trust',
      'understanding',
      'everyday-moments',
      'features',
      'preview',
      'ybocs',
      'built-for-erp',
      'toolkit',
      'community-proof',
      'pricing',
      'latest-articles',
      'home-faq',
      'download',
      'support',
      'footer'
    ];
    await expect(page.locator(ids.map((id) => `#${id}`).join(', '))).toHaveCount(ids.length);

    const ordered = await page.evaluate((sectionIds) => {
      const tops = sectionIds.map((id) => document.getElementById(id)?.offsetTop ?? -1);
      return tops.every((top, index) => index === 0 || top > tops[index - 1]);
    }, ids);
    expect(ordered).toBe(true);
    expect(
      await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)
    ).toBe(true);
  });

  test('supports mouse and keyboard exploration of the OCD loop', async ({ page }) => {
    await page.goto('/');
    const distress = page.getByRole('button', { name: /Distress/ });
    const compulsion = page.getByRole('button', { name: /Compulsion/ });
    const relief = page.getByRole('button', { name: /Relief/ });

    if (await page.evaluate(() => navigator.maxTouchPoints > 0)) {
      await compulsion.tap();
    } else {
      await compulsion.click();
    }
    await expect(compulsion).toHaveAttribute('aria-pressed', 'true');
    await expect(page.locator('#loop-detail')).toContainText('Checking, reassurance, avoidance');

    await distress.focus();
    await distress.press('Enter');
    await expect(distress).toHaveAttribute('aria-pressed', 'true');
    await relief.focus();
    await relief.press('Space');
    await expect(relief).toHaveAttribute('aria-pressed', 'true');

    await distress.focus();
    await distress.press('ArrowRight');
    await expect(compulsion).toBeFocused();
    await expect(compulsion).toHaveAttribute('aria-pressed', 'true');
  });

  test('shows Y-BOCS limits, approved feedback, current articles, and homepage FAQs', async ({
    page
  }) => {
    await page.goto('/');

    await expect(page.locator('#ybocs')).toContainText(
      'This is a self-check, not a diagnosis. A qualified professional should interpret symptoms in context.'
    );
    await expect(page.locator('#community-proof blockquote')).toHaveCount(4);
    await expect(page.locator('#community-proof')).toContainText(
      'Excerpts lightly edited for length and clarity.'
    );
    await expect(page.locator('#community-proof')).toContainText(
      'Individual experiences are personal and are not evidence of a clinical outcome.'
    );
    await expect(page.locator('#latest-articles article')).toHaveCount(3);
    await expect(page.locator('#home-faq details')).toHaveCount(6);

    const firstQuestion = page.locator('#home-faq details').first();
    await firstQuestion.locator('summary').click();
    await expect(firstQuestion).toHaveAttribute('open', '');

    await page.locator('#ybocs a[href="#download"]').click();
    await expect(page).toHaveURL(/#download$/);
  });

  test('loads responsive human imagery and respects reduced motion', async ({ page }) => {
    await page.emulateMedia({ reducedMotion: 'reduce' });
    await page.goto('/');
    await page.locator('#everyday-moments').scrollIntoViewIfNeeded();

    const images = page.locator('#everyday-moments img');
    await expect(images).toHaveCount(2);
    for (let index = 0; index < 2; index += 1) {
      await expect
        .poll(() => images.nth(index).evaluate((image: HTMLImageElement) => image.naturalWidth))
        .toBeGreaterThan(0);
      await expect(images.nth(index)).toHaveAttribute('loading', 'lazy');
    }

    await page.locator('#ybocs').scrollIntoViewIfNeeded();
    const ybocsImage = page.locator('#ybocs img');
    await expect.poll(() => ybocsImage.evaluate((image) => image.naturalWidth)).toBeGreaterThan(0);
    await expect(ybocsImage).toHaveAttribute('loading', 'lazy');
    expect(await ybocsImage.evaluate((image) => image.currentSrc)).toContain(
      'ybocs-app-ui-v1.webp'
    );

    await page.getByRole('button', { name: 'Toggle theme' }).first().click();
    expect(
      await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)
    ).toBe(true);
  });
});
