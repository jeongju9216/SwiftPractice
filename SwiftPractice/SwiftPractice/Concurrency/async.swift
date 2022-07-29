//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/07/29.
//

import Foundation

protocol SomeProtocol {
    func test() async
}

func asyncTest() async throws -> String {
    try await Task.sleep(nanoseconds: 3_000_000_000) //3초
    return "sleep 끝"
}

print("Before Task")
Task {
    let string: String = try await asyncTest()
    print(string)
}
print("After Task")

while(true) { }
