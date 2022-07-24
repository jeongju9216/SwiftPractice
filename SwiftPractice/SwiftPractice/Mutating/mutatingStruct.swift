//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/07/24.
//

import Foundation

enum StateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var stateSwitch = StateSwitch.off
print(stateSwitch)
stateSwitch.next()
print(stateSwitch)
