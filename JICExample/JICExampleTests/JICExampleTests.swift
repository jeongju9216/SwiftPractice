//
//  JICExampleTests.swift
//  JICExampleTests
//
//  Created by 유정주 on 2023/08/21.
//

import XCTest
import Jeongfisher
import Kingfisher

final class JICExampleTests: XCTestCase {

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

    func testPerformance_setDownsamplingImage() throws {
        // This is an example of a performance test case.
        let option = XCTMeasureOptions()
        option.iterationCount = 100

        measure(metrics: [XCTClockMetric(), XCTMemoryMetric(), XCTCPUMetric()],
                options: option) {
            let imageView = UIImageView()
            let url = URL(string: "https://picsum.photos/1000")!
            
            imageView.jf.setImage(with: url)
        }
    }

    func testPerformance_setOriginalImage() throws {
        // This is an example of a performance test case.
        let option = XCTMeasureOptions()
        option.iterationCount = 100

        measure(metrics: [XCTClockMetric(), XCTMemoryMetric(), XCTCPUMetric()],
                options: option) {
            let imageView = UIImageView()
            let url = URL(string: "https://picsum.photos/1000")!
            
            imageView.jf.setOriginalImage(with: url)
        }
    }
    
    func testPerformance_kingfisher() throws {
        // This is an example of a performance test case.
        let option = XCTMeasureOptions()
        option.iterationCount = 100

        measure(metrics: [XCTClockMetric(), XCTMemoryMetric(), XCTCPUMetric()],
                options: option) {
            let imageView = UIImageView()
            let url = URL(string: "https://picsum.photos/1000")!
            
            imageView.kf.setImage(with: url)
        }
    }
}
