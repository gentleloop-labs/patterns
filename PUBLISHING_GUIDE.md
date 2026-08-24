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
Your journal entries and OCD records stay on your device. There is no account, cloud sync, advertising, or third-party analytics SDK. Optional, default-off anonymous product analytics can share feature-use events, but never journal entries, intrusive thoughts, compulsions, exposures, notes, ratings, or other personal OCD content.

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
- Patterns Pro is now available as a one-time unlock, with no subscription

Your journal entries and OCD records remain on-device. Optional anonymous product analytics are now explained and controlled in Privacy settings.

**Keywords (iOS, 100 characters maximum):**

`ocd,erp,compulsion,intrusive thoughts,journal,anxiety,exposure,habit,cbt,self care`

### Pricing
- **Patterns Pro (iOS, Android):** **US$39.99** one-time purchase, with local pricing elsewhere (Apple generates those from the US base price, so they are not all $39.99 equivalents). Raised from US$14.99 on 16 August 2026. The rise was first scheduled for 15 August 2026 and did not go through; it was applied manually the next day.
- **Patterns Desktop Pro (macOS, Windows, Linux):** US$9.99 one-time licence via Lemon Squeezy. Unchanged.
- Pro is a **one-time purchase and stays one**. There is no subscription, and no annual plan. Do not describe it as one anywhere.
- Present the price that is actually being charged right now, which is US$39.99. Do not quote US$14.99 anywhere, and never announce a future price change with a date attached. A date the store has not honoured reads as though the rise already happened, and dangles a deadline discount nobody can take.
- Existing Pro owners keep their access and are never charged again. Say so wherever the new price is mentioned.

#### How the rise to US$39.99 is made
The product ID **`com.maskedsyntax.patterns.pro` never changes**. It is a
non-consumable, so raising its price does not affect anyone who already owns it:
neither store re-charges for a non-consumable, and restore keeps returning it.

- Apply the price change to the existing product in **App Store Connect** and **Google Play Console**.
- **Never** delete, deactivate or rename the product. That is the one action that would strand every existing purchaser, because restore would stop returning it.
- No new in-app product is created. There is nothing to migrate.
- **Pro stays a one-time purchase.** No subscription tier, annual or otherwise. This was reconsidered and rejected on 16 August 2026: "never a subscription" is stated in the app paywall, four pages of the site and four blog posts, and `website/src/lib/data/copy-guards.test.ts` fails the build on any per-year price string. Adding one would cost more in trust than it returns.

#### Switching the copy over (done 16 August 2026)
Completed for the rise to US$39.99. Kept as the procedure for any future change.
Do not run it until the paywall shows the new price on a device with **no local
StoreKit config**, which is the only check that reads the real storefront. A
simulator using `ios/Patterns.storekit` shows that file's price regardless of
the live storefront, so it proves nothing. `flutter run` does not apply the
scheme's StoreKit config either, because it installs via simctl.

1. `website/src/routes/+page.svelte` - the JSON-LD `priceSpecification.price`. This is the figure search engines repeat, so it goes stale most visibly.
2. `website/src/lib/data/faq.ts` - the cost answer. Also feeds FAQPage structured data.
3. `website/src/routes/roadmap/+page.svelte` - move the pricing card between columns so it is not still sitting in "Almost ready" after it has shipped.
4. `website/src/content/blog/between-therapy-sessions.md` - the pricing paragraph.
5. This file: the two Pricing bullets above.
6. `website/src/lib/data/copy-guards.test.ts` - invert the date-sensitive guards so they assert the new price is current and the old figure appears nowhere. They are written to fail while the copy is stale, which is the point; update them last so they gate the rest.

The site is a deploy, not a release. It does not wait for App Review, and it
must not be held back to ship alongside an app update: that would leave the site
quoting a price lower than the store actually charges for the length of a review
cycle. Deploy it as soon as the live price is confirmed.

## 2. Privacy Policy
- **URL:** [https://patternsocd.com/privacy](https://patternsocd.com/privacy)
- **OCD Data:** Journal entries, obsessions, compulsions, exposures, notes, ratings, Y-BOCS answers, and recovery content remain on-device and are never included in analytics.
- **Optional Analytics:** When a user enables **Share Anonymous Usage Analytics**, Patterns sends only a random installation UUID, coarse platform, app version, and whitelisted feature event name/version/time to the first-party Cloudflare Worker. The identifier is not based on an account or device identifier.
- **Retention:** Uploaded analytics events are automatically deleted after 90 days, based on their server receipt time.
- **Data Deletion:** Users can delete individual entries or wipe local app data. Turning analytics off immediately deletes the pending analytics queue and local analytics installation ID. Previously uploaded anonymous events cannot be associated with an account or individually retrieved; they expire automatically within 90 days.

### App Store Connect Privacy Answers
- **Data collected:** Yes.
- **Usage Data → Product Interaction:** Collected for Analytics; not linked to identity; not used for tracking.
- **Identifiers → Device ID:** Collected for Analytics; not linked to identity; not used for tracking. This is the conservative classification for the random app-installation UUID.
- **Tracking:** No.
- **Third-party tracking or advertising SDKs:** No.
- **Privacy Policy URL:** `https://patternsocd.com/privacy`

The analytics capability is optional and default-off, but it must still be disclosed
for a release that can collect it. Do not select Health, Sensitive Information,
Purchase History, or User Content: none of those values are sent to this service.
Apple processes App Store purchases under its own terms; Patterns sends only the
closed `purchase_started` and confirmed `purchase_completed` feature events, never
price, receipt, transaction, StoreKit, account, or RevenueCat identifiers.

### Google Play Data Safety Answers
- **Data collection:** Yes.
- **App activity → App interactions:** Collected, optional, for Analytics.
- **Device or other IDs:** Collected, optional, for Analytics. This is the conservative classification for the random app-installation UUID.
- **Data sharing:** No, if Cloudflare remains a service provider processing data only on Patterns' behalf; confirm the current Cloudflare terms before submitting.
- **Data processed ephemerally:** No; events are retained for up to 90 days.
- **Data encrypted in transit:** Yes; production uploads require HTTPS.
- **Users can request server-side data deletion:** No. Opt-out clears local analytics data, while previously uploaded anonymous rows expire automatically within 90 days and cannot be retrieved by account.
- **Privacy Policy URL:** `https://patternsocd.com/privacy`

Do not select Health and fitness, Personal info, Financial info, or User-generated
content for this analytics service. Google Play Billing processes payment details
under Google's terms; Patterns does not access payment-card information or transmit
prices, receipts, transaction identifiers, or RevenueCat identities to analytics.

### App Review Notes
Patterns is a local-first journaling and OCD self-tracking app. It does not create an account, upload user entries or OCD records, provide diagnosis, provide treatment, or replace professional care. Users may opt into first-party anonymous product analytics in Privacy settings. The service receives only a random installation UUID, coarse platform, app version, and closed feature event names/version/timestamps; it never receives journal text, intrusive thoughts, compulsions, exposures, notes, ratings, Y-BOCS answers, purchase records, or other personal OCD data. Opt-out clears pending events and the local identifier. Server events expire automatically after 90 days. Users can manually export an unencrypted JSON backup or PDF report and delete all local app data from Settings.

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
