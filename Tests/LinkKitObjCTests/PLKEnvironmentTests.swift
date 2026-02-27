import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKEnvironmentTests: XCTestCase {

    func testProductionToSwift() {
        let environment = PLKEnvironment.production
        let swiftEnvironment = environment.toSwift
        XCTAssertEqual(swiftEnvironment, .production)
    }

    func testSandboxToSwift() {
        let environment = PLKEnvironment.sandbox
        let swiftEnvironment = environment.toSwift
        XCTAssertEqual(swiftEnvironment, .sandbox)
    }
}
