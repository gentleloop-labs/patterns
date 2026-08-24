export const EVENT_NAMES = [
  "app_opened",
  "onboarding_started",
  "onboarding_completed",
  "journal_opened",
  "journal_entry_created",
  "erp_opened",
  "erp_session_started",
  "erp_session_completed",
  "compulsion_delay_started",
  "compulsion_delay_completed",
  "insights_opened",
  "paywall_viewed",
  "purchase_started",
  "purchase_completed",
] as const;

export type EventName = (typeof EVENT_NAMES)[number];

export const EVENT_NAME_SET: ReadonlySet<string> = new Set(EVENT_NAMES);
