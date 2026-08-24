import { env } from "cloudflare:test";
import { beforeEach, describe, expect, it } from "vitest";
import {
  deleteExpiredEvents,
  RETENTION_CLEANUP_DAYS,
  RETENTION_POLICY_DAYS,
} from "../src/index";
import worker from "../src/index";

const validInstallId = "8dcf21e4-2372-4a43-8b78-53eb07bcf7fd";

function payload(overrides: Record<string, unknown> = {}) {
  return {
    installId: validInstallId,
    platform: "ios",
    appVersion: "1.8.0+30",
    events: [{ name: "app_opened", version: 1, timestamp: Date.now() }],
    ...overrides,
  };
}

async function post(body: string, headers: Record<string, string> = {}) {
  const request = new Request("https://analytics.example/v1/events/batch", {
    method: "POST",
    headers: { "content-type": "application/json", ...headers },
    body,
  });
  return worker.fetch(request, env);
}

beforeEach(async () => {
  await env.DB.prepare("DELETE FROM events").run();
});

describe("POST /v1/events/batch", () => {
  it("accepts a valid batch and inserts every event in D1", async () => {
    const response = await post(JSON.stringify(payload({
      events: [
        { name: "app_opened", version: 1, timestamp: Date.now() - 1000 },
        { name: "erp_session_completed", version: 1, timestamp: Date.now() },
      ],
    })));

    expect(response.status).toBe(202);
    expect(await response.json()).toEqual({ accepted: 2 });
    const result = await env.DB.prepare(
      "SELECT event_name, install_id, platform, app_version FROM events ORDER BY id",
    ).all();
    expect(result.results).toEqual([
      {
        event_name: "app_opened",
        install_id: validInstallId,
        platform: "ios",
        app_version: "1.8.0+30",
      },
      {
        event_name: "erp_session_completed",
        install_id: validInstallId,
        platform: "ios",
        app_version: "1.8.0+30",
      },
    ]);
  });

  it.each([
    ["unknown event", payload({ events: [{ name: "journal_text", version: 1, timestamp: Date.now() }] })],
    ["invalid UUID", payload({ installId: "not-a-uuid" })],
    ["invalid platform", payload({ platform: "iphone-15-pro" })],
    ["missing fields", { installId: validInstallId }],
    ["unexpected root field", payload({ journalEntry: "sensitive" })],
    ["unexpected event field", payload({ events: [{ name: "app_opened", version: 1, timestamp: Date.now(), properties: { note: "sensitive" } }] })],
  ])("rejects %s", async (_label, value) => {
    const response = await post(JSON.stringify(value));
    expect(response.status).toBe(400);
  });

  it("rejects batches larger than 50", async () => {
    const events = Array.from({ length: 51 }, () => ({
      name: "app_opened",
      version: 1,
      timestamp: Date.now(),
    }));
    expect((await post(JSON.stringify(payload({ events })))).status).toBe(400);
  });

  it("rejects malformed JSON", async () => {
    expect((await post("{nope")).status).toBe(400);
  });

  it("accepts only the application/json media type", async () => {
    expect((await post(JSON.stringify(payload()), { "content-type": "text/plain" })).status).toBe(400);
    expect((await post(JSON.stringify(payload()), { "content-type": "application/jsonp" })).status).toBe(400);
  });

  it("rejects oversized bodies", async () => {
    const response = await post("{}", { "content-length": "20000" });
    expect(response.status).toBe(413);

    const streamed = await post("x".repeat(16 * 1024 + 1));
    expect(streamed.status).toBe(413);
  });
});

describe("public routes", () => {
  it("exposes health but no analytics read endpoint", async () => {
    const health = await worker.fetch(new Request("https://analytics.example/health"), env);
    expect(health.status).toBe(200);
    expect(await health.json()).toEqual({ status: "ok" });

    for (const path of ["/events", "/analytics", "/users"]) {
      const response = await worker.fetch(new Request(`https://analytics.example${path}`), env);
      expect(response.status).toBe(404);
    }
  });
});

describe("retention", () => {
  it("uses a daily-cleanup margin that keeps retention within 90 days", async () => {
    const now = Date.UTC(2026, 7, 25);
    const dayMs = 24 * 60 * 60 * 1000;
    const insert = env.DB.prepare(`
      INSERT INTO events (
        event_name, event_version, install_id, platform, app_version,
        event_timestamp, received_at
      ) VALUES (?, 1, ?, 'ios', '1.8.0', ?, ?)
    `);
    await env.DB.batch([
      insert.bind("app_opened", validInstallId, now - 90 * dayMs, now - 90 * dayMs),
      insert.bind("app_opened", validInstallId, now - 89 * dayMs, now - 89 * dayMs),
      insert.bind(
        "app_opened",
        validInstallId,
        now - 89 * dayMs + 1,
        now - 89 * dayMs + 1,
      ),
    ]);

    expect(RETENTION_POLICY_DAYS).toBe(90);
    expect(RETENTION_CLEANUP_DAYS).toBe(89);
    await deleteExpiredEvents(env.DB, now);

    const result = await env.DB.prepare(
      "SELECT received_at FROM events ORDER BY received_at",
    ).all();
    expect(result.results).toEqual([{ received_at: now - 89 * dayMs + 1 }]);
  });
});
