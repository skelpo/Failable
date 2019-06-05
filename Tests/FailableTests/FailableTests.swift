import XCTest
@testable import Failable

final class FailableTests: XCTestCase {
    func testInit()throws {
        var story: NonFailable<String> = "Hello world...".failable()
        XCTAssertEqual(story.value, "Hello world...")
        
        story = "Long long ago...".failable()
        XCTAssertEqual(story.value, "Long long ago...")
    }
    
    func testSet()throws {
        var story: NonFailable<String> = "Hello world...".failable()
        story <~ "Long long ago..."
        
        XCTAssertEqual(story.value, "Long long ago...")
    }
    
    func testKeyPathSubscript()throws {
        let string = "Hello World"
        let failable: NonFailable<String> = string.failable()
        
        XCTAssertEqual(failable[keyPath: \.count], string.count)
    }
    
    func testEncode()throws {
        let data = Failable(["key": "value"], EmptyValidation<[String: String]>.self)
        let json = try String(data: JSONEncoder().encode(data), encoding: .utf8)
        
        XCTAssertEqual(json, "{\"key\":\"value\"}")
    }
    
    func testDecode()throws {
        let json = """
        {
            "key": "value"
        }
        """.data(using: .utf8)!
        let object = try JSONDecoder().decode(NonFailable<[String: String]>.self, from: json)
        
        XCTAssertEqual(object.value, ["key": "value"])
    }
}
