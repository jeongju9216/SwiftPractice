//
//  AlertWrapper+UIViewController.swift
//  FruitCardGame
//
//  Created by 유정주 on 2023/08/29.
//

import UIKit

private struct AlertWrapperAssociatedKeys {
    static var alertController = "alertController"
}

extension AlertWrapper where Base: UIViewController {
    /// 계산 프로퍼티를 저장 프로퍼티처럼 사용
    /// AlertController 저장
    private var alertController: UIAlertController? {
        get { getAssociatedObject(base, &AlertWrapperAssociatedKeys.alertController) }
        set { setRetainedAssociatedObject(base, &AlertWrapperAssociatedKeys.alertController, newValue) }
    }
    
    /// Alert 생성
    func make(title: String = "알림", message: String? = nil) -> Self {
        var mutableSelf = self
        mutableSelf.alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        return mutableSelf
    }
    
    /// Alert에 Default 액션 추가
    func addAction(title: String? = "OK", handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: title,
                                   style: .default,
                                   handler: handler)
        self.alertController?.addAction(action)
        return self
    }
    
    /// Alert에 Cancel 액션 추가
    func addCancelAction(title: String? = "Cancel", handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: title,
                                   style: .cancel,
                                   handler: handler)
        self.alertController?.addAction(action)
        return self
    }
    
    /// Alert 표시
    func show() {
        guard let alert = alertController else { return }
        base.present(alert, animated: true)
    }
}

private extension AlertWrapper {
    func getAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(object, key) as? T
    }

    func setRetainedAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer, _ value: T) {
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
