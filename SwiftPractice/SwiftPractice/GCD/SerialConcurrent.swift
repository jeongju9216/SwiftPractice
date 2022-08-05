//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/01.
//

import Foundation

public func measureTime(_ closure: () -> ()) -> TimeInterval {
    let startDate = Date()
    closure()
    return Date().timeIntervalSince(startDate)
}

var numbers: [Int] = [1, 2, 3, 4, 5]
let serialQueue: DispatchQueue = DispatchQueue(label: "serial")
let concurrentQueue: DispatchQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)

let serialTime = measureTime {
    for i in 0..<100 {
        serialQueue.sync {
            for number in numbers {
                print("[\(i)] \(number)")
            }
        }
    }
}

let concurrentTime = measureTime {
    for i in 0..<100 {
        concurrentQueue.sync {
            for number in numbers {
                print("[\(i)] \(number)")
            }
        }
    }
}

print("serial Time: \(serialTime)")
print("concurrent Time: \(concurrentTime)")

while(true) {}
