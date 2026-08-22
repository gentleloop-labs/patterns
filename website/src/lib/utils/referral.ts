/**
 * Creator referral from the `ref` query parameter.
 *
 * Future creator links are created by changing the value after `?ref=`.
 * No new page is required.
 *
 *   https://patternsocd.com/get?ref=shahhyashvi
 *   https://patternsocd.com/get?ref=anothercreator
 *
 * The first valid value in the tab wins and is kept in sessionStorage for the
 * rest of the visit, so a later store click is still credited to the creator.
 * Invalid or missing values are dropped; the page behaves as a direct visit.
 */

const STORAGE_KEY = 'patterns_referral';

/** Instagram handles are 30 characters; 32 leaves a little room without inviting prose. */
const MAX_REF_LENGTH = 32;

/** Letters, digits, underscore, dot, hyphen. Must start with an alphanumeric. */
const REF_PATTERN = /^[a-z0-9][a-z0-9._-]{0,31}$/;

const CONTROL_CHARS = new RegExp('[\\u0000-\\u001F\\u007F]', 'g');

/** Returns a safe creator slug, or undefined if the value should not be stored or sent. */
export function sanitizeReferral(raw: string | null | undefined): string | undefined {
  if (!raw) return undefined;
  let value = raw.replace(CONTROL_CHARS, '').trim();
  if (value.startsWith('@')) value = value.slice(1).trim();
  value = value.toLowerCase();
  if (!REF_PATTERN.test(value)) return undefined;
  return value.slice(0, MAX_REF_LENGTH);
}

function read(): string | undefined {
  try {
    return sanitizeReferral(sessionStorage.getItem(STORAGE_KEY));
  } catch {
    return undefined;
  }
}

function write(value: string): void {
  try {
    sessionStorage.setItem(STORAGE_KEY, value);
  } catch {
    // Storage unavailable: referral degrades to current-URL-only. Never throw.
  }
}

/**
 * Reads `ref` from `search` and, if it is a valid creator slug, stores it as
 * the session's referral. First valid value wins.
 */
export function captureReferral(search: string): string | undefined {
  const existing = read();
  if (existing) return existing;

  const incoming = sanitizeReferral(new URLSearchParams(search).get('ref'));
  if (!incoming) return undefined;

  write(incoming);
  return incoming;
}

/** The creator referral for this session, or undefined if the visit is uncredited. */
export function getReferral(): string | undefined {
  if (typeof sessionStorage === 'undefined') return undefined;
  return read();
}

/** Test seam. Not used by app code. */
export function clearReferral(): void {
  try {
    sessionStorage.removeItem(STORAGE_KEY);
  } catch {
    // no-op
  }
}
