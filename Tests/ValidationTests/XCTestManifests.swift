import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ValidationTests.allTests),
        testCase(FailableTests.allTests),
        testCase(ValidationErrorTests.allTests)
    ]
}
#endif
