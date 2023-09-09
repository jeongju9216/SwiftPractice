//
//  animate-transition.swift
//  ExampleAnimation
//
//  Created by 유정주 on 2023/09/09.
//

import UIKit

//MARK: - animate, transition 메서드
extension ViewController {
    func animateIdentity1() {
        UIView.animate(withDuration: 3.0, animations: {
            self.animateTransformScale()
        }, completion: { _ in
            UIView.animate(withDuration: 3.0) {
                self.animatedView.transform = .identity
            }
        })
    }
    
    func animateIdentity2() {
        UIView.animate(withDuration: 3.0, animations: {
            self.animateTransformTransformConcatenating()
        }) { _ in
            UIView.animate(withDuration: 3.0) {
                self.animatedView.transform = .identity
            }
        }
    }
    
    func animateFrame1() {
        UIView.animate(withDuration: 3.0) {
            self.animatedView.frame = CGRect(x: 150, y: 150, width: 200, height: 200)
        }
    }
    
    func animateFrame2() {
        UIView.animate(withDuration: 3.0) {
            self.animatedView.frame = CGRect(x: 150, y: 300, width: 100, height: 100)
        }
    }
    
    func animateBounds1() {
        UIView.animate(withDuration: 3.0) {
            self.animatedView.bounds = CGRect(x: 150, y: 150, width: 200, height: 200)
        }
    }
    
    func animateBounds2() {
        UIView.animate(withDuration: 3.0) {
            self.animatedView.bounds = CGRect(x: 150, y: 300, width: 100, height: 100)
        }
    }
    
    func animateCenter() {
        UIView.animate(withDuration: 3.0) {
            self.animatedView.center = self.view.center
        }
    }
    
    func animateTransformScale() {
        UIView.animate(withDuration: 3.0) {
            //width, height가 2배씩
            self.animatedView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    func animateTransformRotation() {
        UIView.animate(withDuration: 3.0) {
            self.animatedView.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    func animateTransformSkew() {
        //기하학에서 두 축 (예: X축과 Y축) 사이의 각도를 바꾸는 것을 의미합니다.
        //객체를 기울이거나 비틀 수 있습니다.
        //X: 수평, Y: 수직
        UIView.animate(withDuration: 3.0) {
            var skew = CGAffineTransform.identity //기본값을 나타내는 값
            skew.c = -0.5 // X 방향으로 기울기
//            skew.b = 0.5  // Y 방향으로 기울기

            self.animatedView.transform = skew
        }
    }
    
    func animateTransformTransformConcatenating() {
        let scale = CGAffineTransform(scaleX: 2, y: 2)
        let rotation = CGAffineTransform(rotationAngle: .pi)
        var skew = CGAffineTransform.identity //기본값을 나타내는 값
        skew.c = -0.5 // X 방향으로 기울기
//        skew.b = 0.5  // Y 방향으로 기울기

        //concatenating으로 transform을 합침
        let comine = scale
            .concatenating(rotation)
            .concatenating(skew)
        UIView.animate(withDuration: 3.0) {
            self.animatedView.transform = comine
        }
    }
    
    func animateAlpha() {
        UIView.animate(withDuration: 3.0) {
            self.animatedView.alpha = 0
        }
    }
    
    func animateBackgrounColor() {
        UIView.animate(withDuration: 3.0) {
            self.animatedView.backgroundColor = .blue
        }
    }
}
