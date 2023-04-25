//
//  ViewController.swift
//  ExampleUnitTest
//
//  Created by 유정주 on 2023/04/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

func isPrime(_ number: Int) -> Bool {
    guard number >= 4 else {
        return number != 1
    }
    
    for i in 2...Int(sqrt(Double(number))) {
        if number % i == 0 {
            return false
        }
    }
    
    return true
}
