#if canImport(UIKit)
    import XCTest

    @testable import Threads

    final class ThreadsTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            let image = Icon.activity.image

            XCTAssertNotNil(image)
        }

        static var allTests = [
            ("testExample", testExample)
        ]
    }
#endif  // canImport(UIKit)
