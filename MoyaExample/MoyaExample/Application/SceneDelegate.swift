//
//  SceneDelegate.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import UIKit
import SwinjectStoryboard

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let swinjectContainer = SwinjectContainer()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windoeScene = (scene as? UIWindowScene) else { return }
        
        self.window = .init(windowScene: windoeScene)
        
        let sb = SwinjectStoryboard.create(name: "MainViewController",
                                           bundle: nil,
                                           container: swinjectContainer.container)
        
        let startVC = sb.instantiateViewController(withIdentifier: "MainNavigationController")
        
        self.window?.rootViewController = startVC
        
        self.window?.makeKeyAndVisible()
    }
}

