/**
 * Campaign attribution capture and persistence.
 *
 * A visitor lands on an ad URL (`/get?utm_source=youtube&…`), then may browse to
 * `/`, `/erp`, `/faq` before tapping a store button. Without persistence the
 * store click would be attributed to nothing, which is exactly why the previous
 * campaign was unreadable.
 *
 * Storage is `sessionStorage`: per-tab, never sent to a server, and dropped when
 * the tab closes. No cookie, no cross-site identifier, no fingerprint. That
 * keeps the site consistent with the privacy promise on /privacy while still
 * letting a store click carry the campaign that produced it.
 */

export const UTM_KEYS = [
  'utm_source',
  'utm_medium',
  'utm_campaign',
  'utm_content',
  'utm_term'
] as const;

export type UtmKey = (typeof UTM_KEYS)[number];

export interface Attribution {
  source?: string;
  medium?: string;
  campaign?: string;
  content?: string;
  term?: string;
  /** Path the campaign first landed on, so /get can be compared to other entries. */
  landing_page?: string;
}

const STORAGE_KEY = 'patterns_attribution';

/** GA4 truncates string params at 100 chars; do it here so values stay readable. */
const MAX_VALUE_LENGTH = 100;

function clean(value: string | null): string | undefined {
  if (!value) return undefined;
  const trimmed = value.trim();
  if (!trimmed) return undefined;
  return trimmed.slice(0, MAX_VALUE_LENGTH);
}

function read(): Attribution | null {
  try {
    const raw = sessionStorage.getItem(STORAGE_KEY);
    if (!raw) return null;
    const parsed: unknown = JSON.parse(raw);
    if (!parsed || typeof parsed !== 'object') return null;
    return parsed as Attribution;
  } catch {
    // Private mode / storage disabled / corrupt value.
    return null;
  }
}

function write(value: Attribution): void {
  try {
    sessionStorage.setItem(STORAGE_KEY, JSON.stringify(value));
  } catch {
    // Storage unavailable: attribution degrades to current-URL-only. Never throw.
  }
}

/** True when the stored record actually names a campaign source. */
function isValid(value: Attribution | null): value is Attribution {
  return Boolean(value && value.source);
}

/**
 * Reads UTM params from `search` and, if they name a source, stores them as the
 * session's attribution.
 *
 * First valid attribution wins: a visitor who arrives from the YouTube ad and
 * later clicks an internal link that happens to carry different UTMs stays
 * credited to the ad. Returns whatever attribution now applies to the session.
 */
export function captureAttribution(search: string, pathname: string): Attribution {
  const existing = read();
  if (isValid(existing)) return existing;

  const params = new URLSearchParams(search);
  const incoming: Attribution = {
    source: clean(params.get('utm_source')),
    medium: clean(params.get('utm_medium')),
    campaign: clean(params.get('utm_campaign')),
    content: clean(params.get('utm_content')),
    term: clean(params.get('utm_term')),
    landing_page: clean(pathname)
  };

  if (!incoming.source) return existing ?? {};

  const stored: Attribution = {};
  for (const [key, value] of Object.entries(incoming)) {
    if (value) stored[key as keyof Attribution] = value;
  }
  write(stored);
  return stored;
}

/** The campaign attribution for this session, or `{}` if the visit is direct. */
export function getAttribution(): Attribution {
  if (typeof sessionStorage === 'undefined') return {};
  return read() ?? {};
}

/** Test seam. Not used by app code. */
export function clearAttribution(): void {
  try {
    sessionStorage.removeItem(STORAGE_KEY);
  } catch {
    // no-op
  }
}
