import { cleanup, fireEvent, render } from '@testing-library/svelte';
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';
import { postsByDate } from '$lib/data/blog';
import { homepageFaqs } from '$lib/data/faq';
import {
  testimonialEditDisclosure,
  testimonialOutcomeDisclosure,
  testimonials
} from '$lib/data/homepage';
import CommunityProof from './CommunityProof.svelte';
import Faq from './Faq.svelte';
import LatestArticles from './LatestArticles.svelte';
import Understanding from './Understanding.svelte';

class TestIntersectionObserver {
  observe() {}
  unobserve() {}
  disconnect() {}
}

describe('homepage trust sections', () => {
  beforeEach(() => {
    vi.stubGlobal('IntersectionObserver', TestIntersectionObserver);
  });

  afterEach(() => {
    cleanup();
    vi.unstubAllGlobals();
  });

  it('selects a loop step and reveals its explanation', async () => {
    const view = render(Understanding);
    const compulsion = view.getByRole('button', { name: /Compulsion/ });

    await fireEvent.click(compulsion);

    expect(compulsion.getAttribute('aria-pressed')).toBe('true');
    expect(view.getByText(/Checking, reassurance, avoidance/)).toBeTruthy();
    expect(view.getByText(/pause or delay the ritual/)).toBeTruthy();
  });

  it('moves between loop steps with arrow keys', async () => {
    const view = render(Understanding);
    const distress = view.getByRole('button', { name: /Distress/ });

    distress.focus();
    await fireEvent.keyDown(distress, { key: 'ArrowRight' });

    const compulsion = view.getByRole('button', { name: /Compulsion/ });
    expect(compulsion.getAttribute('aria-pressed')).toBe('true');
    expect(document.activeElement).toBe(compulsion);
  });

  it('preserves the full FAQ page and renders the six-item homepage variant', () => {
    const full = render(Faq);
    expect(full.container.querySelector('h1')?.textContent).toContain('Questions, answered.');
    expect(full.container.querySelectorAll('details')).toHaveLength(14);
    cleanup();

    const home = render(Faq, {
      props: { items: homepageFaqs, variant: 'home' }
    });
    expect(home.container.querySelector('h2')?.textContent).toContain(
      'A few things worth knowing.'
    );
    expect(home.container.querySelectorAll('details')).toHaveLength(6);
    expect(home.queryByText('← Back to Home')).toBeNull();
  });

  it('renders only the approved testimonials with both disclosures', () => {
    const view = render(CommunityProof);

    expect(view.container.querySelectorAll('blockquote')).toHaveLength(testimonials.length);
    expect(view.container.textContent).toContain(testimonialEditDisclosure);
    expect(view.container.textContent).toContain(testimonialOutcomeDisclosure);
    expect(view.queryByText(/afford a psychologist/i)).toBeNull();
  });

  it('selects the newest three articles dynamically', () => {
    const view = render(LatestArticles);
    const expected = postsByDate.slice(0, 3);

    expect(view.container.querySelectorAll('article')).toHaveLength(3);
    for (const post of expected) {
      expect(view.getByRole('heading', { name: post.title })).toBeTruthy();
    }
  });
});
