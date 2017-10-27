import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testChargeState() {
        let waitExpectation = expectation(description: "Charge state")
        ChargeStateRequest(
            accessToken: accessToken(),
            vehicleIdentifier: vehicleIdentifier()).execute { result in
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
