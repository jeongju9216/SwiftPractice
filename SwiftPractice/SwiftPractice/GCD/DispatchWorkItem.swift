//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/08.
//

import Foundation

let queue1 = DispatchQueue(label: "Queue1", attributes: .concurrent)

let item1 = DispatchWorkItem(qos: .userInteractive) {
    for i in 1...5 {
        print("[🐶] \(i)")
    }
}

let item2 = DispatchWorkItem(qos: .utility) {
    for i in 100...105 {
        print("[🌝] \(i)")
    }
}

queue1.async(execute: item1)
queue1.async(execute: item2)

while true { }
