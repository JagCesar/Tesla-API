import XCTest
@testable import TeslaAPI

class TeslaAPITests: XCTestCase {

    private let username: String = ""
    private let password: String = ""

    internal var token: Token = ModelMocks.token

    override func setUp() {
        super.setUp()

        // This if makes sure that we never send any entered username and
        // password (which might be real credentials) to the mocked backend.
        if username.utf16.count == 0 && password.utf16.count == 0 {
            TeslaAPI.host = "private-anon-0ef8526c4f-timdorr.apiary-mock.com"
        }
    }
    
    func test_Login() {
        let waitExpectation = expectation(description: "Sign in")

        AuthenticateRequest(username: username, password: password).execute { [weak self] result in
            XCTAssert(Thread.isMainThread)
            switch result {
            case .success(let token):
                self?.token = token
                waitExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
}
