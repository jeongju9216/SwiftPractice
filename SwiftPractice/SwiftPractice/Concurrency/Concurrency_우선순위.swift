//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/19.
//

import Foundation

for _ in 0..<10 {
    Task(priority: .background) {
        print("Background Start")
        for _ in 0..<100000 { }
        print("Background End")
    }
}

Task(priority: .userInitiated) {
    print("UserInitiated Start")
    for _ in 0..<100000 { }
    print("UserInitiated End")
}

while true { }
