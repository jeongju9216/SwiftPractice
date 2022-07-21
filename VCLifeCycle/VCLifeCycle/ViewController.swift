//
//  ViewController.swift
//  VCLifeCycle
//
//  Created by 유정주 on 2022/06/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nextButton: UIButton!
    
    override func loadView() {
        super.loadView()
        print("[First] - \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[First] - \(#function)")
        
        print("nextButton frame: \(nextButton.frame.size)")
        print("nextButton frame: \(nextButton.frame)")
        print("nextButton bounds: \(nextButton.bounds)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("[First] - \(#function)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[First] - \(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[First] - \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("[First] - \(#function)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("[First] - \(#function)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("[First] - \(#function)")
        
        print("nextButton frame: \(nextButton.frame.size)")
        print("nextButton frame: \(nextButton.frame)")
        print("nextButton bounds: \(nextButton.bounds)")
    }
}

