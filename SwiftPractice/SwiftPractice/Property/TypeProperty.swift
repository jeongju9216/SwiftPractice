//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/07/23.
//

import Foundation

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

class ExtensionClass: SomeClass {
    override class var overrideableComputedTypeProperty: Int {
        return 200
    }
}

print("ExtensionClass: \(ExtensionClass.overrideableComputedTypeProperty)")


