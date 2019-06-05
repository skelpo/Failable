import XCTest
@testable import Failable

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
        var int = Failable<Int, NumberThousand>(5_000)
        
        int <~ 9_999
        int <~ 1_000
        try XCTAssertNoThrow(int.get())
        
        int <~ 999
        int <~ 10_000
        try XCTAssertThrowsError(int.get())
    }
    
    func testGreaterThan()throws {
        var int = Failable<Int, GreaterThan>(5_000)
        
        int <~ 1_000
        int <~ 10_000
        int <~ Int.max
        try XCTAssertNoThrow(int.get())
        
        int <~ 999
        int <~ 0
        int <~ Int.min
        try XCTAssertThrowsError(int.get())
    }
    
    func testLessThan()throws {
        var int = Failable<Int, LessThan>(5_000)
        
        int <~ 9_999
        int <~ 999
        int <~ 0
        int <~ Int.min
        try XCTAssertNoThrow(int.get())
        
        int <~ 10_000
        int <~ Int.max
        try XCTAssertThrowsError(int.get())
    }
}
