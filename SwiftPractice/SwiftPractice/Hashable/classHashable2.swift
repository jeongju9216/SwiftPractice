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
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

let siri = Human(name: "시리", age: 10)
let newSiri = Human(name: "시리", age: 1)

var humanDict: [Human: String] = [siri: "애플"]

humanDict[newSiri] = "갤럭시"
print(humanDict[siri]!)
