//
//  main.swift
//  SwiftPractice
//
//  Created by 유정주 on 2022/07/24.
//

import Foundation

extension String {
    subscript(idx: Int) -> String? {
        guard idx >= 0 && idx < count else { return nil }

        let target = index(startIndex, offsetBy: idx)
        return String(self[target])
    }
}

var test: String = "HI"
print(test[0])
