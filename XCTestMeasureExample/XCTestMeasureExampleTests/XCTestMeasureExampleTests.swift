//
//  XCTestMeasureExampleTests.swift
//  XCTestMeasureExampleTests
//
//  Created by 유정주 on 2023/08/01.
//

import XCTest

final class XCTestMeasureExampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func test_time_1() throws {
        var count = 0
        measure {
            excuteRemoveFirst()
        }
    }
    
    func test_clock() throws {
        measure(metrics: [XCTClockMetric()]) {
            excuteRemoveFirst()
        }
    }
    
    func test_time_2() throws {
        let option = XCTMeasureOptions()
        option.iterationCount = 20
        
        measure(options: option) {
            excuteRemoveLast()
        }
    }
    
    func test_memory() throws {
        measure(metrics: [XCTMemoryMetric()]) {
            excuteRemoveFirst()
        }
    }
    
    func test_cpu() throws {
        measure(metrics: [XCTCPUMetric()]) {
            excuteRemoveFirst()
        }
    }
    
    func test_storage() throws {
        measure(metrics: [XCTStorageMetric()]) {
            excuteRemoveFirst()
        }
    }
    
    func test_all() throws {
        measure(metrics: [
            XCTClockMetric(),
            XCTCPUMetric(),
            XCTStorageMetric(),
            XCTMemoryMetric()
        ]) {
            excuteRemoveFirst()
        }
    }
}
