import XCTest
@testable import TeslaAPI

class TeslaAPITests: XCTestCase {

    private let username: String = ""
    private let password: String = ""

    private static var accessToken: String!
    
    override func setUp() {
        super.setUp()

        // This if makes sure that we never send any entered username and
        // password (which might be real credentials) to the mocked backend.
        if username.utf16.count == 0 && password.utf16.count == 0 {
            TeslaAPI.baseURLString = "https://private-anon-0ef8526c4f-timdorr.apiary-mock.com/"
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Login() {
        let waitExpectation = expectation(description: "Sign in")

        AuthenticateRequest(username: username, password: password).execute { result in
            XCTAssert(Thread.isMainThread)
            switch result {
            case .success(let token):
                TeslaAPITests.accessToken = token.accessToken
                waitExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testListVehicles() {
        let waitExpectation = expectation(description: "List vehicles")

        ListVehiclesRequest(accessToken: TeslaAPITests.accessToken).execute { result in
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
