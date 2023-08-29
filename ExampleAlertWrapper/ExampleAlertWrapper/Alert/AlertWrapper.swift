//
//  AlertWrapper.swift
//  FruitCardGame
//
//  Created by 유정주 on 2023/08/29.
//

import UIKit

/// UIAlertController Wrapper
struct AlertWrapper<Base> {
    let base: Base
    
    init(base: Base) {
        self.base = base
    }
}

/// AlertWrapper와 호환 여부
protocol AlertCompatible: AnyObject {
    associatedtype Base
    var alert: AlertWrapper<Base> { get }
}

extension AlertCompatible {
    var alert: AlertWrapper<Self> {
        get { AlertWrapper(base: self) }
        set { }
    }
}

/// UIViewController는 AlertWrapper 사용 가능
extension UIViewController: AlertCompatible { }
