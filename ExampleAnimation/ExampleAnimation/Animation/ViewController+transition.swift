//
//  ViewController+transition.swift
//  ExampleAnimation
//
//  Created by 유정주 on 2023/09/09.
//

import UIKit

extension ViewController {
    // animate와 transition 비교
    func animateFlip() {
        //transitionFlipFromLeft 옵션이 동작 안 함
        UIView.animate(withDuration: 3.0, delay: 0, options: [.transitionFlipFromLeft]) {
            self.animatedView.backgroundColor = .blue
        }
    }
    
    func transitionFlipFromLeft() {
        //동작함
        UIView.transition(with: animatedView, duration: 3.0, options: [.transitionFlipFromLeft]) {
            self.animatedView.backgroundColor = .blue
        }
    }
    
    func transitionFlipFromRight() {
        //동작함
        UIView.transition(with: animatedView, duration: 3.0, options: [.transitionFlipFromRight]) {
            self.animatedView.backgroundColor = .blue
        }
    }
    
    func transitionFlipFromBottom() {
        //동작함
        UIView.transition(with: animatedView, duration: 3.0, options: [.transitionFlipFromBottom]) {
            self.animatedView.backgroundColor = .blue
        }
    }
    
    func transitionFlipFromTop() {
        //동작함
        UIView.transition(with: animatedView, duration: 3.0, options: [.transitionFlipFromTop]) {
            self.animatedView.backgroundColor = .blue
        }
    }
    
    func transitionCurlUp() {
        //동작함
        UIView.transition(with: animatedView, duration: 3.0, options: [.transitionCurlUp]) {
            self.animatedView.backgroundColor = .blue
        }
    }
    
    func transitionCurlDown() {
        //동작함
        UIView.transition(with: animatedView, duration: 3.0, options: [.transitionCurlDown]) {
            self.animatedView.backgroundColor = .blue
        }
    }
    
    func transitionCrossDissolve() {
        //동작함
        UIView.transition(with: animatedView, duration: 3.0, options: [.transitionCrossDissolve]) {
            self.animatedView.backgroundColor = .blue
        }
    }
}
