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
            TeslaAPI.sharedInstance.baseURLString = "https://private-anon-0ef8526c4f-timdorr.apiary-mock.com/"
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Login() {
        let waitExpectation = expectation(description: "Sign in")

        TeslaAPI.sharedInstance.authenticate(username: username, password: password) { result in
            switch result {
            case .Success(let response):
                TeslaAPITests.accessToken = response["access_token"] as! String
                waitExpectation.fulfill()
            case .Failure(let error):
                XCTFail()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testListVehicles() {
        let waitExpectation = expectation(description: "List vehicles")

        TeslaAPI.sharedInstance.listVehicles(accessToken: TeslaAPITests.accessToken) { result in
            switch result {
            case .Success(let response):
                waitExpectation.fulfill()
            case .Failure(let error):
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
