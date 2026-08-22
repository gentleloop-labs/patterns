import { beforeEach, describe, expect, it, vi } from 'vitest';
import { cleanup, render } from '@testing-library/svelte';
import StoreLink from './StoreLink.svelte';
import { resetStoreClickDedupe, trackStoreClick } from '$lib/utils/analytics';
import { clearAttribution } from '$lib/utils/attribution';
import { captureReferral, clearReferral } from '$lib/utils/referral';
import { links } from '$lib/data/links';

function gtag() {
  return window.gtag as unknown as ReturnType<typeof vi.fn>;
}

function eventsNamed(name: string) {
  return gtag()
    .mock.calls.filter((call) => call[0] === 'event' && call[1] === name)
    .map((call) => call[2] as Record<string, unknown>);
}

describe('StoreLink', () => {
  beforeEach(() => {
    cleanup();
    window.gtag = vi.fn();
    resetStoreClickDedupe();
    clearAttribution();
    clearReferral();
  });

  it('renders a real anchor to the App Store with an accessible label', () => {
    const { getByRole } = render(StoreLink, {
      props: { store: 'app_store', placement: 'hero' }
    });

    const link = getByRole('link', { name: 'Download Patterns on the App Store' });
    expect(link.getAttribute('href')).toBe(links.ios);
  });

  it('renders a real anchor to Google Play with an accessible label', () => {
    const { getByRole } = render(StoreLink, {
      props: { store: 'play_store', placement: 'hero' }
    });

    const link = getByRole('link', { name: 'Get Patterns on Google Play' });
    expect(link.getAttribute('href')).toBe(links.playStore);
  });

  it('stays in the same tab by default, which is what in-app browsers need', () => {
    const { getByRole } = render(StoreLink, {
      props: { store: 'app_store', placement: 'hero' }
    });

    const link = getByRole('link');
    expect(link.getAttribute('target')).toBeNull();
    expect(link.getAttribute('rel')).toBe('noopener');
  });

  it('opts into a new tab with a safe rel when asked', () => {
    const { getByRole } = render(StoreLink, {
      props: { store: 'play_store', placement: 'body', newTab: true }
    });

    const link = getByRole('link');
    expect(link.getAttribute('target')).toBe('_blank');
    expect(link.getAttribute('rel')).toBe('noopener noreferrer');
  });

  it('emits exactly one conversion event per click', () => {
    const { getByRole } = render(StoreLink, {
      props: { store: 'app_store', placement: 'hero' }
    });

    getByRole('link').click();

    expect(eventsNamed('app_store_click')).toHaveLength(1);
    expect(eventsNamed('play_store_click')).toHaveLength(0);
  });

  it('reports one event even when an ancestor also reports the same click', () => {
    // Svelte 5 delegates events from the document root, so stopPropagation
    // cannot pre-empt a native ancestor listener — the dedupe window in
    // trackStoreClick is what actually guarantees one event per tap.
    const host = document.createElement('div');
    host.addEventListener('click', () => trackStoreClick('play_store', 'footer', links.playStore));
    document.body.appendChild(host);

    const { getByRole } = render(StoreLink, {
      props: { store: 'play_store', placement: 'footer' },
      target: host as unknown as HTMLElement
    });

    getByRole('link').click();

    expect(eventsNamed('play_store_click')).toHaveLength(1);
    expect(eventsNamed('download')).toHaveLength(1);
  });

  it('reports one event when the component remounts and is clicked again fast', () => {
    const first = render(StoreLink, { props: { store: 'app_store', placement: 'hero' } });
    first.getByRole('link').click();
    cleanup();

    const second = render(StoreLink, { props: { store: 'app_store', placement: 'hero' } });
    second.getByRole('link').click();

    expect(eventsNamed('app_store_click')).toHaveLength(1);
  });

  it('does not navigate by script, so the anchor is the only navigation', () => {
    const openSpy = vi.spyOn(window, 'open').mockReturnValue(null);
    const { getByRole } = render(StoreLink, {
      props: { store: 'app_store', placement: 'hero' }
    });

    getByRole('link').click();

    expect(openSpy).not.toHaveBeenCalled();
    openSpy.mockRestore();
  });

  it('does not preventDefault, so the store hand-off still happens', () => {
    const { getByRole } = render(StoreLink, {
      props: { store: 'app_store', placement: 'hero' }
    });

    const event = new MouseEvent('click', { bubbles: true, cancelable: true });
    getByRole('link').dispatchEvent(event);

    expect(event.defaultPrevented).toBe(false);
  });

  it('carries the session campaign onto the click', () => {
    // Simulate the visitor having landed on the ad URL earlier in the session.
    sessionStorage.setItem(
      'patterns_attribution',
      JSON.stringify({ source: 'youtube', campaign: 'patterns_august', medium: 'paid_video' })
    );

    const { getByRole } = render(StoreLink, {
      props: { store: 'play_store', placement: 'sticky_banner' }
    });
    getByRole('link').click();

    expect(eventsNamed('play_store_click')[0]).toMatchObject({
      click_source: 'youtube',
      click_campaign: 'patterns_august',
      click_medium: 'paid_video',
      placement: 'sticky_banner'
    });
  });

  it('carries the session creator referral onto the click', () => {
    captureReferral('?ref=shahhyashvi');

    const { getByRole } = render(StoreLink, {
      props: { store: 'app_store', placement: 'hero' }
    });
    getByRole('link').click();

    expect(eventsNamed('app_store_click')[0]).toMatchObject({
      ref: 'shahhyashvi',
      app_platform: 'ios',
      destination_store: 'app_store'
    });
  });

  it('omits ref when the visit has no creator referral', () => {
    const { getByRole } = render(StoreLink, {
      props: { store: 'play_store', placement: 'hero' }
    });
    getByRole('link').click();

    expect(eventsNamed('play_store_click')[0].ref).toBeUndefined();
  });
});
