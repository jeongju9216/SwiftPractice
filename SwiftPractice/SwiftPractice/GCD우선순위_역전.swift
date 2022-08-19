//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/19.
//

import Foundation

let backgroundWorkItem = DispatchWorkItem(qos: .background) {
    print("Background Start")
    for _ in 0..<100000 { }
    print("Background End")
}

let userinitiatedWorkItem = DispatchWorkItem(qos: .userInitiated) {
    print("UserInitiated Start")
    for _ in 0..<100000 { }
    print("UserInitiated End")
}

let queue = DispatchQueue(label: "Queue", qos: .userInitiated, attributes: .concurrent)
for _ in 0..<10 {
    queue.async(execute: backgroundWorkItem)
}
queue.async(execute: userinitiatedWorkItem)

while true { }
