import PatternsCore
import UIKit
import XCTest
@testable import Patterns

/// Rollback drill, step 1: writes records into the app's real data through
/// the same code the screens use (the rich-text editor, the repositories,
/// the materials store), so a Flutter build installed over native 2.0 can
/// be checked against data that native wrote.
///
/// Skipped unless asked for, because it adds entries to whatever simulator
/// it runs on:
///
///     TEST_RUNNER_PATTERNS_ROLLBACK_DRILL=1 xcodebuild test … \
///       -only-testing:PatternsAppTests/RollbackDrillWriter
@MainActor
final class RollbackDrillWriter: XCTestCase {
    func testWriteNativeRecords() throws {
        try XCTSkipUnless(ProcessInfo.processInfo.environment["PATTERNS_ROLLBACK_DRILL"] == "1",
                          "Set PATTERNS_ROLLBACK_DRILL=1 to write drill records into this simulator's data.")
        let support = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask,
                                                  appropriateFor: nil, create: false)
        let database = try PatternsDatabase.open(at: support.appendingPathComponent(PatternsSchema.databaseFileName))
        let materials = MaterialFileStore(supportDirectory: support)

        // Journal: typed through the native editor, with bold and a bullet.
        let controller = RichEditorController()
        let textView = UITextView(usingTextLayoutManager: true)
        controller.attach(textView)
        controller.load(RichDocument(stored: ""))
        textView.insertText("Rollback drill, written by native 2.0. ")
        controller.toggleBold()
        textView.insertText("Bold part")
        controller.toggleBold()
        textView.insertText(" and plain end.\nA bulleted line")
        controller.toggleBullet()
        let stored = controller.document.stored
        XCTAssertTrue(stored.contains("\"bold\":true"), stored)
        XCTAssertTrue(stored.contains("bullet"), stored)
        _ = try database.saveJournalEntry(date: JournalEntry.dayKey(for: Date()), content: stored)

        // Tracker, urge surf and an image material with its file.
        let now = DartTimestamp.now()
        _ = try database.insertOcdEntry(OcdEntry(
            type: .compulsion, datetime: now, content: "Rollback drill: urge to re-check (native)",
            distressLevel: 6, response: "Delayed it", actionTaken: nil, createdAt: now))
        _ = try database.insertUrgeSurfSession(UrgeSurfSession(
            datetime: now, trigger: "Rollback drill (native)", initialUrge: 7, peakUrge: 8, finalUrge: 3,
            durationSeconds: 180, note: "Native wrote this", createdAt: now))
        let image = UIGraphicsImageRenderer(size: CGSize(width: 120, height: 80)).image { context in
            UIColor.systemTeal.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 120, height: 80))
        }
        let name = MaterialFileStore.generatedName(extension: "jpg")
        try materials.write(try XCTUnwrap(image.jpegData(compressionQuality: 0.9)), named: name)
        _ = try database.insertExposureMaterial(ExposureMaterial(
            type: .image, title: "Rollback drill image (native)", fileName: name, createdAt: now))
        _ = try database.insertExposureMaterial(ExposureMaterial(
            type: .script, title: "Rollback drill script (native)", text: "Maybe, maybe not. Written by native.",
            createdAt: now))
        print("ROLLBACK_DRILL journal=\(stored) image=\(name)")
    }
}
