//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/14.
//

import Foundation

class Human {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Human: Hashable {
    static func == (lhs: Human, rhs: Human) -> Bool {
        return (lhs.name == rhs.name) && (lhs.age == rhs.age)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
    }
}

let humanDict: [Human: String] = [Human(name: "시리", age: 10): "애플"]
let siri = Human(name: "시리", age: 10)
print(humanDict[siri]!)
