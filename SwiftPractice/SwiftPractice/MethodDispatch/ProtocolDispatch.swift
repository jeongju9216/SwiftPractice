//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/10.
//

import Foundation

protocol Greetable {
    func greeting()
}

struct Human: Greetable {
    func greeting() {
        print("인간이 인사한다.")
    }
}
