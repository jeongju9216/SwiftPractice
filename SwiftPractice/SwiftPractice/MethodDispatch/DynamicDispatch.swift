//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/08.
//

import Foundation

class Person {
    func greeting() {
        print("사람이 인사한다.")
    }
}

class Baby: Person {
    override func greeting() {
        print("아기가 인사한다.")
    }
}

let person: Person = Person()
person.greeting()

let baby: Person = Baby()
baby.greeting()
