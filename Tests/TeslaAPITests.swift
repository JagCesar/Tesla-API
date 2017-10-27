import XCTest
@testable import TeslaAPI

class TeslaAPITests: XCTestCase {

    private let username: String = ""
    private let password: String = ""

    static var token: Token = ModelMocks.token
    static var accessToken: String {
        return token.accessToken
    }
    static var vehicleIdentifier: Int {
        return 1
    }
    
    func test_Login() {
        let waitExpectation = expectation(description: "Sign in")

        AuthenticateRequest(username: username, password: password).execute { result in
            XCTAssert(Thread.isMainThread)
            switch result {
            case .success(let token):
                TeslaAPITests.token = token
                waitExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
