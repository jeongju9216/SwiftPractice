//
//  NextViewController.swift
//  VCLifeCycle
//
//  Created by 유정주 on 2022/06/27.
//

import UIKit

class NextViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        print("[Second] - \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[Second] - \(#function)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("[Second] - \(#function)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[Second] - \(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[Second] - \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("[Second] - \(#function)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("[Second] - \(#function)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("[Second] - \(#function)")
    }
}
