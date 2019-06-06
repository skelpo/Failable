import XCTest
@testable import Failable

internal struct LengthRange10To1028<C>: LengthValidation where C: Collection {
    typealias Supported = C
    
    static var maxLength: Int { return 1028 }
    static var minLength: Int { return  10 }
}

internal struct Length1028<C>: LengthValidation where C: Collection {
    typealias Supported = C
    
    static var maxLength: Int { return 1028 }
}

fileprivate struct Lists {
    @Validated<[Bool], LengthRange10To1028<[Bool]>> var bools: [Bool]
    @Validated<[String], ElementValidation<[String], Length1028<String>>> var strings: [String]
}

final class CollectionTests: XCTestCase {
    func testLengthValidation()throws {
        var lists = Lists(bools: [], strings: [])
        _ = try lists.$bools.get()

        try lists.$bools.test([true, true, true, false, false, false, true, true, false, false])
        try lists.$bools.test(Array(repeating: true, count: 1028))
        
        try XCTAssertThrowsError(lists.$bools.test(Array(repeating: true, count: 5)))
        try XCTAssertThrowsError(lists.$bools.test(Array(repeating: false, count: 5)))
        try XCTAssertThrowsError(lists.$bools.test(Array(repeating: true, count: 1029)))
        try XCTAssertThrowsError(lists.$bools.test(Array(repeating: false, count: 1029)))
    }
    
    func testElementValidation()throws {
        var lists = Lists(bools: [], strings: ["G", "D", "A", "E"])
        _ = try lists.$strings.get()

        let longest = String(repeating: "g", count: 1028)
        try lists.$strings.test(["G", "OOOO", "World", longest])

        let tooLong = String(repeating: "x", count: 1029)
        try lists.$strings.test(["G", "O", "O", tooLong])
    }
}
