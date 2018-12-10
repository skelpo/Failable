import XCTest
@testable import Validation

internal struct NumberThousand: InRangeValidation {
    typealias Supported = Int
    
    static let max: Int? = 9_999
    static let min: Int? = 1_000
}

internal struct GreaterThan: InRangeValidation {
    typealias Supported = Int
    
    static let min: Int? = 1_000
}

internal struct LessThan: InRangeValidation {
    typealias Supported = Int
    
    static let max: Int? = 9_999
}

final class ComparableTests: XCTestCase {
    func testNumberThousand()throws {
        var int = try Failable<Int, NumberThousand>(5_000)
        
        try int <~ 9_999
        try int <~ 1_000
        
        try XCTAssertThrowsError(int <~ 999)
        try XCTAssertThrowsError(int <~ 10_000)
    }
    
    func testGreaterThan()throws {
        var int = try Failable<Int, GreaterThan>(5_000)
        
        try int <~ 1_000
        try int <~ 10_000
        try int <~ Int.max
        
        try XCTAssertThrowsError(int <~ 999)
        try XCTAssertThrowsError(int <~ 0)
        try XCTAssertThrowsError(int <~ Int.min)
    }
    
    func testLessThan()throws {
        var int = try Failable<Int, LessThan>(5_000)
        
        try int <~ 9_999
        try int <~ 999
        try int <~ 0
        try int <~ Int.min
        
        try XCTAssertThrowsError(int <~ 10_000)
        try XCTAssertThrowsError(int <~ Int.max)
    }
    
    static var allTests: [(String, (ComparableTests) -> ()throws -> ())] = [
        ("testNumberThousand", testNumberThousand),
        ("testGreaterThan", testGreaterThan),
        ("testLessThan", testLessThan)
    ]
}
