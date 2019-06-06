import XCTest
@testable import Failable

typealias OptionalStringLength = NotNilValidate<LengthRange10To1028<String>>

fileprivate struct Optionals {
    @Validated<Bool?, NotNil<Bool>> var bool: Bool
    @Validated<String?, OptionalStringLength> var string: String
}

final class OptionalTests: XCTestCase {
    func testNotNil()throws {
        var optionals = Optionals(bool: false, string: "")
        _ = try optionals.$bool.get()

        try optionals.$bool.test(true)
        try optionals.$bool.test(false)
        
        try XCTAssertThrowsError(optionals.$bool.test(nil))
    }
    
    func testNotNilValidate()throws {
        var optionals = Optionals(bool: true, string: "Hello World")
        
        try optionals.$string.test("Long long ago")
        try optionals.$string.test(String(repeating: "x", count: 10))
        try optionals.$string.test(String(repeating: "x", count: 1028))
        try optionals.$string.test(nil)
        
        try XCTAssertThrowsError(optionals.$string.test(String(repeating: "x", count: 9)))
        try XCTAssertThrowsError(optionals.$string.test(String(repeating: "x", count: 1029)))
    }
}


