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

fileprivate struct Numbers {
    @Validated<Int, NumberThousand> var thousands: Int
    @Validated<Int, GreaterThan> var large: Int
    @Validated<Int, LessThan> var small: Int
}

final class ComparableTests: XCTestCase {
    func testNumberThousand()throws {
        var numbers = Numbers(thousands: 5_000, large: 0, small: 0)
        _ = try numbers.$thousands.get()

        try numbers.$thousands.test(9_999)
        try numbers.$thousands.test(1_000)
        
        try XCTAssertThrowsError(numbers.$thousands.test(999))
        try XCTAssertThrowsError(numbers.$thousands.test(10_000))
    }
    
    func testGreaterThan()throws {
        var numbers = Numbers(thousands: 0, large: 5_000, small: 0)
        
        try numbers.$large.test(1_000)
        try numbers.$large.test(10_000)
        try numbers.$large.test(Int.max)
        
        try XCTAssertThrowsError(numbers.$large.test(999))
        try XCTAssertThrowsError(numbers.$large.test(0))
        try XCTAssertThrowsError(numbers.$large.test(Int.min))
    }
    
    func testLessThan()throws {
        var numbers = Numbers(thousands: 0, large: 0, small: 5_000)
        _ = try numbers.$small.get()
        
        try numbers.$small.test(9_999)
        try numbers.$small.test(999)
        try numbers.$small.test(0)
        try numbers.$small.test(Int.min)
        
        try XCTAssertThrowsError(numbers.$small.test(10_000))
        try XCTAssertThrowsError(numbers.$small.test(Int.max))
    }
}
