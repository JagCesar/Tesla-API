import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testListVehicles() {
        let waitExpectation = expectation(description: "List vehicles")

        ListVehiclesRequest(
            accessToken: accessToken()).execute { result in
            XCTAssert(Thread.isMainThread)
            switch result {
            case .success(let vehicles):
                print(vehicles)
                waitExpectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
