import XCTest
@testable import Failable

typealias OptionalStringLength = NotNilValidate<LengthRange10To1028<String>>

final class OptionalTests: XCTestCase {
    func testNotNil()throws {
        var optional: Failable<Bool?, NotNil<Bool>> = false
        
        optional <~ true
        optional <~ false
        try XCTAssertNoThrow(optional.get())
        
        optional <~ nil
        try XCTAssertThrowsError(optional.get())
    }
    
    func testNotNilValidate()throws {
        var optional: Failable<String?, OptionalStringLength> = "Hello World"
        
        optional <~ "Long long ago"
        optional <~ String(repeating: "x", count: 10)
        optional <~ String(repeating: "x", count: 1028)
        optional <~ nil
        try XCTAssertNoThrow(optional.get())
        
        optional <~ String(repeating: "x", count: 9)
        optional <~ String(repeating: "x", count: 1029)
        try XCTAssertThrowsError(optional.get())
    }
}


