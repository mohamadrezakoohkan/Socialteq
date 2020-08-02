//
//  SceneDelegate.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var coordinator: MainCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigation = UINavigationController()
        self.window?.rootViewController = nil
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        self.coordinator = MainCoordinator(navigationController: navigation)
        self.coordinator.start()
    }


}

