import XCTest
@testable import Validation

final class ValidationErrorTests: XCTestCase {
    func testInit()throws {
        let error = ValidationError(identifier: "id", reason: "I gotta reason")
        
        XCTAssertEqual(error.identifier, "id")
        XCTAssertEqual(error.reason, "I gotta reason")
    }
    
    func testEncode()throws {
        let error = ValidationError(identifier: "id", reason: "I gotta reason")
        let json = try String(data: JSONEncoder().encode(error), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"reason\":\"I gotta reason\",\"identifier\":\"id\"}")
    }
    
    func testDecode()throws {
        let json = """
        {
            "identifier": "id",
            "reason": "I gotta reason"
        }
        """.data(using: .utf8)!
        let error = try JSONDecoder().decode(ValidationError.self, from: json)
        
        XCTAssertEqual(error.identifier, "id")
        XCTAssertEqual(error.reason, "I gotta reason")
    }
    
    static var allTests: [(String, (ValidationErrorTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testEncode", testEncode),
        ("testDecode", testDecode)
    ]
}

