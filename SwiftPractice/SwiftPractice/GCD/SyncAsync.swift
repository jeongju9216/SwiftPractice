//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/05.
//

import Foundation

let queue = DispatchQueue(label: "queue")
queue.async {
    print("Task 1")
}

queue.async {
    print("Task 2")
}

queue.async {
    print("Task 3")
}

print("HI!!")

