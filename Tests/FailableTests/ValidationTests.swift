import XCTest
@testable import Failable

internal struct EmptyValidation<T>: Validation {
    typealias Supported = T
}

internal struct ValidationList: Validation {
    typealias Supported = Bool
    
    static let subvalidations: [AnyValidation.Type] = [
        EmptyValidation<Bool>.self,
        EmptyValidation<String>.self,
        EmptyValidation<Int>.self,
        EmptyValidation<Bool>.self,
        EmptyValidation<Bool>.self,
        EmptyValidation<[Bool]>.self,
        EmptyValidation<[String: Any]>.self,
        EmptyValidation<Set<Float>>.self
    ]
}

final class ValidationTests: XCTestCase {
    func testType()throws {
        let validation = EmptyValidation<Bool>.self
        
        XCTAssert(validation.type == Bool.self)
        XCTAssert(validation.Supported.self == Bool.self)
    }
    
    func testDefaultImplementations()throws {
        let validation = EmptyValidation<Bool>.self
        
        XCTAssertEqual(validation.subvalidations.count, 0)
        XCTAssertEqual(validation.safeSubvalidations.count, 0)
        try XCTAssertNoThrow(validation.validate(false))
        try XCTAssertNoThrow(validation.validate(true))
        
        do {
            try validation.validate("Fail")
        } catch let error as ValidationError {
            XCTAssertEqual(error.identifier, "invalidType")
            XCTAssertEqual(error.reason, "Cannot convert Any to validation supported type")
        } catch let error {
            XCTFail("Unexpected error: " + error.localizedDescription)
        }
    }
    
    func testSafeSubvalidations()throws {
        XCTAssertEqual(ValidationList.safeSubvalidations.count, 3)
        for validation in ValidationList.safeSubvalidations {
            XCTAssert(validation.type == Bool.self)
        }
    }
}
