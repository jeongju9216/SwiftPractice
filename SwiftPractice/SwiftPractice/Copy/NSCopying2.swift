//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/21.
//

import Foundation

class Human {
    var name: String
    var address: Address
    
    init(name: String, address: Address) {
        self.name = name
        self.address = address
    }
}

class Address {
    var address: String
    init(_ address: String) {
        self.address = address
    }
}

let human = Human(name: "시리", address: Address("미국"))
let copyHuman = human

print("human: \(human.name) / \(human.address)")
print("copyHuman: \(copyHuman.name) / \(copyHuman.address)")

copyHuman.name = "빅스비"
copyHuman.address = Address("한국")

print("human: \(human.name) / \(human.address.address)") // 시리 / 한국
print("copyHuman: \(copyHuman.name) / \(copyHuman.address.address)") //빅스비 / 한국

