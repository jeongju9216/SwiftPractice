//
//  ViewController.swift
//  ShortProgressView
//
//  Created by 유정주 on 4/13/25.
//

import UIKit

class ViewController: UIViewController {
    
    let progressViews: [UIProgressView] = Array(0...10).map { i in
        let progressView = UIProgressView()
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .cyan
        progressView.frame = CGRect(x: 180, y: 300 + 20 * i, width: 100, height: 8)
        progressView.progress = 0.01 * Float(i)
        return progressView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        progressViews.forEach { view.addSubview($0) }
    }
}

