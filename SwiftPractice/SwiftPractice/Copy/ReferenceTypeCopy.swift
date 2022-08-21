//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/21.
//

import Foundation

class Human {
    var name: String = ""
    init(name: String) {
        self.name = name
    }
}

let human = Human(name: "시리")
let copyHuman = human

print("human: \(human.name)") //시리
print("copyHuman: \(copyHuman.name)") //시리

copyHuman.name = "빅스비"

print("human: \(human.name)") //빅스비
print("copyHuman: \(copyHuman.name)") //빅스비
