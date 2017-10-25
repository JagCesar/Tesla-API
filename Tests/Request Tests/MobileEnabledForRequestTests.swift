import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testMobileEnabled() {
        let waitExpectation = expectation(description: "Check if mobile is enabled on vehicle")

        MobileEnabledForVehicleRequest(
            vehicle: ModelMocks.vehicle,
            accessToken: TeslaAPITests.accessToken).execute { result in
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
