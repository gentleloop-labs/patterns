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
  "analytics_consent_granted",
  "activation_completed",
  "pro_feature_tapped",
  "product_load_result",
  "purchase_canceled",
  "purchase_failed",
  "restore_started",
  "restore_completed",
  "restore_not_found",
  "restore_failed",
] as const;

export type EventName = (typeof EVENT_NAMES)[number];

export const EVENT_NAME_SET: ReadonlySet<string> = new Set(EVENT_NAMES);

export const ACTIVATION_CONTEXTS = new Set([
  "journal",
  "compulsion_delay",
  "guided_erp",
  "self_check",
]);

export const PRODUCT_LOAD_CONTEXTS = new Set([
  "success",
  "unavailable",
  "error",
]);

export const PRO_CONTEXTS = new Set([
  "settings",
  "today_next_step",
  "recovery_metrics",
  "exposure_hierarchy",
  "exposure_materials",
  "structured_programs",
  "action_planner",
  "implementation_intentions",
  "urge_surfing",
  "response_prevention",
  "uncertainty_training",
  "behavioral_experiments",
  "reflection_journal",
]);

const CONTEXTS_BY_EVENT: Readonly<Record<string, ReadonlySet<string>>> = {
  activation_completed: ACTIVATION_CONTEXTS,
  product_load_result: PRODUCT_LOAD_CONTEXTS,
  pro_feature_tapped: PRO_CONTEXTS,
  paywall_viewed: PRO_CONTEXTS,
  purchase_started: PRO_CONTEXTS,
  purchase_completed: PRO_CONTEXTS,
  purchase_canceled: PRO_CONTEXTS,
  purchase_failed: PRO_CONTEXTS,
  restore_started: PRO_CONTEXTS,
  restore_completed: PRO_CONTEXTS,
  restore_not_found: PRO_CONTEXTS,
  restore_failed: PRO_CONTEXTS,
};

export function isAllowedContext(name: EventName, context: string): boolean {
  return CONTEXTS_BY_EVENT[name]?.has(context) ?? false;
}
