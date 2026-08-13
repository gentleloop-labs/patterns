import { getAttribution } from './attribution';

/**
 * GA4 event transport.
 *
 * `gtag` is defined inline in app.html and the tag script is loaded on idle, so
 * `window.gtag` always exists (it queues into `dataLayer`) even before the
 * script arrives. Everything here is best-effort: analytics being blocked must
 * never break a store link.
 */

type GtagValue = string | number | boolean;
export type EventParams = Record<string, GtagValue | undefined>;

declare global {
  interface Window {
    gtag?: (...args: unknown[]) => void;
    /** Forces the deferred GA4 script to load now (defined in app.html). */
    __loadPatternsAnalytics?: () => void;
  }
}

// --- GA4 collection limits ------------------------------------------------
// https://support.google.com/analytics/answer/9267744

/** Event names: 40 chars. Longer names cannot be marked as key events. */
export const MAX_EVENT_NAME_LENGTH = 40;
/** Parameter names: 40 chars. */
export const MAX_PARAM_NAME_LENGTH = 40;
/** Parameter values: 100 chars. */
export const MAX_PARAM_VALUE_LENGTH = 100;
/** Parameters per event: 25. */
export const MAX_PARAMS_PER_EVENT = 25;

/**
 * Strips control characters and caps length.
 *
 * UTM values arrive from the URL, so they are attacker- and user-controllable.
 * Nothing here should ever carry prose, but the cap and the control-character
 * strip mean a pasted paragraph is truncated to a harmless fragment rather than
 * shipped whole, and cannot smuggle newlines into a log.
 */
const CONTROL_CHARS = new RegExp('[\\u0000-\\u001F\\u007F]', 'g');

function sanitizeValue(value: GtagValue): GtagValue {
  if (typeof value !== 'string') return value;
  return value.replace(CONTROL_CHARS, '').slice(0, MAX_PARAM_VALUE_LENGTH);
}

// --- Approved parameters --------------------------------------------------

/**
 * Closed vocabularies. A value outside the set is dropped rather than sent, so
 * a typo at a call site shows up as a missing dimension instead of silently
 * fragmenting a report.
 */
const ENUM_PARAMS = {
  placement: ['hero', 'sticky_banner', 'footer', 'body', 'qr_code'],
  destination_store: ['app_store', 'play_store'],
  app_platform: ['ios', 'android'],
  device_category: ['mobile', 'tablet', 'desktop']
} as const satisfies Record<string, readonly string[]>;

/**
 * The exact parameter set each canonical event may carry. Anything else is
 * discarded before the event is sent.
 *
 * Campaign fields are prefixed `click_` deliberately. GA4 populates
 * `event_params.source`, `event_params.medium` and `event_params.campaign`
 * itself for last-touch attribution, so sending our own values under those
 * names writes into fields GA4 owns — they collide with built-in traffic-source
 * processing and are unreliable as custom dimensions. The prefixed names are
 * ours alone and register cleanly.
 */
const STORE_CLICK_PARAMS = [
  'placement',
  'page_path',
  'click_campaign',
  'click_source',
  'click_medium',
  'click_content',
  'click_term',
  'device_category',
  'destination_store',
  'external_url',
  'app_platform',
  'transport_type'
] as const;

const EVENT_PARAM_ALLOWLIST: Record<string, readonly string[]> = {
  app_store_click: STORE_CLICK_PARAMS,
  play_store_click: STORE_CLICK_PARAMS,
  get_landing_view: [
    'device_category',
    'click_campaign',
    'click_source',
    'click_medium',
    'click_content',
    'click_term',
    'transport_type'
  ],
  download: ['platform', 'version', 'placement', 'transport_type']
};

export const STORE_CLICK_PARAM_NAMES: readonly string[] = STORE_CLICK_PARAMS;

/**
 * Applies the allow-list and the enum vocabularies.
 *
 * Events with no allow-list entry (the older `*_click` events) are sanitized but
 * not filtered, so this change cannot silently blank an existing report.
 */
function buildPayload(name: string, parameters?: EventParams): Record<string, GtagValue> {
  const allowed = EVENT_PARAM_ALLOWLIST[name];
  const out: Record<string, GtagValue> = {};
  if (!parameters) return out;

  for (const [key, value] of Object.entries(parameters)) {
    if (value === undefined || value === null || value === '') continue;
    if (key.length > MAX_PARAM_NAME_LENGTH) continue;
    if (allowed && !allowed.includes(key)) continue;

    const vocabulary = ENUM_PARAMS[key as keyof typeof ENUM_PARAMS] as
      | readonly string[]
      | undefined;
    if (vocabulary && !vocabulary.includes(String(value))) continue;

    out[key] = sanitizeValue(value);
  }
  return out;
}

// --- Debug bus ------------------------------------------------------------

export interface DebugEventRecord {
  name: string;
  params: Record<string, GtagValue>;
  at: number;
  /** False when the GA4 tag is blocked or has not loaded yet. */
  gtagAvailable: boolean;
  /** True when the dedupe window swallowed this call. */
  suppressed: boolean;
  /** True for the deprecated `download` shadow of a store click. */
  legacy: boolean;
}

const MAX_DEBUG_RECORDS = 50;
const debugLog: DebugEventRecord[] = [];
const debugListeners = new Set<() => void>();

function recordDebug(record: DebugEventRecord) {
  debugLog.unshift(record);
  if (debugLog.length > MAX_DEBUG_RECORDS) debugLog.length = MAX_DEBUG_RECORDS;
  for (const listener of debugListeners) listener();
}

/** Most-recent event first. Read by the QA harness and the debug panel. */
export function getDebugLog(): readonly DebugEventRecord[] {
  return debugLog;
}

export function subscribeDebug(listener: () => void): () => void {
  debugListeners.add(listener);
  return () => debugListeners.delete(listener);
}

export function clearDebugLog() {
  debugLog.length = 0;
  for (const listener of debugListeners) listener();
}

/** Whether the real GA4 tag (not just the dataLayer shim) has loaded. */
export function isGtagAvailable(): boolean {
  return typeof window !== 'undefined' && typeof window.gtag === 'function';
}

// --- Transport ------------------------------------------------------------

export function logEvent(name: string, parameters?: EventParams, legacy = false) {
  const params = buildPayload(name, {
    // Beacon transport survives the page being torn down by a same-tab
    // navigation to the store, which is exactly when store clicks fire.
    transport_type: 'beacon',
    ...parameters
  });
  const available = isGtagAvailable();
  recordDebug({ name, params, at: Date.now(), gtagAvailable: available, suppressed: false, legacy });
  try {
    window.gtag?.('event', name, params);
  } catch {
    // Analytics may be blocked.
  }
}

/**
 * Pulls the deferred GA4 script forward.
 *
 * Ad landing pages are one-decision pages: the visitor may tap a store button
 * within a second, before `requestIdleCallback` has fired, and a same-tab
 * navigation would discard the queued `dataLayer` entry. Calling this on such a
 * page trades a little idle-time politeness for a conversion event that
 * actually arrives.
 */
export function ensureAnalyticsLoaded() {
  try {
    window.__loadPatternsAnalytics?.();
  } catch {
    // no-op
  }
}

// --- Store clicks (canonical conversion events) --------------------------

export type StoreTarget = 'app_store' | 'play_store';
export type StorePlacement = (typeof ENUM_PARAMS.placement)[number];

const STORE_EVENT: Record<StoreTarget, string> = {
  app_store: 'app_store_click',
  play_store: 'play_store_click'
};

const STORE_PLATFORM: Record<StoreTarget, string> = {
  app_store: 'ios',
  play_store: 'android'
};

/**
 * Suppression window for repeat fires of the same logical click.
 *
 * Guards against bubbling through a wrapping handler, a component remounting
 * its listener, and the double-fire that happens when both an anchor default
 * and a JS handler act on one tap. A real second tap on the same button is
 * ~always slower than this.
 */
const DEDUPE_WINDOW_MS = 1200;
const lastFired = new Map<string, number>();

/** Where the last store click was headed, so the debug panel can confirm it. */
const NAVIGATION_KEY = 'patterns_last_store_navigation';

export interface StoreNavigationRecord {
  url: string;
  store: StoreTarget;
  at: number;
  /** True once the page actually began unloading after the click. */
  confirmed: boolean;
}

function readNavigation(): StoreNavigationRecord | null {
  try {
    const raw = sessionStorage.getItem(NAVIGATION_KEY);
    return raw ? (JSON.parse(raw) as StoreNavigationRecord) : null;
  } catch {
    return null;
  }
}

function writeNavigation(record: StoreNavigationRecord) {
  try {
    sessionStorage.setItem(NAVIGATION_KEY, JSON.stringify(record));
  } catch {
    // Storage unavailable; diagnostics degrade, nothing else does.
  }
}

/** The most recent store hand-off, for `?analytics_debug=1`. */
export function getLastStoreNavigation(): StoreNavigationRecord | null {
  return readNavigation();
}

let unloadHookInstalled = false;

/**
 * Marks the pending hand-off as confirmed the moment the page starts to unload.
 * `pagehide` still permits a synchronous sessionStorage write, so a visitor who
 * comes back can see that the navigation really happened.
 */
function installUnloadHook() {
  if (unloadHookInstalled || typeof window === 'undefined') return;
  unloadHookInstalled = true;
  window.addEventListener('pagehide', () => {
    const pending = readNavigation();
    if (pending && !pending.confirmed && Date.now() - pending.at < 10_000) {
      writeNavigation({ ...pending, confirmed: true });
    }
  });
}

/** Coarse GA4-style device bucket, derived only from the UA string. */
export function deviceCategory(): 'mobile' | 'tablet' | 'desktop' {
  if (typeof navigator === 'undefined') return 'desktop';
  const ua = navigator.userAgent;
  const iPadOS = navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1;
  if (/iPad/.test(ua) || iPadOS) return 'tablet';
  if (/Android/.test(ua) && !/Mobile/.test(ua)) return 'tablet';
  if (/Android|iPhone|iPod|Mobi/.test(ua)) return 'mobile';
  return 'desktop';
}

/**
 * The canonical conversion event: emits `app_store_click` or `play_store_click`
 * stamped with placement and the session's campaign attribution.
 *
 * The legacy `download` event is emitted alongside so existing reports keep
 * working during the changeover; it is not the event to build on.
 */
export function trackStoreClick(
  store: StoreTarget,
  placement: StorePlacement,
  externalUrl: string
) {
  const key = `${store}:${placement}`;
  const now = Date.now();
  const previous = lastFired.get(key);
  if (previous !== undefined && now - previous < DEDUPE_WINDOW_MS) {
    recordDebug({
      name: STORE_EVENT[store],
      params: { placement, destination_store: store },
      at: now,
      gtagAvailable: isGtagAvailable(),
      suppressed: true,
      legacy: false
    });
    return;
  }
  lastFired.set(key, now);

  installUnloadHook();
  writeNavigation({ url: externalUrl, store, at: now, confirmed: false });

  const attribution = getAttribution();
  const pagePath =
    typeof window === 'undefined' ? undefined : window.location.pathname + window.location.search;

  logEvent(STORE_EVENT[store], {
    placement,
    page_path: pagePath,
    click_campaign: attribution.campaign,
    click_source: attribution.source,
    click_medium: attribution.medium,
    click_content: attribution.content,
    click_term: attribution.term,
    device_category: deviceCategory(),
    destination_store: store,
    external_url: externalUrl,
    app_platform: STORE_PLATFORM[store]
  });

  // Legacy, kept temporarily so pre-existing reports do not go blank. Flagged
  // so diagnostics report the canonical event rather than this shadow.
  logEvent(
    'download',
    {
      platform: store === 'app_store' ? 'iOS' : 'Android',
      version: 'store',
      placement
    },
    true
  );
}

/** Test seam. Not used by app code. */
export function resetStoreClickDedupe() {
  lastFired.clear();
  try {
    sessionStorage.removeItem(NAVIGATION_KEY);
  } catch {
    // no-op
  }
}

export function logGitHubClick() {
  logEvent('github_click');
}
