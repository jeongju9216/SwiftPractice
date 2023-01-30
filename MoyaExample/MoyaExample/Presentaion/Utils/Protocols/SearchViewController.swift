//
//  SearchViewController.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/29.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateLabel(_ text: String) {
        self.label.text = text
    }
}
