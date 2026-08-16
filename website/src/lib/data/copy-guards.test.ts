import { readdirSync, readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { describe, expect, it } from 'vitest';
import { faqs } from './faq';

/**
 * Two things that are invisible in CI and embarrassing in production.
 *
 * The em dash: house style is to rephrase rather than reach for one, and the
 * roadmap and FAQ are the two files where new prose lands most often.
 *
 * The pricing claim: the FAQ answers are rendered into FAQPage JSON-LD, so a
 * stale answer is not just wrong on the page, it is a structured-data claim
 * that search engines read and repeat. The old answer said Patterns had "no
 * paywalled features" long after Pro shipped.
 */

// Resolved from the vitest root (website/) rather than import.meta.url, which
// is not a file URL under the jsdom environment this suite runs in.
const roadmapSource = readFileSync(
  resolve(process.cwd(), 'src/routes/roadmap/+page.svelte'),
  'utf-8'
);

// Blog posts are the third place pricing gets described, and the least
// reviewed. A draft of one of them announced a $14.99/year subscription that
// was never built, and it only escaped publication because a deploy failed.
const blogDir = resolve(process.cwd(), 'src/content/blog');
const blogPosts = readdirSync(blogDir)
  .filter((name) => name.endsWith('.md'))
  .map((name) => ({ name, body: readFileSync(resolve(blogDir, name), 'utf-8') }));

describe('copy style', () => {
  it('keeps em dashes out of every FAQ answer', () => {
    for (const faq of faqs) {
      expect(faq.question, `question: ${faq.question}`).not.toContain('—');
      expect(faq.answer, `answer to: ${faq.question}`).not.toContain('—');
    }
  });

  it('keeps em dashes out of the roadmap', () => {
    expect(roadmapSource).not.toContain('—');
  });
});

describe('pricing claims', () => {
  const pricingAnswer = faqs.find((faq) => faq.question.includes('cost'))?.answer ?? '';

  it('has an answer about cost at all', () => {
    expect(pricingAnswer).not.toBe('');
  });

  it('does not claim Patterns has no paid features', () => {
    expect(pricingAnswer.toLowerCase()).not.toContain('no paywalled features');
    expect(pricingAnswer.toLowerCase()).not.toContain('free to download and use, with no');
  });

  // The rise to $39.99 was applied on 16 August 2026, so it is now simply the
  // price. The FAQ answers are rendered into FAQPage JSON-LD, so a stale figure
  // here is a structured-data claim search engines repeat as the current price.
  it('quotes the price people are charged today', () => {
    expect(pricingAnswer).toContain('$39.99');
  });

  // The rise has landed, so nothing may still frame it as upcoming, and nothing
  // may dangle a buy-before-the-deadline discount that can no longer be taken.
  it('does not present the price rise as still to come', () => {
    for (const source of [pricingAnswer, roadmapSource]) {
      expect(source).not.toMatch(/goes to \$39\.99|rises to \$39\.99|going to \$39\.99/);
      expect(source).not.toMatch(/before the \d{1,2}th|before then you keep/);
    }
  });

  // Pro is a one-time purchase and is staying that way. An earlier draft of the
  // blog announced a $14.99/year subscription that was never built; this stops
  // that claim reappearing anywhere the site can publish it.
  it('never advertises a subscription', () => {
    const recurring =
      /\$\d+(\.\d\d)?\s*(per year|\/ ?year|a year|per month|\/ ?month|a month)/i;

    for (const faq of faqs) {
      expect(faq.answer, `answer to: ${faq.question}`).not.toMatch(recurring);
    }
    expect(roadmapSource, 'roadmap').not.toMatch(recurring);
    for (const post of blogPosts) {
      expect(post.body, `blog post: ${post.name}`).not.toMatch(recurring);
    }
  });

  it('finds blog posts to scan', () => {
    expect(blogPosts.length).toBeGreaterThan(0);
  });

  // $14.99 is retired everywhere, not merely demoted from "future price" to
  // "current price". Leaving it anywhere quotable is how the site ends up
  // advertising less than the store actually charges.
  it('does not leave the retired $14.99 figure anywhere', () => {
    expect(pricingAnswer, 'FAQ pricing answer').not.toContain('$14.99');
    expect(roadmapSource, 'roadmap').not.toContain('$14.99');
    for (const post of blogPosts) {
      expect(post.body, `blog post: ${post.name}`).not.toContain('$14.99');
    }
  });

  it('does not leave the retired $19.99 figure anywhere', () => {
    expect(pricingAnswer).not.toContain('$19.99');
    expect(roadmapSource).not.toContain('$19.99');
  });
});
