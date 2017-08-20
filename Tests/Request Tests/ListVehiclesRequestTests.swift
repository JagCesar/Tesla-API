import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testListVehicles() {
        let waitExpectation = expectation(description: "List vehicles")

        ListVehiclesRequest(accessToken: token.accessToken).execute { result in
            XCTAssert(Thread.isMainThread)
            switch result {
            case .success(_):
                waitExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
