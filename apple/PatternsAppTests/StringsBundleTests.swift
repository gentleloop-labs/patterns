import PatternsCore
import XCTest
@testable import Patterns

/// The ARB files must ship inside the app bundle, in every language.
final class StringsBundleTests: XCTestCase {
    func testEveryLanguageLoadsFromTheAppBundle() throws {
        for locale in LocaleResolver.supported {
            let strings = Strings.load(locale: locale, bundle: Bundle(for: AppModel.self))
            XCTAssertEqual(strings.localeIdentifier, locale)
            XCTAssertNotEqual(strings.navToday, "navToday", "\(locale) is missing from the bundle")
        }
    }
}
