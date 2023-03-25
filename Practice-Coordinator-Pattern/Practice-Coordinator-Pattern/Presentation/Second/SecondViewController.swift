//
//  SecondViewController.swift
//  Practice-Coordinator-Pattern
//
//  Created by 유정주 on 2023/03/24.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    func didFinish()
}

final class SecondViewController: UIViewController {
    
    weak var delegate: SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SecondVC 사라짐")
        delegate?.didFinish()
    }
}
