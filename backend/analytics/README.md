# Patterns first-party analytics

Privacy-preserving product analytics for Patterns, implemented as a Cloudflare
Worker backed by D1. The Flutter app queues a closed vocabulary of anonymous
feature events locally and uploads batches only when both the build configuration
and the user's **Share Anonymous Usage Analytics** preference allow it.

```text
Patterns Flutter app
  -> capped SharedPreferences event queue
  -> POST /v1/events/batch
  -> Cloudflare Worker validation + per-install rate limit
  -> D1 events table
```

There are no analytics read routes. `GET /health` is the only public GET route.

## Privacy model

Each request contains only:

- a random UUID v4 analytics installation ID;
- platform (`ios`, `android`, `macos`, `windows`, `linux`, or `web`);
- app version;
- whitelisted event name, schema version, and client timestamp in Unix epoch
  milliseconds.

The ID is generated when the first enabled queue is uploaded. It is not based on
device or account information and is used only by this service. It remains stable
across ordinary launches. Opting out deletes both the pending queue and ID; opting
back in creates a new ID. App data is normally removed on uninstall, so a fresh
install normally gets a fresh ID. An OS-level full-device backup/restore may restore
app preferences, depending on platform backup behavior.

Opt-out cannot identify and delete rows that were already uploaded: there is no
account, the app deliberately has no analytics read/delete API, and the local ID is
discarded. Uploaded rows are retained for no more than 90 days. Cleanup begins at
89 days and runs daily at 03:17 UTC, providing a full scheduling-day margin before
the public maximum. It uses server receipt time so a forged client timestamp cannot
extend storage.

Never add journal text, obsession/compulsion descriptions, intrusive thoughts,
exposures, notes, Y-BOCS answers/results, distress/anxiety/recovery scores, OCD
subtypes, clinical categories, purchase prices, receipts, transaction IDs,
RevenueCat IDs, account identifiers, advertising IDs, device fingerprints, IP
location, precise location, screenshots, or any other user-entered OCD content.
The Worker does not inspect Cloudflare request location fields and logs neither
request bodies nor installation IDs.

## Prerequisites and install

- Node.js 20 or newer
- a Cloudflare account with Workers and D1 access

From `backend/analytics`:

```bash
npm install
npx wrangler login
```

## Create and migrate D1

The production database is already provisioned for the configured Cloudflare
account. To provision the backend in another account, create a database:

```bash
npx wrangler d1 create patterns-analytics-db
```

Copy the returned database ID into the `DB` entry in `wrangler.jsonc`. A D1 database
ID identifies a resource but is not an account credential. Then apply the managed
migrations:

```bash
npx wrangler d1 migrations apply patterns-analytics-db --remote
```

The `DB` binding is already configured. The rate-limit binding allows 120 accepted
ingestion attempts per minute per validated installation ID. `namespace_id` is an
account-local application namespace, not a secret; change `1001` if that namespace
is already used by another rate-limit binding in the same Cloudflare account.
Cloudflare's limiter is deliberately keyed by the random install ID, not IP address.

## Local development and tests

```bash
npm run dev
npm test
npm run check
```

Wrangler creates a local D1 database for development. Tests use Cloudflare's Vitest
runtime, apply every checked-in migration, exercise ingestion and 90-day retention,
and inspect the D1 rows. They never call production.

Example local request:

```bash
curl -i http://localhost:8787/v1/events/batch \
  -H 'content-type: application/json' \
  --data '{"installId":"8dcf21e4-2372-4a43-8b78-53eb07bcf7fd","platform":"ios","appVersion":"1.8.0+30","events":[{"name":"app_opened","version":1,"timestamp":1787571200000}]}'
```

## Deploy

After the database ID is configured and the remote migration is applied:

```bash
npx wrangler deploy
```

Copy the resulting `https://...workers.dev` URL into the Flutter production build
configuration described below. `/health` can be checked without exposing data:

```bash
curl https://YOUR-WORKER.workers.dev/health
```

## Flutter configuration

Analytics is build-disabled by default, including tests and normal developer builds.
For local Worker testing:

```bash
flutter run \
  --dart-define=PATTERNS_ANALYTICS_ENV=development \
  --dart-define=PATTERNS_ANALYTICS_DEV_ENDPOINT=http://localhost:8787
```

For a production build, put the deployed Worker origin in
`PATTERNS_ANALYTICS_PROD_ENDPOINT`:

```bash
flutter build ipa \
  --dart-define=PATTERNS_ANALYTICS_ENV=production \
  --dart-define=PATTERNS_ANALYTICS_PROD_ENDPOINT=https://YOUR-WORKER.workers.dev
```

Use the equivalent defines with `flutter build appbundle`, `macos`, or `windows`.
The endpoint is centralized in `lib/services/usage_analytics.dart`; it is not
hardcoded in UI code.

Because existing public copy promises no remote analytics, user consent defaults
off. After privacy disclosures and store labels have been updated, a product owner
can intentionally change the build default with:

```bash
--dart-define=PATTERNS_ANALYTICS_DEFAULT_ENABLED=true
```

Without that define, a user must enable the Settings toggle. Turning it off stops
new collection, clears unsent events, and deletes the analytics installation ID.

## Event whitelist

The v1 whitelist is:

```text
app_opened
onboarding_started
onboarding_completed
journal_opened
journal_entry_created
erp_opened
erp_session_started
erp_session_completed
compulsion_delay_started
compulsion_delay_completed
insights_opened
paywall_viewed
purchase_started
purchase_completed
```

To add an event, make a deliberate schema review and update both:

1. `src/events.ts` (the independent server whitelist), and
2. `UsageAnalyticsEvent` plus its wire-name mapping in
   `lib/services/usage_analytics.dart`.

Do not add a generic event name or properties dictionary. Bump the accepted schema
version deliberately if an event's meaning changes.

## Querying D1

Run a query with:

```bash
npx wrangler d1 execute patterns-analytics-db --remote \
  --command 'SELECT event_name, COUNT(*) AS total FROM events GROUP BY event_name ORDER BY total DESC;'
```

### Event totals

```sql
SELECT event_name, COUNT(*) AS total
FROM events
GROUP BY event_name
ORDER BY total DESC;
```

### Unique installs

```sql
SELECT COUNT(DISTINCT install_id) AS unique_installs FROM events;
```

### Onboarding funnel

```sql
WITH installs AS (
  SELECT install_id,
    MAX(event_name = 'app_opened') AS opened,
    MAX(event_name = 'onboarding_started') AS started,
    MAX(event_name = 'onboarding_completed') AS completed
  FROM events GROUP BY install_id
)
SELECT
  SUM(opened) AS app_opened_installs,
  SUM(started) AS onboarding_started_installs,
  SUM(completed) AS onboarding_completed_installs,
  ROUND(100.0 * SUM(started) / NULLIF(SUM(opened), 0), 1) AS opened_to_started_pct,
  ROUND(100.0 * SUM(completed) / NULLIF(SUM(started), 0), 1) AS started_to_completed_pct
FROM installs;
```

### Activation

Activation means an observed install has at least one `journal_entry_created`,
`erp_session_completed`, or `compulsion_delay_completed` event.

```sql
WITH installs AS (
  SELECT install_id,
    MAX(event_name IN (
      'journal_entry_created',
      'erp_session_completed',
      'compulsion_delay_completed'
    )) AS activated
  FROM events GROUP BY install_id
)
SELECT COUNT(*) AS observed_installs,
  SUM(activated) AS activated_installs,
  ROUND(100.0 * SUM(activated) / NULLIF(COUNT(*), 0), 1) AS activation_pct
FROM installs;
```

### Monetization funnel

```sql
WITH installs AS (
  SELECT install_id,
    MAX(event_name = 'paywall_viewed') AS viewed,
    MAX(event_name = 'purchase_started') AS started,
    MAX(event_name = 'purchase_completed') AS completed
  FROM events GROUP BY install_id
)
SELECT SUM(viewed) AS paywall_installs,
  SUM(started) AS purchase_started_installs,
  SUM(completed) AS purchase_completed_installs,
  ROUND(100.0 * SUM(started) / NULLIF(SUM(viewed), 0), 1) AS view_to_start_pct,
  ROUND(100.0 * SUM(completed) / NULLIF(SUM(started), 0), 1) AS start_to_purchase_pct
FROM installs;
```

### ERP completion

```sql
WITH installs AS (
  SELECT install_id,
    MAX(event_name = 'erp_session_started') AS started,
    MAX(event_name = 'erp_session_completed') AS completed
  FROM events GROUP BY install_id
)
SELECT SUM(started) AS started_installs,
  SUM(completed) AS completed_installs,
  ROUND(100.0 * SUM(completed) / NULLIF(SUM(started), 0), 1) AS completion_pct
FROM installs;
```

### Approximate D1, D7, and D30 retention

The first observed UTC day for an installation is day 0. An installation is retained
at D1/D7/D30 if it sends any whitelisted event on exactly the corresponding UTC day.
Only cohorts old enough to reach the target day are included. Because consent is off
by default and can begin later, “first observed” is not necessarily true install day.
The 90-day storage window supports these D1/D7/D30 calculations but intentionally
does not provide long-term historical cohorts.

```sql
WITH activity AS (
  SELECT DISTINCT install_id, CAST(event_timestamp / 86400000 AS INTEGER) AS day
  FROM events
), first_seen AS (
  SELECT install_id, MIN(day) AS first_day FROM activity GROUP BY install_id
), targets(day_n) AS (VALUES (1), (7), (30)), eligible AS (
  SELECT f.install_id, f.first_day, t.day_n
  FROM first_seen f CROSS JOIN targets t
  WHERE f.first_day <= CAST(unixepoch('now') / 86400 AS INTEGER) - t.day_n
)
SELECT e.day_n,
  COUNT(*) AS eligible_installs,
  SUM(EXISTS(
    SELECT 1 FROM activity a
    WHERE a.install_id = e.install_id AND a.day = e.first_day + e.day_n
  )) AS retained_installs,
  ROUND(100.0 * SUM(EXISTS(
    SELECT 1 FROM activity a
    WHERE a.install_id = e.install_id AND a.day = e.first_day + e.day_n
  )) / NULLIF(COUNT(*), 0), 1) AS retention_pct
FROM eligible e
GROUP BY e.day_n
ORDER BY e.day_n;
```

## Validation and abuse resistance

The Worker accepts only `application/json`, caps bodies at 16 KiB and batches at 50,
rejects unknown fields, checks UUID v4/platform/app-version/timestamp/version/event
name, and inserts only prepared bindings through one D1 batch. Timestamps earlier
than 2020 or more than 24 hours in the future are rejected. Invalid requests are 400,
oversized requests 413, rate-limited requests 429, and successful batches 202.

The mobile app contains no server secret. The public ingestion endpoint can still be
automated by an attacker; strict validation, bounded work, Cloudflare rate limiting,
and the absence of public read routes limit the impact. Add account-level WAF rules
if traffic patterns later justify them.

## Retention operations

`wrangler.jsonc` registers the daily `17 3 * * *` UTC cron. The scheduled handler
deletes rows once their Worker-generated `received_at` reaches 89 days. The
one-day scheduling margin keeps normal daily cleanup within the public 90-day
maximum. Migration `0002_received_at_index.sql` indexes that column so cleanup
remains bounded by the retention range rather than scanning unexpired rows.

Check the trigger after deployment in **Workers & Pages → patterns-analytics →
Triggers**. To inspect the age of retained rows without exposing a public route:

```bash
npx wrangler d1 execute patterns-analytics-db --remote \
  --command 'SELECT MIN(received_at) AS oldest_received_at, MAX(received_at) AS newest_received_at, COUNT(*) AS rows FROM events;'
```
