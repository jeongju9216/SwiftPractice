//
//  ViewController+CoreAnimation.swift
//  ExampleAnimation
//
//  Created by 유정주 on 2023/09/09.
//

import UIKit

extension ViewController {
    func coreAnimationBackground() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.red.cgColor
        animation.toValue = UIColor.blue.cgColor
        animation.duration = 3.0

        animatedView.layer.add(animation, forKey: "backgroundColorAnimation")

        // 최종 배경색 설정
        animatedView.backgroundColor = .blue
    }
    
    func coreAnimationRotation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi
        animation.duration = 3.0

        animatedView.layer.add(animation, forKey: "rotationAnimation")
    }
    
    func keyframeAnimationCirclePath() {
        // 원을 그리는 경로를 따라 뷰를 이동시키는 애니메이션
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = UIBezierPath(arcCenter: CGPoint(x: 150, y: 150),
                                      radius: 100,
                                      startAngle: 0,
                                      endAngle: .pi * 2,
                                      clockwise: true).cgPath
        animation.duration = 3.0
        
        animatedView.layer.add(animation, forKey: "positionAnimation")
    }
}
