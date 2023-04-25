//
//  ExampleUnitTestTests.swift
//  ExampleUnitTestTests
//
//  Created by 유정주 on 2023/04/25.
//

import XCTest
@testable import ExampleUnitTest

final class ExampleUnitTestTests: XCTestCase {

    // This method is called before the invocation of each test method in the class.
    override func setUpWithError() throws {
        print("Start \(#function)")
    }

    // This method is called after the invocation of each test method in the class.
    override func tearDownWithError() throws {
        print("Start \(#function)")
    }
    
    func testNumberIsPrime() {
        //given
        let number = 3
        
        //when
        let isPrime = isPrime(number)
        
        //then
        XCTAssertTrue(isPrime, "숫자 \(number)은(는) 소수가 아닙니다.")
    }
    
    func testNumberIsNotPrime() {
        //given
        let number = 4
        
        //when
        let isPrime = isPrime(number)
        
        //then
        XCTAssertFalse(isPrime)
    }
}
