//
//  Coordiantor.swift
//  Practice-Coordinator-Pattern
//
//  Created by 유정주 on 2023/03/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
