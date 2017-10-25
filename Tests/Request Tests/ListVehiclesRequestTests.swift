import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testListVehicles() {
        let waitExpectation = expectation(description: "List vehicles")

        ListVehiclesRequest(
            accessToken: TeslaAPITests.accessToken).execute { result in
            XCTAssert(Thread.isMainThread)
            switch result {
            case .success(let vehicles):
                waitExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
