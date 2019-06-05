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
internal typealias StringLengthArray = ElementValidation<[String], Length1028<String>>

final class CollectionTests: XCTestCase {
    func testLengthValidation()throws {
        try XCTAssertThrowsError(Failable([], LengthRange10To1028<[Bool]>.self).get())
        
        var bools = Failable([true, true, true, false, false, false, true, true, false, false], LengthRange10To1028<[Bool]>.self)
        XCTAssertEqual(bools.value, [true, true, true, false, false, false, true, true, false, false])
        
        bools <~ Array(repeating: true, count: 5)
        bools <~ Array(repeating: false, count: 5)
        bools <~ Array(repeating: true, count: 1029)
        bools <~ Array(repeating: false, count: 1029)
        try XCTAssertThrowsError(bools.get())
        
        let array = Array(repeating: true, count: 1028)
        bools <~ array
        XCTAssertEqual(bools.value, array)
    }
    
    func testElementValidation()throws {
        let tooLong = String(repeating: "x", count: 1029)
        let longest = String(repeating: "g", count: 1028)
        var strings = Failable<[String], StringLengthArray>(["G", "D", "A", "E"])
        XCTAssertEqual(strings.value, ["G", "D", "A", "E"])
        
        strings <~ ["G", "O", "O", tooLong]
        try XCTAssertThrowsError(strings.get())

        strings <~ ["G", "OOOO", "World", longest]
        XCTAssertEqual(strings.value, ["G", "OOOO", "World", longest])
    }
}
