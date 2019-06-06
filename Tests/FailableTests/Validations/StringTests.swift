import XCTest
@testable import Failable

internal struct USPhoneNumber: RegexValidation {
    static let pattern = "1?-?\\(?[0-9]{3}\\)?-?[0-9]{3}-?[0-9]{4}"
}

fileprivate struct Number {
    @Validated<String, USPhoneNumber> var phone: String
}

final class StringTests: XCTestCase {
    func testUSPhoneNumber()throws {
        var number = Number(phone: "731-943-4316")
        _ = try number.$phone.get()
        
        try number.$phone.test("(731)-943-4316")
        try number.$phone.test("1-731-943-4316")
        try number.$phone.test("7319434316")
        
        XCTAssertThrowsError(try number.$phone.test(""))
        XCTAssertThrowsError(try number.$phone.test("943-4316"))
        XCTAssertThrowsError(try number.$phone.test("1-800-EAT-MEAT"))
        XCTAssertThrowsError(try number.$phone.test("4316-943-731"))
    }
}

