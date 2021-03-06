import XCTest
@testable import Failable

typealias OptionalStringLength = NotNilValidate<LengthRange10To1028<String>>

final class OptionalTests: XCTestCase {
    func testNotNil()throws {
        var optional = try Failable<Bool?, NotNil<Bool>>.init(false)
        
        try optional <~ true
        try optional <~ false
        
        try XCTAssertThrowsError(optional <~ nil)
    }
    
    func testNotNilValidate()throws {
        var optional = try Failable<String?, OptionalStringLength>.init("Hello World")
        
        try optional <~ "Long long ago"
        try optional <~ String(repeating: "x", count: 10)
        try optional <~ String(repeating: "x", count: 1028)
        try optional <~ nil
        
        try XCTAssertThrowsError(optional <~ String(repeating: "x", count: 9))
        try XCTAssertThrowsError(optional <~ String(repeating: "x", count: 1029))
    }
}


