//
//  MainTabBarController.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

@IBDesignable
final class MainTabBarController: TabBarController, Storyboarded {

    weak var home: HomeCoordinator?
    weak var categories: CategoriesCoordinator?
    weak var profile: ProfileCoordinator?
    weak var help: HelpCoordinator?

    override var itemsFont: UIFont {
        return .semiBold(size: 14)
    }

    override var startedIndex: Int {
        return .firstIndex
    }

    override var selectedColor: UIColor {
        return .appHighlight
    }

    override var unselectedColor: UIColor {
       return .appSecondary
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewControllers()
        self.startCoordinators()
    }

    private func addViewControllers() {
        self.viewControllers = [
            self.home!.navigationController,
            self.categories!.navigationController,
            self.profile!.navigationController,
            self.help!.navigationController
        ]
    }

    private func startCoordinators() {
        self.home!.start()
        self.categories!.start()
        self.profile!.start()
        self.help!.start()
    }
}
