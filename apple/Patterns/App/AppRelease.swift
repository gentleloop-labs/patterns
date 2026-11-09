/// `currentReleaseId` from `lib/app_preferences.dart`.
///
/// Kept at Flutter's 1.10 value for now: people who already saw the 1.10
/// What's New are not shown it again by the native build. The native
/// release gets its own id and copy once the 2.0 What's New text is written
/// (in the ARB files, so Android stays in step).
enum AppRelease {
    static let currentID = "patterns_1_10"
}
