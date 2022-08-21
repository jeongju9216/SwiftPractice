//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/19.
//

import Foundation

var arr: [Int] = [1, 2, 3]
var copyArr = arr

print("arr: \(arr)") //[1, 2, 3]
print("copyArr: \(copyArr)") //[1, 2, 3]

copyArr = [4, 5, 6]
print("arr: \(arr)") //[1, 2, 3]
print("copyArr: \(copyArr)") //[4, 5, 6]
