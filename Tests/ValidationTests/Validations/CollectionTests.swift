import XCTest
@testable import Validation

internal struct LengthRange10To1028<C>: LengthValidation where C: Collection {
    typealias Supported = C
    
    static var maxLength: Int { return 1028 }
    static var minLength: Int { return  10 }
}

internal struct StringLengthArray: ElementValidation {
    typealias Supported = [String]
    
    static var validator: (String)throws -> Void = { str in
        guard str.count <= 1028 else { throw ValidationError(identifier: "lengthToLong", reason: "String must have length 1028 or less") }
    }
}

final class CollectionTests: XCTestCase {
    func testLengthValidation()throws {
        try XCTAssertThrowsError(Failable<[Bool], LengthRange10To1028<[Bool]>>([]))
        
        var bools = try Failable<[Bool], LengthRange10To1028<[Bool]>>([true, true, true, false, false, false, true, true, false, false])
        XCTAssertEqual(bools.value, [true, true, true, false, false, false, true, true, false, false])
        
        try XCTAssertThrowsError(bools <~ Array(repeating: true, count: 5))
        try XCTAssertThrowsError(bools <~ Array(repeating: false, count: 5))
        try XCTAssertThrowsError(bools <~ Array(repeating: true, count: 1029))
        try XCTAssertThrowsError(bools <~ Array(repeating: false, count: 1029))
        
        let array = Array(repeating: true, count: 1028)
        try bools <~ array
        XCTAssertEqual(bools.value, array)
    }
    
    func testElementValidation()throws {
        let tooLong = String(repeating: "x", count: 1029)
        let longest = String(repeating: "g", count: 1028)
        var strings = try Failable<[String], StringLengthArray>(["G", "D", "A", "E"])
        XCTAssertEqual(strings.value, ["G", "D", "A", "E"])
        
        try XCTAssertThrowsError(strings <~ ["G", "O", "O", tooLong])
        try strings <~ ["G", "OOOO", "World", longest]
        XCTAssertEqual(strings.value, ["G", "OOOO", "World", longest])
    }
    
    static var allTests: [(String, (CollectionTests) -> ()throws -> ())] = [
        ("testLengthValidation", testLengthValidation),
        ("testElementValidation", testElementValidation)
    ]
}
