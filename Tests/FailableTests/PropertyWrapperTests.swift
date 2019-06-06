@testable import Failable
import XCTest

struct IsTrue: Validation {
    static func validate(_ value: Bool) throws {
        guard value else {
            throw ValidationError(identifier: "expectedTrue", reason: "Bool value must be `true`")
        }
    }
}

struct Test: Codable, Hashable {
    @Validated<Bool, IsTrue> var bool: Bool = nil
}

final class PropertyWrapperTests: XCTestCase {
    func testWrapper() throws {
        var test = Test()
        XCTAssertEqual(test.bool, true)

        test.bool = false
        XCTAssertNotEqual(test.bool, false)
    }
}

extension Validated {
    mutating func test(_ newValue: T) throws {
        self.value = newValue

        switch self {
        case let .error(error): throw error
        case .value: return
        }
    }
}
