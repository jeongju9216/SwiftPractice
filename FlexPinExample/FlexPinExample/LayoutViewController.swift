//
//  LayoutViewController.swift
//  FlexPinExample
//
//  Created by 유정주 on 6/4/24.
//

import UIKit

class LayoutViewController<T: UIView>: UIViewController {
    
    var layoutView: T {
        view as! T
    }
    
    override func loadView() {
        super.loadView()
        view = T()
    }
}
