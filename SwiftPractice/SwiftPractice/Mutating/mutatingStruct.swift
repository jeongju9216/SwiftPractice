//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/07/24.
//

import Foundation

struct SomeClass {
    var value: Int = 0
    
    mutating func increase() {
        self.value += 1
    }
}

var someClass: SomeClass = SomeClass()
print(someClass.value) //0
someClass.increase()
print(someClass.value) //1
