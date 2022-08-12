//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/12.
//

import Foundation

UserDefaults.standard.register(defaults: [
    "SomeKey" : "Some Message"
])

let data = UserDefaults.standard.string(forKey: "SomeKey")
print(data)
