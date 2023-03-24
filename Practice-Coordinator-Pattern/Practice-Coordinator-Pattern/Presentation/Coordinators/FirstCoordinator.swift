//
//  FirstCoordinator.swift
//  Practice-Coordinator-Pattern
//
//  Created by 유정주 on 2023/03/24.
//

import UIKit

final class FirstCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //ViewModel 필요시 init으로 전달
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("FirstCoordinator start")
        let vc = FirstViewController.instantiate
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finished(child: Coordinator) {
        print("finished: \(child)")
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
    private func showSecondViewController() {
        print("showSecondViewController")
        let child = SecondCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}

extension FirstCoordinator: FirstViewControllerDelegate {
    func navigateToSecond() {
        print("navigateToSecond")
        showSecondViewController()
    }
}
