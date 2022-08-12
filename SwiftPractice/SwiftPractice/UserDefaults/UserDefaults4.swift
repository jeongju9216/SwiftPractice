//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/12.
//

import Foundation

UserDefaults.standard.set(10, forKey: "value")
let value = UserDefaults.standard.integer(forKey: "value")
print(value)

UserDefaults.standard.removeObject(forKey: "value")

let value2 = UserDefaults.standard.integer(forKey: "value")
print(value2)

