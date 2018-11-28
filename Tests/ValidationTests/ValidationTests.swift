import XCTest
@testable import Validation

internal struct EmptyValidation<T>: Validation {
    typealias Supported = T
}

final class ValidationTests: XCTestCase {
    static var allTests: [(String, (ValidationTests) -> ()throws -> ())] = []
}
