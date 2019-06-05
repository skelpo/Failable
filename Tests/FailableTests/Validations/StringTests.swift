import XCTest
@testable import Failable

internal struct USPhoneNumber: RegexValidation {
    static let pattern = "1?-?\\(?[0-9]{3}\\)?-?[0-9]{3}-?[0-9]{4}"
}

final class StringTests: XCTestCase {
    func testUSPhoneNumber()throws {
        var number: Failable<String, USPhoneNumber> = "731-943-4316".failable()
        
        number <~ "(731)-943-4316"
        number <~ "1-731-943-4316"
        number <~ "7319434316"
        try XCTAssertNoThrow(number.get())
        
        number <~ ""
        number <~ "943-4316"
        number <~ "1-800-EAT-MEAT"
        number <~ "4316-943-731"
        try XCTAssertThrowsError(number.get())
    }
}

