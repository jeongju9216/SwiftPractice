import UIKit

import Foundation

let maxConcurrentTasks = 3

func performAsyncTask(taskNumber: Int) async -> Int {
    try? await Task.sleep(until: .now + .seconds(Int.random(in: 1...3)), clock: .continuous) // 1~3초 사이의 랜덤 대기
    return taskNumber
}

func printNumber(_ number: Int) {
    print("pass \(number)")
}

func performMultipleTasksConcurrently() async {
    await withTaskGroup(of: Void.self) { group in
        while !items.isEmpty {
            if count >= maxConcurrentTasks {
                await group.next()
                count -= 1
            }
            count += 1

            group.addTask {
                if !items.isEmpty {
                    let front = items.removeFirst()
                    
                    print("Start \(front)")
                    let item = await performAsyncTask(taskNumber: front)
                    printNumber(item)
                }
            }
        }
        
        await group.waitForAll()
    }
}

var isStarted = false
var items: [Int] = [1, 2, 3, 4, 5]
var count = 0

// 사용 예시
Task {
    while true {
        items.append(items.count)
        try? await Task.sleep(until: .now + .seconds(5), clock: .continuous)
    }
}

Task {
    while true {
        if !isStarted {
            isStarted = true
            await performMultipleTasksConcurrently()
            isStarted = false
        }
        
        try? await Task.sleep(until: .now + .seconds(0.1), clock: .continuous)
    }
}
