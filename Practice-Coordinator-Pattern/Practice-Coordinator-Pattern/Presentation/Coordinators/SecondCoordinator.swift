//
//  SecondCoordinator.swift
//  Practice-Coordinator-Pattern
//
//  Created by 유정주 on 2023/03/24.
//

import UIKit

final class SecondCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: FirstCoordinator?
    var navigationController: UINavigationController
    
    //ViewModel 필요시 init으로 전달
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("SecondCoordinator start")
        let vc = SecondViewController.instantiate
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension SecondCoordinator: SecondViewControllerDelegate {
    func didFinish() {
        print("didFinish")
        parentCoordinator?.finished(child: self)
    }
}
