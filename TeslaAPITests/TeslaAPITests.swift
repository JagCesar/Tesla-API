import XCTest
import TeslaAPI

class TeslaAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin() {
        let signInExpectation = expectation(description: "Sign in")

        TeslaAPI.sharedInstance.authenticate(username: "username", password: "password") { success, tokenDictionary in
            if success {
                signInExpectation.fulfill()
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
