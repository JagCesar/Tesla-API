import XCTest
import TeslaAPI

class TeslaAPITests: XCTestCase {

    private let username: String = ""
    private let password: String = ""

    private static var accessToken: String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Login() {
        let waitExpectation = expectation(description: "Sign in")

        TeslaAPI.sharedInstance.authenticate(username: username, password: password) { success, response in
            if success {
                TeslaAPITests.accessToken = response!["access_token"] as! String
                waitExpectation.fulfill()
            } else {
                XCTFail()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testListVehicles() {
        let waitExpectation = expectation(description: "Sign in")

        TeslaAPI.sharedInstance.listVehicles(accessToken: TeslaAPITests.accessToken) { success, response in
            if success {
                waitExpectation.fulfill()
            } else {
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
