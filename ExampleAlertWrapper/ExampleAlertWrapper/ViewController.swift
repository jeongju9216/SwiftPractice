//
//  ViewController.swift
//  ExampleAlertWrapper
//
//  Created by 유정주 on 2023/08/30.
//

import UIKit

class ViewController: UIViewController {

    let alertTitle = "알림"
    let message = "알림 메시지"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showAlert1()
        
        showAlert2_1(
            title: alertTitle,
            message: message,
            okTitle: "OK",
            okHandler: { _ in
                print("clicked OK")
            },
            cancelTitle: "Cancel")
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("clicked OK")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        showAlert2_2(
            title: alertTitle,
            message: message,
            actions: [okAction, cancelAction])
        
        showAlert3()
    }

    private func showAlert1() {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("clicked OK")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
 
    func showAlert2_1(
        title: String,
        message: String,
        okTitle: String,
        okHandler: ((UIAlertAction) -> Void)? = nil,
        cancelTitle: String,
        cancelHandler: ((UIAlertAction) -> Void)? = nil)
    {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle,
                                     style: .default,
                                     handler: okHandler)
        let cancelAction = UIAlertAction(title: cancelTitle,
                                         style: .cancel,
                                         handler: cancelHandler)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func showAlert2_2(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        present(alert, animated: true)
    }

    private func showAlert3() {
        alert
            .make(title: alertTitle, message: message)
            .addAction(title: "OK") { _ in
                print("clicked OK")
            }
            .addCancelAction()
            .show()
    }
}
