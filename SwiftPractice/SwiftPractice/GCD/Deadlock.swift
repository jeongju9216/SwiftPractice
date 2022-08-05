//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/08/05.
//

import Foundation

let queue = DispatchQueue(label: "queue")
queue.sync { // 1
    for index in 1...5 {
        print("Hello \(index)")
    }
    
    queue.sync { // 2
        print("!!")
    }
    
    print("##")
}

while true {
    
}
