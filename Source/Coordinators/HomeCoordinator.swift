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
        let vc = HomeVC.instantiate(in: .main)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func show(category: Category) {
        let vc = CategoryVC.instantiate(in: .main)
        vc.coordinator = self
        vc.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func test() {
        let child = MainCoordinator(navigationController: self.navigationController)
        child.start()
    }
    
}
