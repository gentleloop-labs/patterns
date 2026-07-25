# Publishing Guide — Patterns

This guide outlines the final steps and metadata required to publish **Patterns** to the Apple App Store and Google Play Store.

## 1. Store Metadata

### App Information
- **Name:** Patterns
- **Subtitle (iOS):** Journal, Track & Practise
- **Short Description (Android):** A private OCD journal with practical ERP tools, insights, and compulsion delay.
- **Primary Category:** Health & Fitness
- **Secondary Category (iOS):** Lifestyle
- **Primary Language:** English

### Descriptions
**Promotional Text (iOS, 170 characters maximum):**

New guided recovery tools help you delay compulsions, practise ERP, and see patterns over time—privately, with no account or subscription required to start.

**Full Description:**

Patterns is a focused, private space for daily journaling and understanding obsessive-compulsive patterns over time. Record what happened, notice how you responded, and practise creating space before acting on an urge—all without an account or social feed.

DAILY JOURNALING
Write a few quiet lines each day and build a chronological history you can revisit whenever you need it.

OCD TRACKING
Log obsessions and compulsions as they happen: the thought or urge, what you did in response, the strategy you used, and a distress rating from 0 to 10.

PRACTICAL RECOVERY TOOLS
Delay a compulsion, practise guided ERP, build an exposure hierarchy, work with uncertainty, and reflect on what you learned.

INSIGHTS WITHOUT JUDGMENT
See distress trends, journaling consistency, urge intensity, and ERP practice across 7-day, 30-day, 90-day, yearly, or custom ranges. Progress reflects practice—not a diagnosis or a clinical score.

PRIVATE BY DESIGN
Your journal entries and OCD records stay on your device. There is no account, cloud sync, advertising, or remote analytics. Small product-usage counters also remain on-device.

APP LOCK
Keep your reflections private with an optional Face ID, Touch ID, or device-passcode lock, plus a privacy screen when you switch apps.

EXPORT & BACKUP
Create a PDF report for a therapy session, or make a JSON backup that you control and can import again later.

PATTERNS PRO
Unlock the full recovery toolkit with one purchase. No subscription.

Patterns is for personal reflection and self-tracking only. It is not a medical device and does not diagnose, treat, or replace care from a qualified clinician.

**What's New in This Version:**

Patterns has been rebuilt around a calmer first session and one clear next step.

- Redesigned Today screen with practice progress and a focused next action
- New Compulsion Delay flow for creating space before responding to an urge
- Expanded ERP toolkit, including exposure hierarchies and uncertainty practice
- Rebuilt Insights with clearer trends, consistency, and practice context
- Faster journal navigation, search, and date-based entries
- Optional app lock and improved privacy explanations
- Patterns Pro is now available as a one-time unlock—no subscription

Your journal entries, OCD records, and product-usage counters remain on-device.

**Keywords (iOS, 100 characters maximum):**

`ocd,erp,compulsion,intrusive thoughts,journal,anxiety,exposure,habit,cbt,self care`

### Pricing
- **Patterns Pro:** US$14.99 one-time purchase through August/September 2026.
- **Planned price:** US$19.99 one-time purchase after the introductory period.
- Present US$14.99 as the current price, not as a guaranteed permanent or discounted price, unless a formal store promotion is configured.

## 2. Privacy Policy
- **URL:** [https://patternsocd.com/privacy](https://patternsocd.com/privacy)
- **Data Collection:** The app does not transmit user data to the developer or a third-party analytics service. Journal entries, OCD records, and product-usage counters are stored locally.
- **Data Deletion:** Users can delete individual entries or use the "Wipe all data" button in Settings to clear all local storage.

### App Store Connect Privacy Answers
- **Data collected:** No data collected.
- **Tracking:** No.
- **Third-party tracking or advertising SDKs:** No.
- **Privacy Policy URL:** `https://patternsocd.com/privacy`

Apple defines data processed only on the device as not collected. The local
telemetry counters therefore do not change the "No data collected" answer.
Apple processes App Store purchases; Patterns only stores the resulting Pro
entitlement locally.

### Google Play Data Safety Answers
- **Data collection:** No data collected.
- **Data sharing:** No data shared.
- **Data processed ephemerally:** No.
- **Data encrypted in transit:** Not applicable because the app does not transmit user data.
- **Users can request data deletion:** Yes, users can delete local entries and wipe all app data in Settings.
- **Privacy Policy URL:** `https://patternsocd.com/privacy`

Google defines collection as transmitting user data off the device. The local
telemetry counters do not meet that definition. Google Play Billing processes
payment details under Google's terms; Patterns does not access payment-card
information or send purchase data to a developer server.

### App Review Notes
Patterns is a local-first journaling and OCD self-tracking app. It does not create an account, transmit user entries or product-usage telemetry to a developer server, provide diagnosis, provide treatment, or replace professional care. Product-usage counters and recent funnel events remain in local SharedPreferences and are not uploaded. Users can manually export an unencrypted JSON backup or PDF report and can delete all local data from Settings.

If App Store Connect asks about regulated medical device status, answer that Patterns is not a regulated medical device. The app is for personal reflection and self-tracking only.

## 3. Screenshots Checklist
Prepare screenshots for:
- iPhone 6.9-inch slot: seven screenshots at 1290x2796.
- Android phone: seven screenshots at 1080x1920.
- Google Play feature graphic: 1024x500.
- No tablet screenshots are required while the app remains phone-only.

**Scenes to capture:**
1. Today: one clear next step
2. Compulsion Delay: active timer
3. Exposure Hierarchy: ladder detail
4. Insights: practice progress
5. Journal: date-based entry list
6. Settings: privacy and app lock
7. Patterns Pro: mobile purchase sheet

## 4. Release Signing (Android)

To build a release APK/AAB for Google Play:
1. Create a keystore: `keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`
2. Create `android/key.properties` (do NOT commit this):
   ```properties
   storePassword=<your-password>
   keyPassword=<your-password>
   keyAlias=upload
   storeFile=<path-to-keystore>
   ```
   You can copy `android/key.properties.example` as a starting point.
3. Run `flutter build appbundle`.
4. Verify the AAB is not debug-signed before uploading.

## 5. Final Verification
1. Run `flutter analyze`
2. Run `flutter test`
3. Build artifacts:
   - Android: `flutter build appbundle`
   - iOS: `flutter build ipa`
