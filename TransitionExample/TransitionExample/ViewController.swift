//
//  ViewController.swift
//  TransitionExample
//
//  Created by 유정주 on 2022/09/15.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "HELLO"
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        changeLayout()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        changeLayout()
    }
    
    private func changeLayout() {
        if UIDevice.current.orientation.isLandscape {
            landscapLayout()
        } else {
            portraitLayout()
        }
    }
    
    private func landscapLayout() {
        label.text = "Landscape"
    }
    
    private func portraitLayout() {
        label.text = "Portrait"
    }
}

