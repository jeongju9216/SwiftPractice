//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/21.
//

import Foundation

struct Human {
    var name: String
    var address: Address
}

class Address {
    var address: String
    init(_ address: String) {
        self.address = address
    }
}

var human = Human(name: "시리", address: Address("미국"))
var copyHuman = human

copyHuman.name = "빅스비"
copyHuman.address.address = "한국"

print("human: \(human.name) / \(human.address.address)")
print("copyHuman: \(copyHuman.name) / \(copyHuman.address.address)")
