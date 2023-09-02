//
//  ViewController.swift
//  VCLifeCycle
//
//  Created by 유정주 on 2022/06/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nextButton: UIButton!
    
    // 정확한 프레임 크기와 위치를 가진 뷰 생성
    var accurateView: UIView?
    
    override func loadView() {
        super.loadView()
        print("A: \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A: \(#function)")
        print("View: \(self.view)")
        print("SafeArea: \(self.view.safeAreaLayoutGuide.layoutFrame)")
//        addView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("A: \(#function)")
        print("View: \(self.view)")
        print("SafeArea: \(self.view.safeAreaLayoutGuide.layoutFrame)")
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("A: \(#function)")
        print("View: \(self.view)")
        print("SafeArea: \(self.view.safeAreaLayoutGuide.layoutFrame)") // 바뀜
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("A: \(#function)")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("A: \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("A: \(#function)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("A: \(#function)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("A: \(#function)")
    }
    
    func addView() {
        accurateView = UIView()
        accurateView?.translatesAutoresizingMaskIntoConstraints = false
        if let accurateView = accurateView {
            accurateView.backgroundColor = UIColor.blue
            view.addSubview(accurateView)
            NSLayoutConstraint.activate([
                accurateView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
                accurateView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1),
                accurateView.topAnchor.constraint(equalTo: nextButton.bottomAnchor)
            ])
        }
    }
}

