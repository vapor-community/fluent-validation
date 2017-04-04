import XCTest
import Validation
import Fluent

@testable import FluentValidators

class UniqueFieldTests: XCTestCase {
    override func setUp() {
        MockUser.database = Database(MockDriver())
    }
    
    func testBasic() {
        let validator = UniqueField<MockUser>(column: "email")
        
        do {
            try validator.validate(["unique_email@test.com"])
        } catch {
            XCTFail("Validator failed: \(error)")
        }
    }
    
    func testBasicFailed() {
        let validator = UniqueField<MockUser>(column: "email")
        
        do {
            try validator.validate(["jim@test.com"])
            XCTFail("Expected validator to fail")
        } catch ValidatorError.failure {
            // success
        } catch {
            XCTFail("Validator failed: \(error)")
        }
    }
    
    func testColumnAndInputsCountMismatch() {
        let validator = UniqueField<MockUser>(column: "email")
        
        do {
            try validator.validate(["jim@test.com", "Jim"])
            XCTFail("Expected validator to fail")
        } catch ValidatorError.failure {
            // success
        } catch {
            XCTFail("Validator failed: \(error)")
        }
    }
    
    func testMultipleColumns() {
        let validator = UniqueField<MockUser>(columns: ["email", "username"])
        
        do {
            try validator.validate(["unique_email@test.com", "unique_username"])
        } catch {
            XCTFail("Validator failed: \(error)")
        }
    }
    
    func testMultipleColumnsFailed() {
        let validator = UniqueField<MockUser>(columns: ["email", "username"])
        
        do {
            try validator.validate(["jim@test.com", "Jimmy3131"])
            XCTFail("Expected validator to fail")
        } catch ValidatorError.failure {
            // success
        } catch {
            XCTFail("Validator failed: \(error)")
        }
    }
    
    func testOneColumnFailsBoth() {
        let validator = UniqueField<MockUser>(columns: ["email", "username"])
        
        do {
            try validator.validate(["a_unique_email@test.com", "Jimmy3131"])
            XCTFail("Expected validator to fail")
        } catch ValidatorError.failure {
            // success
        } catch {
            XCTFail("Validator failed: \(error)")
        }
    }
}

