//
//  MainCoordinator.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }

    func start() {
        let tabbarController = MainTabBarController.instantiate(in: .main)
        tabbarController.home = self.coordinator(title: .home, image: .home)
        tabbarController.categories = self.coordinator(title: .categories, image: .request)
        tabbarController.profile = self.coordinator(title: .profile, image: .user)
        tabbarController.help = self.coordinator(title: .help, image: .helpCircle)
        self.navigationController.pushViewController(tabbarController, animated: false)
    }

    private func coordinator<CoordinatorType: Coordinator>(title: String, image: UIImage) -> CoordinatorType {
        let navigation = MainNavigationController(title: title.localized, image: image)
        let coordinator = CoordinatorType(navigationController: navigation)
        self.childCoordinators.append(coordinator)
        return coordinator
    }
}
