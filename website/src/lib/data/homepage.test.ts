import { describe, expect, it } from 'vitest';
import { homepageFaqs } from './faq';
import {
  loopSteps,
  testimonialEditDisclosure,
  testimonialOutcomeDisclosure,
  testimonials,
  trustItems
} from './homepage';

describe('homepage trust content', () => {
  it('keeps three linked trust signals', () => {
    expect(trustItems).toHaveLength(3);
    expect(trustItems.every((item) => item.href.startsWith('/'))).toBe(true);
  });

  it('keeps all four loop explanations complete', () => {
    expect(loopSteps.map((step) => step.id)).toEqual([
      'obsession',
      'distress',
      'compulsion',
      'relief'
    ]);
    for (const step of loopSteps) {
      expect(step.detail.length).toBeGreaterThan(40);
      expect(step.reinforcement.length).toBeGreaterThan(40);
      expect(step.nextResponse.length).toBeGreaterThan(40);
    }
  });

  it('keeps the six approved homepage questions', () => {
    expect(homepageFaqs).toHaveLength(6);
    expect(homepageFaqs.map((item) => item.question)).toEqual(
      expect.arrayContaining([
        'Is Patterns a replacement for therapy?',
        'What is the OCD severity self-check?',
        'Is my data private?',
        'How much does Patterns cost?',
        'I think I might have OCD. What should I do?',
        'What if I need urgent help?'
      ])
    );
  });

  it('keeps testimonial permissions and limitations visible', () => {
    expect(testimonials).toHaveLength(4);
    expect(testimonials.every((item) => item.attribution === 'Anonymous Patterns user')).toBe(true);
    expect(testimonials.map((item) => item.quote).join(' ')).not.toMatch(
      /psychologist|★|star rating/i
    );
    expect(testimonialEditDisclosure).toBe('Excerpts lightly edited for length and clarity.');
    expect(testimonialOutcomeDisclosure).toBe(
      'Individual experiences are personal and are not evidence of a clinical outcome.'
    );
  });
});
