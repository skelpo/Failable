import XCTest
@testable import Failable

fileprivate struct Data: Codable {
    @AlwaysValidated<String> var string: String
}

final class ValidatedTests: XCTestCase {
    func testInit()throws {
        let story = Data(string: "Hello World...")
        _ = try story.$string.get()
    }
    
    func testSet()throws {
        var story = Data(string: "Hello World...")
        _ = try story.$string.get()
        
        try story.$string.test("Long long ago...")
        XCTAssertEqual(story.string, "Long long ago...")
    }
    
    func testEncode()throws {
        let data = Data(string: "Hello")
        let json = try String(data: JSONEncoder().encode(data), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"string\":\"Hello\"}")
    }
    
    func testDecode()throws {
        let json = """
        {
            "string": "hello"
        }
        """.data(using: .utf8)!
        let object = try JSONDecoder().decode(Data.self, from: json)
        
        XCTAssertEqual(object.string, "hello")
    }
}
