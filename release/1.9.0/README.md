# Patterns 1.9.0 release guardrails

The live 1.8 listing and $39.99 IAP remain unchanged until the 1.9 public
release date is chosen. Set `RELEASE_DATE` to that date (`YYYY-MM-DD`) before
running the guarded commands below.

## Production analytics build setting

The production worker is deployed and healthy at:

```text
https://patterns-analytics.maskedsyntax.workers.dev
```

Release builds use this endpoint by default. To override it during an endpoint
migration, add this Xcode Cloud workflow environment variable (it is public
configuration, not a secret):

```text
PATTERNS_ANALYTICS_PROD_ENDPOINT=https://patterns-analytics.maskedsyntax.workers.dev
```

`ios/ci_scripts/ci_post_clone.sh` turns an override into the required production
Dart defines. Debug builds remain analytics-disabled by default. Android release
candidates also use the production endpoint by default; the explicit form is:

```bash
flutter build appbundle --release \
  --dart-define=PATTERNS_ANALYTICS_ENV=production \
  --dart-define=PATTERNS_ANALYTICS_PROD_ENDPOINT=https://patterns-analytics.maskedsyntax.workers.dev
```

Analytics consent remains off until a user explicitly chooses to share.

## App Store metadata and coordinated price change

```bash
asc metadata validate --dir ./metadata --output table
asc metadata push --app 6762611172 --version 1.9.0 --platform IOS --dir ./metadata --dry-run --output table

asc iap pricing schedules create \
  --iap-id 6785513588 \
  --base-territory USA \
  --prices "eyJzIjoiNjc4NTUxMzU4OCIsInQiOiJVU0EiLCJwIjoiMTAxNzcifQ:${RELEASE_DATE},eyJzIjoiNjc4NTUxMzU4OCIsInQiOiJJTkQiLCJwIjoiMTAyNzMifQ:${RELEASE_DATE}"
```

Before applying metadata, create the 1.9 App Store version and pull it into the
canonical tree. Reconcile the generated file with `metadata/version/1.9.0`,
then create a durable review plan with `asc metadata plan`. Update the IAP
version localization from `metadata/iap/6785513588/en-US.json` only when the
new IAP version is in `PREPARE_FOR_SUBMISSION`.

Do not add `--confirm`, schedule pricing, upload screenshots, or submit a build
until the release candidate passes the test matrix and the effective date is
approved. Start the App Store phased release only after the version reaches
`READY_FOR_SALE`.
