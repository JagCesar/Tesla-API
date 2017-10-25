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

    override func setUp() {
        super.setUp()

        // This if makes sure that we never send any entered username and
        // password (which might be real credentials) to the mocked backend.
        if username.utf16.count == 0 && password.utf16.count == 0 {
            // Set the url to the mocked api available on this URL http://docs.timdorr.apiary.io
            TeslaAPI.host = "private-anon-99837c6056-timdorr.apiary-mock.com"
        }
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
