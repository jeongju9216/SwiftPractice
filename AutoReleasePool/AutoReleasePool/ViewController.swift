//
//  ViewController.swift
//  AutoReleasePool
//
//  Created by 유정주 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func memoryTest(sender: UIButton) {
        let imgPath = Bundle.main.path(forResource: "profile-circle", ofType: ".png")!
        
        for i in 0..<10 {
            print("----- test \(i) -----")
            autoreleasepool {
                for _ in 0..<10000 {
                    let image: UIImage = UIImage(contentsOfFile: imgPath)!
                }
            }
        }
    }
}

