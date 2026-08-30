import { EVENT_NAME_SET, isAllowedContext, type EventName } from "./events";

export const MAX_BODY_BYTES = 16 * 1024;
export const MAX_BATCH_SIZE = 50;

const ROOT_FIELDS = new Set(["installId", "platform", "appVersion", "events"]);
const EVENT_FIELDS = new Set(["name", "version", "timestamp", "context"]);
const PLATFORMS = new Set(["ios", "android", "macos", "windows", "linux", "web"]);
const UUID_V4 = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
const APP_VERSION = /^[A-Za-z0-9][A-Za-z0-9._+-]*$/;
const EARLIEST_TIMESTAMP = Date.UTC(2020, 0, 1);
const MAX_FUTURE_SKEW_MS = 24 * 60 * 60 * 1000;

export interface ValidatedEvent {
  name: EventName;
  version: 1 | 2;
  timestamp: number;
  context: string | null;
}

export interface ValidatedBatch {
  installId: string;
  platform: string;
  appVersion: string | null;
  events: ValidatedEvent[];
}

export class ValidationError extends Error {}

function isObject(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function rejectUnknownFields(value: Record<string, unknown>, allowed: ReadonlySet<string>): void {
  for (const key of Object.keys(value)) {
    if (!allowed.has(key)) throw new ValidationError(`Unknown field: ${key}`);
  }
}

export function validateBatch(value: unknown, now = Date.now()): ValidatedBatch {
  if (!isObject(value)) throw new ValidationError("Body must be a JSON object");
  rejectUnknownFields(value, ROOT_FIELDS);

  const { installId, platform, appVersion, events } = value;
  if (typeof installId !== "string" || !UUID_V4.test(installId)) {
    throw new ValidationError("installId must be a UUID v4");
  }
  if (typeof platform !== "string" || !PLATFORMS.has(platform)) {
    throw new ValidationError("Invalid platform");
  }
  if (
    appVersion !== null &&
    appVersion !== undefined &&
    (typeof appVersion !== "string" ||
      appVersion.length < 1 ||
      appVersion.length > 32 ||
      !APP_VERSION.test(appVersion))
  ) {
    throw new ValidationError("Invalid appVersion");
  }
  if (!Array.isArray(events) || events.length < 1) {
    throw new ValidationError("events must be a non-empty array");
  }
  if (events.length > MAX_BATCH_SIZE) {
    throw new ValidationError(`events cannot contain more than ${MAX_BATCH_SIZE} items`);
  }

  const validatedEvents = events.map((event, index): ValidatedEvent => {
    if (!isObject(event)) throw new ValidationError(`events[${index}] must be an object`);
    rejectUnknownFields(event, EVENT_FIELDS);
    if (typeof event.name !== "string" || !EVENT_NAME_SET.has(event.name)) {
      throw new ValidationError(`events[${index}].name is not allowed`);
    }
    if (event.version !== 1 && event.version !== 2) {
      throw new ValidationError(`events[${index}].version must be 1 or 2`);
    }
    if (event.version === 1 && event.context !== undefined) {
      throw new ValidationError(`events[${index}].context requires version 2`);
    }
    if (
      event.version === 2 &&
      (typeof event.context !== "string" ||
        event.context.length > 32 ||
        !isAllowedContext(event.name as EventName, event.context))
    ) {
      throw new ValidationError(`events[${index}].context is not allowed`);
    }
    if (
      typeof event.timestamp !== "number" ||
      !Number.isSafeInteger(event.timestamp) ||
      event.timestamp < EARLIEST_TIMESTAMP ||
      event.timestamp > now + MAX_FUTURE_SKEW_MS
    ) {
      throw new ValidationError(`events[${index}].timestamp is invalid`);
    }
    return {
      name: event.name as EventName,
      version: event.version,
      timestamp: event.timestamp,
      context: typeof event.context === "string" ? event.context : null,
    };
  });

  return {
    installId: installId.toLowerCase(),
    platform,
    appVersion: typeof appVersion === "string" ? appVersion : null,
    events: validatedEvents,
  };
}
