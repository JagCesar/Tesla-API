import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testOpenChargePort() {
        let waitExpectation = expectation(description: "Open charge port")

        OpenChargePortRequest(
            accessToken: accessToken(),
            vehicleIdentifier: vehicleIdentifier()).execute { result in
                XCTAssert(Thread.isMainThread)
                switch result {
                case .success(let result):
                    print(result)
                    waitExpectation.fulfill()
                case .failure(let error):
                    print(error)
                    XCTFail()
                }
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}
