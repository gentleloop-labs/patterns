/// The release whose What's New someone has seen, stored in
/// `lastSeenReleaseId` (`currentReleaseId` in `lib/app_preferences.dart`).
///
/// iOS only: Android stays on Flutter's `patterns_1_10` until it ships its
/// own release, so everyone updating an iPhone sees the 2.0 screen once.
enum AppRelease {
    static let currentID = "patterns_2_0"
}
