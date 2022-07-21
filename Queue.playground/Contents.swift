//
//  main.swift
//  DataStructure
//
//  Created by 유정주 on 2022/04/09.
//

import Foundation

struct Queue<T> {
    private var queue: [T] = []
    
    public var size: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : queue.removeFirst()
    }
}

struct Queue2<T> {
    private var queue: [T?] = []
    private var front: Int = 0
    
    public var size: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard front <= size, let element = queue[front] else { return nil }
        queue[front] = nil
        front += 1
        return element
    }
}

var myQueue = Queue<Int>()
var myQueue2 = Queue2<Int>()

let times = 100000000 //1억
let workingCheck = 10000000
var durationTime = 0.0, startTime = 0.0

startTime = CFAbsoluteTimeGetCurrent()
for i in 0..<times {
    if i % workingCheck == 0 {
        print("I'm Working 1")
    }
    myQueue.enqueue(1)
}
durationTime = CFAbsoluteTimeGetCurrent() - startTime
print("queue1 enqueue: \(durationTime)")

startTime = CFAbsoluteTimeGetCurrent()
for i in 0..<times {
    if i % workingCheck == 0 {
        print("I'm Working 2")
    }
    myQueue2.enqueue(1)
}
durationTime = CFAbsoluteTimeGetCurrent() - startTime
print("queue2 enqueue: \(durationTime)")

startTime = CFAbsoluteTimeGetCurrent()
for i in 0..<times {
    if i % workingCheck == 0 {
        print("I'm Working 3")
    }
    myQueue.dequeue()
}
durationTime = CFAbsoluteTimeGetCurrent() - startTime
print("queue1 dequeue: \(durationTime)")

startTime = CFAbsoluteTimeGetCurrent()
for i in 0..<times {
    if i % workingCheck == 0 {
        print("I'm Working 4")
    }
    myQueue2.dequeue()
}
durationTime = CFAbsoluteTimeGetCurrent() - startTime
print("queue2 dequeue: \(durationTime)")
