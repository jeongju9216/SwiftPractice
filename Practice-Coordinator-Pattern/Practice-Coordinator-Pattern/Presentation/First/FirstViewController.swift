//
//  FirstViewController.swift
//  Practice-Coordinator-Pattern
//
//  Created by 유정주 on 2023/03/24.
//

import UIKit

protocol FirstViewControllerDelegate: AnyObject {
    func navigateToSecond()
}

final class FirstViewController: UIViewController {

    weak var delegate: FirstViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("delegate is nil? \(delegate == nil)")
    }
    
    @IBAction func clickedPushSecondButton(_ sender: UIButton) {
        print("clickedPushSecondButton: \(delegate == nil)")
        delegate?.navigateToSecond()
    }
}

