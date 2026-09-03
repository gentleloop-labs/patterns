import { readdirSync, readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { describe, expect, it } from 'vitest';
import { faqs } from './faq';
import { testimonialEditDisclosure, testimonialOutcomeDisclosure, testimonials } from './homepage';

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
const pricingSource = readFileSync(
  resolve(process.cwd(), 'src/lib/data/pricing.ts'),
  'utf-8'
);

const ybocsSource = readFileSync(
  resolve(process.cwd(), 'src/lib/sections/YbocsSpotlight.svelte'),
  'utf-8'
);

const trustSectionSources = [
  ybocsSource,
  readFileSync(resolve(process.cwd(), 'src/lib/sections/CommunityProof.svelte'), 'utf-8'),
  readFileSync(resolve(process.cwd(), 'src/lib/data/homepage.ts'), 'utf-8')
];

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

describe('homepage medical and testimonial guardrails', () => {
  it('keeps the Y-BOCS limitation visible word for word', () => {
    expect(ybocsSource).toContain(
      'This is a self-check, not a diagnosis. A qualified professional should interpret'
    );
    expect(ybocsSource).toContain('symptoms in context.');
  });

  it('keeps both testimonial disclosures present', () => {
    expect(testimonialEditDisclosure).toBe('Excerpts lightly edited for length and clarity.');
    expect(testimonialOutcomeDisclosure).toContain('not evidence of a clinical outcome');
    expect(testimonials).toHaveLength(4);
  });

  it('does not introduce clinical validation, diagnosis, or outcome claims', () => {
    const prohibited =
      /clinically validated|clinically proven|guaranteed results|cures OCD|diagnoses OCD|treats OCD/i;
    for (const source of trustSectionSources) {
      expect(source).not.toMatch(prohibited);
    }
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

  // Pro came back down to $19.99 on 31 August 2026, confirmed against the App
  // Store Connect price schedule. The FAQ answers are rendered into FAQPage
  // JSON-LD, so a stale figure here is a structured-data claim search engines
  // repeat as the current price.
  it('quotes the price people are charged today', () => {
    expect(pricingAnswer).toContain('$19.99');
  });

  // $39.99 is now only ever the "was" half of the drop. It may still appear,
  // but never as what someone would be charged if they bought Pro today.
  it('only ever quotes $39.99 as the old price', () => {
    for (const source of [pricingAnswer, roadmapSource]) {
      expect(source).not.toMatch(/(?:is|costs|now)\s+\$39\.99/);
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

  // The drop is only legible if the site says what Pro used to cost, so the
  // pages that quote a price must show both halves rather than silently
  // swapping the number.
  it('shows the drop rather than just the new number', () => {
    for (const source of [pricingAnswer, roadmapSource]) {
      expect(source).toContain('$39.99');
      expect(source).toContain('$19.99');
    }
  });

  // Indian pricing is set manually and is deliberately not advertised on the
  // site, so no page may quote a rupee figure.
  it('does not publish Indian pricing', () => {
    const rupees = /₹|\bINR\b|\bRs\.?\s*\d/;
    for (const faq of faqs) {
      expect(faq.answer, `answer to: ${faq.question}`).not.toMatch(rupees);
    }
    expect(roadmapSource, 'roadmap').not.toMatch(rupees);
    expect(pricingSource, 'pricing data').not.toMatch(rupees);
    for (const post of blogPosts) {
      expect(post.body, `blog post: ${post.name}`).not.toMatch(rupees);
    }
  });
});
