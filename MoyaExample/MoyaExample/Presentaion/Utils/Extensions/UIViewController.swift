//
//  UIViewController.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/29.
//

import UIKit

extension UIViewController {
    static var storyboardName: String {
        String(describing: self)
    }
    
    static var storyboard: UIStoryboard {
        UIStoryboard(name: String(describing: self), bundle: nil)
    }
    
    static var instantiate: UIViewController {
        storyboard.instantiateViewController(withIdentifier: String(describing: self))
    }
}

extension UIViewController {
    func removeViewController() {
        guard parent != nil else {
            return
        }
        
        self.willMove(toParent: nil) //child 제거 알림
        self.removeFromParent() //parent에서 child 제거
        self.view.removeFromSuperview() //parent의 view에서 child의 view 제거
    }
}
