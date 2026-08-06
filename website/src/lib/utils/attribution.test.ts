import { beforeEach, describe, expect, it } from 'vitest';
import { captureAttribution, clearAttribution, getAttribution } from './attribution';

describe('attribution', () => {
  beforeEach(() => {
    clearAttribution();
  });

  it('captures every supported utm parameter', () => {
    const result = captureAttribution(
      '?utm_source=youtube&utm_medium=paid_video&utm_campaign=patterns_august&utm_content=creative_a&utm_term=ocd%20app',
      '/get'
    );

    expect(result).toEqual({
      source: 'youtube',
      medium: 'paid_video',
      campaign: 'patterns_august',
      content: 'creative_a',
      term: 'ocd app',
      landing_page: '/get'
    });
  });

  it('persists across navigations so a later store click keeps the campaign', () => {
    captureAttribution('?utm_source=youtube&utm_campaign=patterns_august', '/get');
    // Visitor browses on to a page with no campaign params.
    captureAttribution('', '/erp');

    expect(getAttribution().source).toBe('youtube');
    expect(getAttribution().campaign).toBe('patterns_august');
    expect(getAttribution().landing_page).toBe('/get');
  });

  it('does not override valid existing attribution', () => {
    captureAttribution('?utm_source=youtube&utm_campaign=patterns_august', '/get');
    captureAttribution('?utm_source=newsletter&utm_campaign=other', '/faq');

    expect(getAttribution().source).toBe('youtube');
    expect(getAttribution().campaign).toBe('patterns_august');
  });

  it('records nothing for a direct visit', () => {
    captureAttribution('', '/get');
    expect(getAttribution()).toEqual({});
  });

  it('ignores utm params that name no source', () => {
    captureAttribution('?utm_medium=paid_video&utm_campaign=patterns_august', '/get');
    expect(getAttribution()).toEqual({});
  });

  it('truncates values to the GA4 parameter limit', () => {
    captureAttribution(`?utm_source=${'x'.repeat(200)}`, '/get');
    expect(getAttribution().source).toHaveLength(100);
  });

  it('decodes url-encoded values', () => {
    captureAttribution('?utm_content=august%2Fcreative%201', '/get');
    // No source, so nothing is stored; check the decode path via a sourced URL.
    captureAttribution('?utm_source=yt&utm_content=august%2Fcreative%201', '/get');
    expect(getAttribution().content).toBe('august/creative 1');
  });
});
