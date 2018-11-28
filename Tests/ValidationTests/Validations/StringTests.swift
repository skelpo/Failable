import XCTest
@testable import Validation

internal struct USPhoneNumber: RegexValidation {
    typealias Supported = String
    
    static let pattern = "1?-?\\(?[0-9]{3}\\)?-?[0-9]{3}-?[0-9]{4}"
}

final class StringTests: XCTestCase {
    func testUSPhoneNumber()throws {
        var number = try Failable<String, USPhoneNumber>("731-943-4316")
        
        try number <~ "(731)-943-4316"
        try number <~ "1-731-943-4316"
        try number <~ "7319434316"
        
        try XCTAssertThrowsError(number <~ "")
        try XCTAssertThrowsError(number <~ "943-4316")
        try XCTAssertThrowsError(number <~ "1-800-EAT-MEAT")
        try XCTAssertThrowsError(number <~ "4316-943-731")
    }
    
    static var allTests: [(String, (StringTests) -> ()throws -> ())] = [
        ("testUSPhoneNumber", testUSPhoneNumber)
    ]
}

