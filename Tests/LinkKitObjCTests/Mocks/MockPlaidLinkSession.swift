import LinkKit
import XCTest

@testable import LinkKitObjC

class MockPlaidLinkSession: LinkSessionProtocol {
    private(set) var openCalled = false
    private(set) var openCallCount = 0
    private(set) var lastPresentationMethod: PresentationMethod?

    var showGradientBackground: Bool = false

    func open(using method: PresentationMethod) {
        openCalled = true
        openCallCount += 1
        lastPresentationMethod = method
    }
}
