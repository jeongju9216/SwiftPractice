//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/10.
//

import Foundation

class Human {
    private var name: String = ""
    private var alias: String = ""
    var age: Int = 0
}

class Baby: Human {
    override var age: Int = 3
}

