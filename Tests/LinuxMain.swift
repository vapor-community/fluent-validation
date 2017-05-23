import XCTest
@testable import FluentValidatorsTests

XCTMain([
    testCase(ExistsTests.allTests),
    testCase(UniqueFieldTests.allTests),
])
