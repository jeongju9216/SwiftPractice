//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/08.
//

import Foundation

let queue1 = DispatchQueue(label: "Queue1", qos: .userInteractive)
let queue2 = DispatchQueue(label: "Queue2", qos: .utility)

queue1.async {
    for i in 1...5 {
        print("[🐶] \(i)")
    }
}

queue2.async {
    for i in 100...105 {
        print("[🌝] \(i)")
    }
}

while true { }
