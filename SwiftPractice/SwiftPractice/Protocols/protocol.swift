//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/07/31.
//

import Foundation

protocol SomeProtocol {
    init()
}

class SomeClass {
    init() {
        
    }
}

class SubClass: SomeClass, SomeProtocol {
    required override init() {
        
    }
}
