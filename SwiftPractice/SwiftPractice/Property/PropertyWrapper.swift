//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/07/23.
//

import Foundation

struct SomeStruct {
    @SmallNumber var number: Int
}

@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool = false

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 10 {
                number = 10
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
    }
}

var smallNumber: SomeStruct = SomeStruct()
smallNumber.number = 10
print(smallNumber.$number) //false

smallNumber.number = 20
print(smallNumber.$number) //true
