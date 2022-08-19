//
//  ViewController.swift
//  ConcurrencyTest
//
//  Created by 유정주 on 2022/08/19.
//

import UIKit

class ViewController: UIViewController {

    let time = 1_000_000

    override func viewDidLoad() {
        super.viewDidLoad()

        swiftConcurrency()
    }
    
    func gcdConcurrency() {
        let backgroundWorkItem = DispatchWorkItem(qos: .background) {
            let arr = (0..<self.time).map { num in self.time - num }
            let _ = arr.sorted(by: <)
        }
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "GCD", qos: .background, attributes: .concurrent)
        for _ in 0..<100000 {
            queue.async(execute: backgroundWorkItem)
        }
        group.wait()
    }
    
    func swiftConcurrency() {
        Task {
            await withTaskGroup(of: Double.self) { group in
                for _ in 0..<100000 {
                    group.addTask(priority: .background) {
                        await self.sortArray()
                        return 0
                    }
                }
            }
        }
    }
    
    func sortArray() async {
        await Task.yield()
        let arr = (0..<self.time).map { num in time - num }
        await Task.yield()
        let _ = arr.sorted(by: <)
    }
}

