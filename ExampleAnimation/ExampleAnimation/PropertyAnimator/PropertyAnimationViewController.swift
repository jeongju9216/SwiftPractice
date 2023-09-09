//
//  PropertyAnimationViewController.swift
//  ExampleAnimation
//
//  Created by 유정주 on 2023/09/09.
//

import UIKit

class PropertyAnimationViewController: UIViewController {
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = .zero
        slider.value = .zero
        slider.addTarget(self, action: #selector(didSliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    private let animationView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private var animation: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        configureAnimation()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        animation?.startAnimation()
    }
        
    @objc private func didSliderValueChanged() {
        animation?.fractionComplete = CGFloat(slider.value)
    }
    
    private func configureAnimation() {
        animation = .init(duration: 1, curve: .linear, animations: { [weak self] in
            guard let self = self else { return }
            
            self.animationView.layer.cornerRadius = self.animationView.frame.width / 2
            self.animationView.frame.origin.x = self.view.frame.width - 100
            
            self.view.backgroundColor = .label
        })
    }
}

//MARK: - UI
extension PropertyAnimationViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size: CGFloat = 100
        animationView.frame = CGRect(x: 0, y: view.center.y - size - 20, width: size, height: size)
    }
    
    private func setUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(slider)
        view.addSubview(animationView)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let sliderConstraints = [
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(sliderConstraints)
    }

}
