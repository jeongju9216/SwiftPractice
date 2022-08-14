//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/14.
//

import Foundation

struct Human {
    let name: String
    let age: Int
}

struct Man: Hashable {
    let name: String
    let age: Int
    let girlFriend: Human
}

let humanDict: [Human: String] = [Human(name: "시리", age: 10): "애플"]
let siri = Human(name: "시리", age: 10)
print(humanDict[siri]!)
