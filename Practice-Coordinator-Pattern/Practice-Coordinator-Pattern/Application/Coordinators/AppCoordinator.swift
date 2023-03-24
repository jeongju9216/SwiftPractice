//
//  AppCoordinator.swift
//  Practice-Coordinator-Pattern
//
//  Created by 유정주 on 2023/03/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.childCoordinators = []
    }
    
    func start() {
        window.rootViewController = navigationController
        
        showFirstViewController()
        
        window.makeKeyAndVisible()
    }
    
    private func showFirstViewController() {
        let coordinator = FirstCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
