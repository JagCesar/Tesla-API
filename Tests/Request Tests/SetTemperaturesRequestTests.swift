import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testSetTemperatures() {
        let waitExpectation = expectation(description: "Set temperatures")

        SetTemperaturesRequest(
            accessToken: accessToken(),
            vehicleIdentifier: vehicleIdentifier(),
            driverTemp: 21,
            passengerTemp: 21).execute { result in
                XCTAssert(Thread.isMainThread)
                switch result {
                case .success(let result):
                    if result == true {
                        waitExpectation.fulfill()
                    } else {
                        XCTFail()
                    }
                case .failure(_):
                    XCTFail()
                }
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}
