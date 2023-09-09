//
//  ViewController+Keyframes.swift
//  ExampleAnimation
//
//  Created by 유정주 on 2023/09/09.
//

import UIKit

extension ViewController {
    // key frame
    func animateMultiple() {
        // 4번의 애니메이션을 순차적으로 동작
        UIView.animate(withDuration: 1.0, animations: {
            self.animatedView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { _ in
            UIView.animate(withDuration: 1.0, animations: {
                self.animatedView.transform = .identity
            }, completion: { _ in
                UIView.animate(withDuration: 1.0, animations: {
                    self.animatedView.transform = CGAffineTransform(scaleX: 2, y: 2)
                }, completion: { _ in
                    UIView.animate(withDuration: 1.0, animations: {
                        self.animatedView.transform = .identity
                    })
                })
            })
        }
    }
    
    func animateKeyframe() {
        // 전체 애니메이션 시간
        UIView.animateKeyframes(withDuration: 4, delay: 0, animations: {
            // 0~1까지 설정. 상대적인 시간 설정
            UIView.addKeyframe(withRelativeStartTime: 0/4, relativeDuration: 1/4, animations: {
                self.animatedView.transform = CGAffineTransform(scaleX: 2, y: 2)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 1/4, animations: {
                self.animatedView.transform = .identity
            })
            
            UIView.addKeyframe(withRelativeStartTime: 2/4, relativeDuration: 1/4) {
                self.animatedView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4) {
                self.animatedView.transform = .identity
            }
        })
    }
}
