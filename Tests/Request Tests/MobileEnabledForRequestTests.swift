import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testMobileEnabled() {
        let waitExpectation = expectation(description: "Check if mobile is enabled on vehicle")

        MobileEnabledForVehicleRequest(
            vehicleIdentifier: vehicleIdentifier(),
            accessToken: accessToken()).execute { result in
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
