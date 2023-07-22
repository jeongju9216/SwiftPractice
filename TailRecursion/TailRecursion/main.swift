//
//  main.swift
//  TailRecursion
//
//  Created by 유정주 on 2023/07/22.
//

import Foundation

//1~n까지의 합 구하기
let time = 100_000_000

//일반 재귀
func recursion(_ num: Int) -> Int {
    if num == 0 { return num }
    return num + recursion(num - 1)
}

//꼬리 재귀
func tailRecursion(_ num: Int, _ sum: Int) -> Int {
    if num == 0 { return sum }
    return tailRecursion(num - 1, sum + num)
}

//꼬리 재귀 최적화 -> 열거형 + 클로저
enum TrampolineResult<T> {
    case done(T)
    case call(() -> TrampolineResult<T>)
}

func helper(num: Int, sum: Int) -> TrampolineResult<Int> {
    if num == 0 { return .done(sum) }
    return .call({ helper(num: num - 1, sum: sum + num) })
}

func trampolineTailRecursion(num: Int) -> Int {
    var res = helper(num: num, sum: 0)
    
    while true {
        switch res {
        case let .done(x):
            return x
        case let .call(function):
            res = function()
        }
    }
}

//꼬리 재귀 최적화의 최적화 -> 클로저 생성 오버헤드 제거
enum TrampolineResult2<A, B> {
    case done(B)
    case call(A, B)
}

func helper2(num: Int, sum: Int) -> TrampolineResult2<Int, Int> {
    if num == 0 { return .done(sum) }
    return .call(num - 1, sum + num)
}

func trampolineTailRecursion2(num: Int) -> Int {
    var res = helper2(num: num, sum: 0)
    
    while true {
        switch res {
        case let .done(x):
            return x
        case let .call(num, sum):
            res = helper2(num: num, sum: sum)
        }
    }
}

print("START")

//let start = CFAbsoluteTimeGetCurrent()
//let result1 = recursion(time / 100)
//let diff = CFAbsoluteTimeGetCurrent() - start
//print("[일반 재귀] result1: \(result1) / diff: \(diff)")
//
//let start2 = CFAbsoluteTimeGetCurrent()
//let result2 = tailRecursion(time, 0)
//let diff2 = CFAbsoluteTimeGetCurrent() - start2
//print("[꼬리 재귀] result2: \(result2) / diff2: \(diff2)")

let start3 = CFAbsoluteTimeGetCurrent()
let result3 = trampolineTailRecursion(num: time)
let diff3 = CFAbsoluteTimeGetCurrent() - start3
print("[트램폴린] result3: \(result3) / time: \(diff3)")

let start4 = CFAbsoluteTimeGetCurrent()
let result4 = trampolineTailRecursion2(num: time)
let diff4 = CFAbsoluteTimeGetCurrent() - start4
print("[트램폴린 최적화] result4: \(result4) / time: \(diff4)")
