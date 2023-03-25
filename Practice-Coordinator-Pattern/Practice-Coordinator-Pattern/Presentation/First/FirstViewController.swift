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
    }
    
    @IBAction func clickedPushSecondButton(_ sender: UIButton) {
        print("버튼 클릭")
        delegate?.navigateToSecond()
    }
}

