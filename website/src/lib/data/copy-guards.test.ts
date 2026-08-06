import { readFileSync } from 'node:fs';
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

  // Until the store price actually changes, the site must quote what people are
  // charged today and describe $19.99 as upcoming. Stating $19.99 flatly would
  // put a price nobody pays into the page and into FAQPage structured data.
  it('quotes the price people are charged today', () => {
    expect(pricingAnswer).toContain('$14.99');
  });

  it('describes the rise to $19.99 as still to come, not as current', () => {
    expect(pricingAnswer).toContain('$19.99');
    expect(pricingAnswer).toMatch(/rises to \$19\.99|going to \$19\.99/);
    expect(pricingAnswer).not.toMatch(/It is \$19\.99|costs \$19\.99/);
  });

  // The roadmap announces the change, so it may say $19.99, but it must never
  // present $14.99 as the price going forward.
  it('does not present $14.99 as the future price on the roadmap', () => {
    expect(roadmapSource).not.toMatch(/moves to \$14\.99|will be \$14\.99/);
  });
});
