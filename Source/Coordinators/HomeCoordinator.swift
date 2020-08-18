//
//  HomeCoordinator.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator, CategoryViewing {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = HomeViewController.instantiate(in: .main)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: false)
    }

    func show(category: Category) {
        let viewController = CategoryViewController.instantiate(in: .main)
        viewController.coordinator = self
        viewController.viewModel = .init(category: category)
        viewController.title = category.title
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
