import type { Page } from '@playwright/test';

export const APP_STORE_LABEL = 'Download Patterns on the App Store';
export const PLAY_STORE_LABEL = 'Get Patterns on Google Play';

export interface CapturedEvent {
  name: string;
  params: Record<string, unknown>;
}

export interface EventRecorder {
  all(): CapturedEvent[];
  named(name: string): CapturedEvent[];
  clear(): void;
}

/**
 * Mirrors every `dataLayer` event push out to Node as it happens.
 *
 * Reading `window.dataLayer` after the click would be useless: a store click
 * navigates the document away, taking the array with it. Forwarding through a
 * binding at push time means the evidence outlives the page — which is the only
 * way to prove a same-tab store hand-off was measured before it happened.
 *
 * It observes the real gtag queue, so no test double sits in the code path.
 */
export async function recordEvents(page: Page): Promise<EventRecorder> {
  let events: CapturedEvent[] = [];

  await page.exposeFunction('__captureEvent', (event: CapturedEvent) => {
    events.push(event);
  });

  await page.addInitScript(() => {
    const w = window as unknown as {
      dataLayer?: unknown[];
      __captureEvent?: (event: CapturedEvent) => void;
    };
    // Runs before app.html, which then reuses this array via `|| []`.
    w.dataLayer = w.dataLayer ?? [];
    const original = w.dataLayer.push.bind(w.dataLayer);
    w.dataLayer.push = (...args: unknown[]) => {
      for (const arg of args) {
        try {
          const parts = Array.from(arg as ArrayLike<unknown>);
          if (parts[0] === 'event') {
            w.__captureEvent?.({
              name: parts[1] as string,
              params: (parts[2] ?? {}) as Record<string, unknown>
            });
          }
        } catch {
          // Non-arraylike entries (gtag config objects) are not events.
        }
      }
      return original(...args);
    };
  });

  return {
    all: () => [...events],
    named: (name: string) => events.filter((event) => event.name === name),
    clear: () => {
      events = [];
    }
  };
}

/**
 * Stubs the store destinations so a click can navigate for real without leaving
 * the test environment or hitting Apple/Google.
 */
export async function stubStores(page: Page) {
  await page.route('**://apps.apple.com/**', (route) =>
    route.fulfill({ status: 200, contentType: 'text/html', body: '<title>App Store stub</title>' })
  );
  await page.route('**://play.google.com/**', (route) =>
    route.fulfill({ status: 200, contentType: 'text/html', body: '<title>Play Store stub</title>' })
  );
}

/** Simulates an ad blocker eating the GA4 tag. */
export async function blockAnalytics(page: Page) {
  await page.route('**://www.googletagmanager.com/**', (route) => route.abort());
}

/** True when the element's bottom edge is inside the viewport without scrolling. */
export async function isAboveFold(page: Page, label: string): Promise<boolean> {
  const box = await page.getByRole('link', { name: label }).boundingBox();
  const viewport = page.viewportSize();
  if (!box || !viewport) return false;
  const scrollY = await page.evaluate(() => window.scrollY);
  return box.y - scrollY >= 0 && box.y + box.height - scrollY <= viewport.height;
}
