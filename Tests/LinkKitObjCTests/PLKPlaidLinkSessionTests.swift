import LinkKit
import UIKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKPlaidLinkSessionTests: XCTestCase {

    func testInitializationWithSession() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        XCTAssertNotNil(shim)
    }

    func testShowGradientBackgroundDefaultValue() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        XCTAssertFalse(shim.showGradientBackground)
    }

    func testShowGradientBackgroundSetsUnderlyingSession() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        XCTAssertFalse(mockSession.showGradientBackground)

        shim.showGradientBackground = true

        XCTAssertTrue(shim.showGradientBackground)
        XCTAssertTrue(mockSession.showGradientBackground)
    }

    func testShowGradientBackgroundCanBeToggledMultipleTimes() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        shim.showGradientBackground = true
        XCTAssertTrue(mockSession.showGradientBackground)

        shim.showGradientBackground = false
        XCTAssertFalse(mockSession.showGradientBackground)

        shim.showGradientBackground = true
        XCTAssertTrue(mockSession.showGradientBackground)
    }

    func testOpenDelegatesToUnderlyingSession() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        XCTAssertFalse(mockSession.openCalled)

        let presentationHandler: PLKPresentationHandler = { _ in }
        let dismissalHandler: PLKDismissalHandler = { _ in }

        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)

        XCTAssertTrue(mockSession.openCalled)
    }

    func testOpenUsesCustomPresentationMethod() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        var presentationCalled = false
        var dismissalCalled = false

        let presentationHandler: PLKPresentationHandler = { _ in
            presentationCalled = true
        }
        let dismissalHandler: PLKDismissalHandler = { _ in
            dismissalCalled = true
        }

        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)

        XCTAssertNotNil(mockSession.lastPresentationMethod)

        // Verify the presentation method is .custom
        if case .custom(let presentHandler, let dismissHandler) = mockSession.lastPresentationMethod {
            let dummyVC = UIViewController()
            presentHandler(dummyVC)
            dismissHandler(dummyVC)

            XCTAssertTrue(presentationCalled)
            XCTAssertTrue(dismissalCalled)
        } else {
            XCTFail("Expected .custom presentation method")
        }
    }

    func testOpenCanBeCalledMultipleTimes() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        let presentationHandler: PLKPresentationHandler = { _ in }
        let dismissalHandler: PLKDismissalHandler = { _ in }

        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)
        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)
        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)

        XCTAssertEqual(mockSession.openCallCount, 3)
    }

    func testConformsToObjCProtocol() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        // Verify it can be used through the protocol
        let protocolInstance: PLKPlaidLinkSession = shim

        protocolInstance.showGradientBackground = true
        XCTAssertTrue(mockSession.showGradientBackground)

        let presentationHandler: PLKPresentationHandler = { _ in }
        let dismissalHandler: PLKDismissalHandler = { _ in }
        protocolInstance.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)

        XCTAssertTrue(mockSession.openCalled)
    }

    func testCanBeUsedFromObjectiveCContext() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        // Verify the shim can be stored in an NSObject-typed variable
        let nsObject: NSObject = shim
        XCTAssertNotNil(nsObject)

        // Verify we can still call protocol methods through NSObject reference
        if let linkSession = nsObject as? PLKPlaidLinkSession {
            linkSession.showGradientBackground = true
            XCTAssertTrue(mockSession.showGradientBackground)

            let presentationHandler: PLKPresentationHandler = { _ in }
            let dismissalHandler: PLKDismissalHandler = { _ in }
            linkSession.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)

            XCTAssertTrue(mockSession.openCalled)
        } else {
            XCTFail("Shim should conform to PLKPlaidLinkSession")
        }
    }

    func testShowGradientBackgroundPropertyIsIndependent() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        // Changing the shim's property should update the session
        shim.showGradientBackground = true
        XCTAssertTrue(mockSession.showGradientBackground)

        // But changing the session directly doesn't update the shim's stored value
        mockSession.showGradientBackground = false
        XCTAssertTrue(shim.showGradientBackground)  // Shim still has its own value
    }

    func testCompleteWorkflow() {
        let mockSession = MockPlaidLinkSession()
        let shim = PLKPlaidLinkSessionShim(session: mockSession)

        // Set gradient background
        shim.showGradientBackground = true
        XCTAssertTrue(mockSession.showGradientBackground)

        // Open the session
        var presentationCalled = false
        var dismissalCalled = false

        shim.open(
            presentationHandler: { _ in presentationCalled = true },
            dismissalHandler: { _ in dismissalCalled = true }
        )

        XCTAssertTrue(mockSession.openCalled)

        // Trigger handlers
        if case .custom(let presentHandler, let dismissHandler) = mockSession.lastPresentationMethod {
            let vc = UIViewController()
            presentHandler(vc)
            dismissHandler(vc)

            XCTAssertTrue(presentationCalled)
            XCTAssertTrue(dismissalCalled)
        } else {
            XCTFail("Expected .custom presentation method")
        }
    }
}
