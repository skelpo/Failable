import XCTest
@testable import Validation

final class FailableTests: XCTestCase {
    func testInit()throws {
        var story: Failable<String, USPhoneNumber> = try "Hello world...".failable()
        XCTAssertEqual(story.value, "Hello world...")
        
        story = try "Long long ago...".failable()
        XCTAssertEqual(story.value, "Long long ago...")
    }
    
    func testSet()throws {
        var story: Failable<String, USPhoneNumber> = try "Hello world...".failable()
        try story <~ "Long long ago..."
        
        XCTAssertEqual(story.value, "Long long ago...")
    }
    
    func testKeyPathSubscript()throws {
        let string = "Hello World"
        let failable: Failable<String, EmptyValidation<String>> = try string.failable()
        
        XCTAssertEqual(failable[keyPath: \.count], string.count)
    }
    
    func testEncode()throws {
        let data: Failable<[String: String], EmptyValidation<[String: String]>> = try ["key": "value"].failable()
        let json = try String(data: JSONEncoder().encode(data), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"key\":\"value\"}")
    }
    
    func testDecode()throws {
        let json = """
        {
            "key": "value"
        }
        """.data(using: .utf8)!
        let object = try JSONDecoder().decode(Failable<[String: String], EmptyValidation<[String: String]>>.self, from: json)
        
        XCTAssertEqual(object.value, ["key": "value"])
    }
    
    static var allTests: [(String, (FailableTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testSet", testSet),
        ("testKeyPathSubscript", testKeyPathSubscript),
        ("testEncode", testEncode),
        ("testDecode", testDecode)
    ]
}
