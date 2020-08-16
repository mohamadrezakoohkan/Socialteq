//
//  CategoriesCoordinator.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class CategoriesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = CategoriesViewController.instantiate(in: .main)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
}
