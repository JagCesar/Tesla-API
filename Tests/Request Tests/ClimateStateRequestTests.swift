import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testClimateState() {
        let waitExpectation = expectation(description: "Climate state")
        ClimateStateRequest(
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
