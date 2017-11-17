import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testVehicleState() {
        let waitExpectation = expectation(description: "Vehicle state")
        VehicleStateRequest(
            accessToken: accessToken(),
            vehicleIdentifier: vehicleIdentifier())
            .execute { result in
                switch result {
                case .failure(let error):
                    print(error)
                    XCTFail()
                case .success(let vehicleState):
                    print(vehicleState)
                    waitExpectation.fulfill()
                }
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}
