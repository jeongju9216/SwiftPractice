//
//  SecondViewController.swift
//  DynamicTypeExample
//
//  Created by 유정주 on 11/2/23.
//

import UIKit

final class SecondViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // 다이나믹 타입 설정
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Hello"
        label.backgroundColor = .red
        
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // 다이나믹 타입 설정
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        
        button.setTitle("Hello", for: .normal)
        button.setTitle("Pressed Hello", for: .highlighted)
        button.backgroundColor = .blue
        
        return button
    }()
    
    private lazy var roundedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // 다이나믹 타입 설정
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        
        label.text = "Hello"
        label.backgroundColor = .yellow
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
        ])
        
        
        roundedView.addSubview(roundedLabel)
        NSLayoutConstraint.activate([
            roundedLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 10),
            roundedLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -10),
            roundedLabel.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: 10),
            roundedLabel.rightAnchor.constraint(equalTo: roundedView.rightAnchor, constant: -10),
        ])
        
        view.addSubview(roundedView)
        NSLayoutConstraint.activate([
            roundedView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            roundedView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        roundedView.layer.cornerRadius = roundedView.frame.height / 2
        roundedLabel.layer.cornerRadius = roundedLabel.frame.height / 2
    }
}

#Preview {
    SecondViewController()
}
