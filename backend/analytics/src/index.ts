import { MAX_BODY_BYTES, ValidationError, validateBatch } from "./validation";

interface RateLimitBinding {
  limit(options: { key: string }): Promise<{ success: boolean }>;
}

export interface Env {
  DB: D1Database;
  RATE_LIMITER?: RateLimitBinding;
}

const INSERT_EVENT = `
  INSERT INTO events (
    event_name,
    event_version,
    install_id,
    platform,
    app_version,
    event_timestamp,
    received_at
  ) VALUES (?, ?, ?, ?, ?, ?, ?)
`;

export const RETENTION_DAYS = 90;
const RETENTION_MS = RETENTION_DAYS * 24 * 60 * 60 * 1000;

function json(body: unknown, status = 200): Response {
  return Response.json(body, {
    status,
    headers: {
      "cache-control": "no-store",
      "content-type": "application/json; charset=utf-8",
    },
  });
}

class BodyTooLargeError extends Error {}

async function readBody(request: Request): Promise<string> {
  if (!request.body) return "";
  const reader = request.body.getReader();
  const chunks: Uint8Array[] = [];
  let size = 0;
  while (true) {
    const { done, value } = await reader.read();
    if (done) break;
    size += value.byteLength;
    if (size > MAX_BODY_BYTES) {
      await reader.cancel();
      throw new BodyTooLargeError();
    }
    chunks.push(value);
  }
  const body = new Uint8Array(size);
  let offset = 0;
  for (const chunk of chunks) {
    body.set(chunk, offset);
    offset += chunk.byteLength;
  }
  return new TextDecoder().decode(body);
}

async function ingest(request: Request, env: Env): Promise<Response> {
  const contentType = request.headers.get("content-type")?.toLowerCase() ?? "";
  if (!/^application\/json(?:\s*;|$)/.test(contentType)) {
    return json({ error: "Content-Type must be application/json" }, 400);
  }

  const declaredLength = Number(request.headers.get("content-length"));
  if (Number.isFinite(declaredLength) && declaredLength > MAX_BODY_BYTES) {
    return json({ error: "Request body is too large" }, 413);
  }

  let bodyText: string;
  try {
    bodyText = await readBody(request);
  } catch (error) {
    if (error instanceof BodyTooLargeError) {
      return json({ error: "Request body is too large" }, 413);
    }
    return json({ error: "Could not read request body" }, 400);
  }
  if (new TextEncoder().encode(bodyText).byteLength > MAX_BODY_BYTES) {
    return json({ error: "Request body is too large" }, 413);
  }

  let rawBody: unknown;
  try {
    rawBody = JSON.parse(bodyText);
  } catch {
    return json({ error: "Malformed JSON" }, 400);
  }

  let batch;
  try {
    batch = validateBatch(rawBody);
  } catch (error) {
    if (error instanceof ValidationError) {
      return json({ error: error.message }, 400);
    }
    return json({ error: "Invalid request" }, 400);
  }

  if (env.RATE_LIMITER) {
    const { success } = await env.RATE_LIMITER.limit({ key: batch.installId });
    if (!success) return json({ error: "Rate limit exceeded" }, 429);
  }

  const receivedAt = Date.now();
  const statement = env.DB.prepare(INSERT_EVENT);
  try {
    await env.DB.batch(
      batch.events.map((event) =>
        statement.bind(
          event.name,
          event.version,
          batch.installId,
          batch.platform,
          batch.appVersion,
          event.timestamp,
          receivedAt,
        ),
      ),
    );
  } catch {
    // Never log request bodies or installation identifiers.
    console.error("Analytics D1 batch insertion failed");
    return json({ error: "Event ingestion failed" }, 500);
  }

  return json({ accepted: batch.events.length }, 202);
}

export async function deleteExpiredEvents(
  db: D1Database,
  now = Date.now(),
): Promise<void> {
  const cutoff = now - RETENTION_MS;
  await db.prepare("DELETE FROM events WHERE received_at < ?").bind(cutoff).run();
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    if (request.method === "GET" && url.pathname === "/health") {
      return json({ status: "ok" });
    }
    if (request.method === "POST" && url.pathname === "/v1/events/batch") {
      return ingest(request, env);
    }
    return json({ error: "Not found" }, 404);
  },
  scheduled(
    _controller: ScheduledController,
    env: Env,
    context: ExecutionContext,
  ): void {
    context.waitUntil(
      deleteExpiredEvents(env.DB).catch(() => {
        // Never log rows or installation identifiers.
        console.error("Analytics retention cleanup failed");
      }),
    );
  },
} satisfies ExportedHandler<Env>;
