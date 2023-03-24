//
//  UIViewController.swift
//  Practice-Coordinator-Pattern
//
//  Created by 유정주 on 2023/03/24.
//

import UIKit

extension UIViewController {
    static var storyboardName: String {
        String(describing: self)
    }
    
    static var storyboard: UIStoryboard {
        UIStoryboard(name: storyboardName, bundle: nil)
    }
    
    static var instantiate: Self {
        storyboard.instantiateViewController(withIdentifier: storyboardName) as! Self
    }
}
