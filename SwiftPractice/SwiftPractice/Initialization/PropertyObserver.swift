//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/07/24.
//

import Foundation

class Human {
    var name: String
    var age: Int {
        didSet {
            print("didSet")
        }
        willSet {
            print("willSet")
        }
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let human: Human = Human(name: "애플", age: 0)
print(human.age)
