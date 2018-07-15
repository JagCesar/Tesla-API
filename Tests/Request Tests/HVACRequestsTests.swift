import XCTest
@testable import TeslaAPI

extension TeslaAPITests {
    func testEnableHvac() {
        let waitExpectation = expectation(description: "Enable HVAC")

        HVACRequest(
            accessToken: accessToken(),
            vehicleIdentifier: vehicleIdentifier(),
            state: .on).execute { result in
                XCTAssert(Thread.isMainThread)
                switch result {
                case .success(let result):
                    if result {
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

    func testDisableHvac() {
        let waitExpectation = expectation(description: "Disable HVAC")

        HVACRequest(
            accessToken: accessToken(),
            vehicleIdentifier: vehicleIdentifier(),
            state: .off).execute { result in
                XCTAssert(Thread.isMainThread)
                switch result {
                case .success(let result):
                    if result {
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
