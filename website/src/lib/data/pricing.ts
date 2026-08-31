/**
 * Patterns Pro pricing, kept in one place so the page, the FAQ, and the
 * JSON-LD offer cannot drift apart.
 *
 * Pro rose to $39.99 on 16 August 2026 and came back down to $19.99 on
 * 31 August 2026, confirmed against the App Store Connect price schedule. The
 * old figure stays here on purpose: a drop is only legible if the site says
 * what the price used to be.
 *
 * Only the US price is published. Every other storefront is priced off Apple's
 * equalized ladder, and India is priced manually, so quoting local figures on
 * the site is more upkeep than it is worth.
 */
export const proPricing = {
  previousUsd: '$39.99',
  currentUsd: '$19.99',
  currentUsdAmount: '19.99',
  currency: 'USD'
} as const;
