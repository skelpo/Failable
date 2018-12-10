import XCTest
@testable import Validation

typealias OptionalStringLength = NotNilValidate<LengthRange10To1028<String>>

final class OptionalTests: XCTestCase {
    func testNotNil()throws {
        var optional = try Failable<Bool?, NotNil<Bool>>(false)
        
        try optional <~ true
        try optional <~ false
        
        try XCTAssertThrowsError(optional <~ nil)
    }
    
    func testNotNilValidate()throws {
        var optional = try Failable<String?, OptionalStringLength>("Hello World")
        
        try optional <~ "Long long ago"
        try optional <~ String(repeating: "x", count: 10)
        try optional <~ String(repeating: "x", count: 1028)
        try optional <~ nil
        
        try XCTAssertThrowsError(optional <~ String(repeating: "x", count: 9))
        try XCTAssertThrowsError(optional <~ String(repeating: "x", count: 1029))
    }
    
    static var allTests: [(String, (OptionalTests) -> ()throws -> ())] = [
        ("testNotNil", testNotNil),
        ("testNotNilValidate", testNotNilValidate)
    ]
}


