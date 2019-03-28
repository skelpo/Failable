import XCTest

import FailableTests

var tests = [XCTestCaseEntry]()
tests += FailableTests.__allTests()

XCTMain(tests)
