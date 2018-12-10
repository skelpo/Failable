import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ValidationTests.allTests),
        testCase(FailableTests.allTests),
        testCase(ValidationErrorTests.allTests),
        testCase(CollectionTests.allTests),
        testCase(ComparableTests.allTests),
        testCase(StringTests.allTests),
        testCase(OptionalTests.allTests)
    ]
}
#endif
