import XCTest
@testable import TeslaAPI

class TeslaAPITests: XCTestCase {
    func test_Login() {
        let waitExpectation = expectation(description: "Sign in")

        AuthenticateRequest(username: username(), password: password()).execute { result in
            XCTAssert(Thread.isMainThread)
            switch result {
            case .success:
                waitExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
