import LinkKit
import XCTest

@testable import LinkKitObjC

class MockLayerSession: LayerSessionProtocol {

    private(set) var openCalled = false
    private(set) var openCallCount = 0
    private(set) var submitCalled = false
    private(set) var submitCallCount = 0
    private(set) var lastPresentationMethod: PresentationMethod?
    private(set) var lastSubmittedData: SubmissionData?

    func submit(data: any LinkKit.SubmissionData) {
        submitCalled = true
        submitCallCount += 1
        lastSubmittedData = data
    }

    func open(using: LinkKit.PresentationMethod) {
        openCalled = true
        openCallCount += 1
        lastPresentationMethod = using
    }
}
