import XCTest
import Fluent
import Validation

@testable import FluentValidators

class ExistsTests: XCTestCase {
    static var allTests = [
        ("testBasic", testBasic),
        ("testBasicFailed", testBasicFailed)
    ]

    override func setUp() {
        MockUser.database = Database(MockDriver())
    }
    
    func testBasic() {
        let validator = Exists<MockUser>(column: "username")
        
        do {
            try validator.validate("Jimmy3131")
        } catch {
            XCTFail("Validator failed: \(error)")
        }
    }
    
    func testBasicFailed() {
        let validator = Exists<MockUser>(column: "username")
        
        do {
            try validator.validate("IDontExist33")
            XCTFail("Expected validator to fail")
        } catch ValidatorError.failure {
            // success
        } catch {
            XCTFail("Validator failed: \(error)")
        }
    }
}
