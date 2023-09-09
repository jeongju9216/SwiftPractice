//
//  ViewController.swift
//  ExampleAnimation
//
//  Created by 유정주 on 2023/09/09.
//

import UIKit

class ViewController: UIViewController {

    var animatedView: UIView = {
        let animatedView = UIView(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        animatedView.backgroundColor = .red
        return animatedView
    }()
    
    var subView: UIView = {
        let animatedView = UIView(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        animatedView.backgroundColor = .blue
        return animatedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(animatedView)
    }

    override func viewDidAppear(_ animated: Bool) {
//        animation() //animate
//        transition() //transition
//        keyframe() //keyframe
//        coreAnimation() //core animation
    }
    
    func animation() {
//        //frame 조절
//        animateFrame1() //크기 변경
//        animateFrame2() // 위치 변경
//
//        //bounds 조절
//        animateBounds1() //크기 변경
//        animateBounds2() //위치 변경
//
//        //center 변경
//        animateCenter()
//
//        //transform
//        //개별로 동작함
//        animateTransformScale()
//        animateTransformRotation()
//        animateTransformSkew()
//        //합쳐진 transform으로 동작함
//        animateTransformTransformConcatenating()
//
//        //alpha
//        animateAlpha()
//
//        //백그라운드 조절
//        animateBackgrounColor()
//
//        //원상복구, completion
//        animateIdentity1()
//        animateIdentity2()
    }
    
    func transition() {
//        animateFlip() //동작 안 하는 거 예시
//        transitionFlipFromLeft()
//        transitionFlipFromRight()
//        transitionFlipFromTop()
//        transitionFlipFromBottom()
//        transitionCurlUp()
//        transitionCurlDown()
//        transitionCrossDissolve()
    }
    
    func keyframe() {
//        // key frame - 여러 개 애니메이션 순차 진행
//        animateMultiple()
//        animateKeyframe()
    }
    
    func coreAnimation() {
//        // backgroundColor
//        coreAnimationBackground()
//
//        // rotate
//        coreAnimationRotation()
//
//        // move circle path
//        keyframeAnimationCirclePath()
    }
}
