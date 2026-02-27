import LinkKit
import UIKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKPlaidLayerSessionTests: XCTestCase {

    // MARK: - Initialization Tests

    func testInitializationWithPlaidLayerSession() throws {
        let config = LayerTokenConfiguration(
            token: "link-sandbox-123",
            onSuccess: { _ in },
            onExit: nil,
            onEvent: nil
        )

        let session = try Plaid.createPlaidLayerSession(configuration: config)
        let shim = PLKPlaidLayerSessionShim(session: session)
        XCTAssertNotNil(shim)
    }

    // MARK: - Submit Tests

    func testSubmitWithPhoneNumber() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        let submissionData = PLKSubmissionData()
        submissionData.phoneNumber = "555-1234"
        submissionData.dateOfBirth = "1990-01-01"

        shim.submit(submissionData)

        XCTAssertTrue(mockSession.submitCalled)
        XCTAssertEqual(mockSession.lastSubmittedData?.phoneNumber, "555-1234")
        XCTAssertEqual(mockSession.lastSubmittedData?.dateOfBirth, "1990-01-01")
    }

    func testSubmitWithNilPhoneNumber() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        let submissionData = PLKSubmissionData()
        submissionData.phoneNumber = nil

        shim.submit(submissionData)

        XCTAssertTrue(mockSession.submitCalled)
        XCTAssertNil(mockSession.lastSubmittedData?.phoneNumber)
    }

    func testSubmitWithDateOfBirth() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        let submissionData = PLKSubmissionData()
        submissionData.phoneNumber = "555-9999"
        submissionData.dateOfBirth = "1985-12-25"

        shim.submit(submissionData)

        XCTAssertTrue(mockSession.submitCalled)
        XCTAssertEqual(mockSession.lastSubmittedData?.dateOfBirth, "1985-12-25")
    }

    func testSubmitWithNilDateOfBirth() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        let submissionData = PLKSubmissionData()
        submissionData.phoneNumber = "555-0000"
        submissionData.dateOfBirth = nil

        shim.submit(submissionData)

        XCTAssertTrue(mockSession.submitCalled)
        XCTAssertNil(mockSession.lastSubmittedData?.dateOfBirth)
    }

    func testSubmitMultipleTimes() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        let submissionData1 = PLKSubmissionData()
        submissionData1.phoneNumber = "555-1111"
        shim.submit(submissionData1)

        let submissionData2 = PLKSubmissionData()
        submissionData2.phoneNumber = "555-2222"
        shim.submit(submissionData2)

        XCTAssertEqual(mockSession.submitCallCount, 2)
        XCTAssertEqual(mockSession.lastSubmittedData?.phoneNumber, "555-2222")
    }

    // MARK: - Open Tests

    func testOpenWithCustomPresentationMethod() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        var presentationHandlerCalled = false
        var dismissalHandlerCalled = false

        let presentationHandler: PLKPresentationHandler = { _ in
            presentationHandlerCalled = true
        }

        let dismissalHandler: PLKDismissalHandler = { _ in
            dismissalHandlerCalled = true
        }

        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)

        XCTAssertTrue(mockSession.openCalled)
        XCTAssertNotNil(mockSession.lastPresentationMethod)

        // Verify the presentation method is .custom
        if case .custom(let presentHandler, let dismissHandler) = mockSession.lastPresentationMethod {
            let dummyVC = UIViewController()
            presentHandler(dummyVC)
            dismissHandler(dummyVC)

            XCTAssertTrue(presentationHandlerCalled)
            XCTAssertTrue(dismissalHandlerCalled)
        } else {
            XCTFail("Expected .custom presentation method")
        }
    }

    func testOpenCallsSessionOpen() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        let presentationHandler: PLKPresentationHandler = { _ in }
        let dismissalHandler: PLKDismissalHandler = { _ in }

        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)

        XCTAssertTrue(mockSession.openCalled)
        XCTAssertEqual(mockSession.openCallCount, 1)
    }

    func testOpenMultipleTimes() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        let presentationHandler: PLKPresentationHandler = { _ in }
        let dismissalHandler: PLKDismissalHandler = { _ in }

        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)
        shim.open(presentationHandler: presentationHandler, dismissalHandler: dismissalHandler)

        XCTAssertEqual(mockSession.openCallCount, 2)
    }

    // MARK: - SwiftPLKSubmissionData Tests

    func testSwiftPLKSubmissionDataConvertsPhoneNumber() {
        let objcData = PLKSubmissionData()
        objcData.phoneNumber = "555-TEST"
        let swiftData = PLKPlaidLayerSessionShim.SwiftPLKSubmissionData(data: objcData)

        XCTAssertEqual(swiftData.phoneNumber, "555-TEST")
    }

    func testSwiftPLKSubmissionDataConvertsDateOfBirth() {
        let objcData = PLKSubmissionData()
        objcData.dateOfBirth = "2000-06-15"
        objcData.phoneNumber = "555-1234"

        let swiftData = PLKPlaidLayerSessionShim.SwiftPLKSubmissionData(data: objcData)

        XCTAssertEqual(swiftData.dateOfBirth, "2000-06-15")
    }

    func testSwiftPLKSubmissionDataHandlesNilValues() {
        let objcData = PLKSubmissionData()
        objcData.dateOfBirth = nil

        let swiftData = PLKPlaidLayerSessionShim.SwiftPLKSubmissionData(data: objcData)

        XCTAssertNil(swiftData.phoneNumber)
        XCTAssertNil(swiftData.dateOfBirth)
    }

    func testSwiftPLKSubmissionDataParamsIsNil() {
        let objcData = PLKSubmissionData()
        objcData.phoneNumber = "555-0000"
        let swiftData = PLKPlaidLayerSessionShim.SwiftPLKSubmissionData(data: objcData)

        XCTAssertNil(swiftData.params)
    }

    // MARK: - Integration Tests

    func testCompleteWorkflow() {
        let mockSession = MockLayerSession()
        let shim = PLKPlaidLayerSessionShim(session: mockSession)

        var presentationCalled = false
        var dismissalCalled = false

        // Open the session
        shim.open(
            presentationHandler: { _ in presentationCalled = true },
            dismissalHandler: { _ in dismissalCalled = true }
        )

        XCTAssertTrue(mockSession.openCalled)

        // Submit data
        let submissionData = PLKSubmissionData()
        submissionData.phoneNumber = "555-FULL"
        submissionData.dateOfBirth = "1995-03-20"
        shim.submit(submissionData)

        XCTAssertTrue(mockSession.submitCalled)
        XCTAssertEqual(mockSession.lastSubmittedData?.phoneNumber, "555-FULL")
        XCTAssertEqual(mockSession.lastSubmittedData?.dateOfBirth, "1995-03-20")

        // Trigger handlers
        if case .custom(let presentHandler, let dismissHandler) = mockSession.lastPresentationMethod {
            let vc = UIViewController()
            presentHandler(vc)
            dismissHandler(vc)

            XCTAssertTrue(presentationCalled)
            XCTAssertTrue(dismissalCalled)
        }
    }
}
