//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/12.
//

import Foundation

var x = 10
UserDefaults.standard.set(x, forKey: "value")
x = 5


if let x = UserDefaults.standard.object(forKey: "value") as? Int {
    print(x)
}
