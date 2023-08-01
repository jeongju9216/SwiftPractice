//
//  main.swift
//  XCTestMeasureExample
//
//  Created by 유정주 on 2023/08/01.
//

import Foundation

func excuteRemoveLast() {
    var array = Array(repeating: 0, count: 100_000)
    while !array.isEmpty {
        array.removeLast()
    }
}

func excuteRemoveFirst() {
    var array = Array(repeating: 0, count: 100_000)
    while !array.isEmpty {
        array.removeFirst()
    }
}
