import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKPlaidHeadlessSessionTests: XCTestCase {

    func testInitializationWithSession() {
        let mockSession = MockPlaidHeadlessSession()
        let shim = PLKPlaidHeadlessSessionShim(session: mockSession)

        XCTAssertNotNil(shim)
    }

    func testStartDelegatesToUnderlyingSession() {
        let mockSession = MockPlaidHeadlessSession()
        let shim = PLKPlaidHeadlessSessionShim(session: mockSession)

        XCTAssertFalse(mockSession.startCalled)

        shim.start()

        XCTAssertTrue(mockSession.startCalled)
    }

    func testStartCanBeCalledMultipleTimes() {
        let mockSession = MockPlaidHeadlessSession()
        let shim = PLKPlaidHeadlessSessionShim(session: mockSession)

        shim.start()
        shim.start()
        shim.start()

        XCTAssertEqual(mockSession.startCallCount, 3)
    }

    func testConformsToObjCProtocol() {
        let mockSession = MockPlaidHeadlessSession()
        let shim = PLKPlaidHeadlessSessionShim(session: mockSession)

        // Verify it can be used through the protocol
        let protocolInstance: PLKPlaidHeadlessSession = shim
        protocolInstance.start()

        XCTAssertTrue(mockSession.startCalled)
    }

    func testCanBeUsedFromObjectiveCContext() {
        let mockSession = MockPlaidHeadlessSession()
        let shim = PLKPlaidHeadlessSessionShim(session: mockSession)

        // Verify the shim can be stored in an NSObject-typed variable
        let nsObject: NSObject = shim
        XCTAssertNotNil(nsObject)

        // Verify we can still call protocol methods through NSObject reference
        if let headlessSession = nsObject as? PLKPlaidHeadlessSession {
            headlessSession.start()
            XCTAssertTrue(mockSession.startCalled)
        } else {
            XCTFail("Shim should conform to PLKPlaidHeadlessSession")
        }
    }
}

// MARK: - Mock

private class MockPlaidHeadlessSession: PlaidHeadlessSession {
    var startCalled = false
    var startCallCount = 0

    func start() {
        startCalled = true
        startCallCount += 1
    }
}
