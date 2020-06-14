import XCTest

import farkleTests

var tests = [XCTestCaseEntry]()
tests += farkleTests.allTests()
XCTMain(tests)
