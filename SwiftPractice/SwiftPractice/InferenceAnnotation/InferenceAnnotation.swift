//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/11.
//

import Foundation

public func measureTime(_ closure: () -> ()) -> TimeInterval {
    let startDate = Date()
    closure()
    return Date().timeIntervalSince(startDate)
}

var inference: Double = 0
for i in 0..<10 {
    let inferenceTime = measureTime {
        for _ in 0..<10000 {
            let value = [1, 2, 3, 4, 5]
        }
    }
    print("[inference] \(i) : \(inferenceTime)")
    inference += inferenceTime
}

var annotation: Double = 0
for i in 0..<10 {
    let annotationTime = measureTime {
        for _ in 0..<10000 {
            let value: [Int] = [1, 2, 3, 4, 5]
        }
    }
    print("[annotation] \(i) : \(annotationTime)")
    annotation += annotationTime
}


let inferenceResult = String(format: "[inference] total: %.3f / avg: %.3f", inference, inference/10.0)
let annotationResult = String(format: "[annotation] total: %.3f / avg: %.3f", annotation, annotation/10.0)
print(inferenceResult)
print(annotationResult)
