//
//  MainTabBarController.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

@IBDesignable
final class MainTabBarController: TabBarController {
    
    /// we need a strong refrence here
    let home: HomeCoordinator = createCoordinator(title: .home, image: .home)
    let categories: CategoriesCoordinator = createCoordinator(title: .categories, image: .request)
    let profile: ProfileCoordinator = createCoordinator(title: .profile, image: .user)
    let help: HelpCoordinator = createCoordinator(title: .help, image: .helpCircle)

    override var itemsFont: UIFont {
        return .semiBold(size: 14)
    }
    
    override var startedIndex: Int {
        return 0
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
            self.home.navigationController,
            self.categories.navigationController,
            self.profile.navigationController,
            self.help.navigationController
        ]
    }
    
    private func startCoordinators() {
        self.home.start()
        self.categories.start()
        self.profile.start()
        self.help.start()
    }
    
    private class func createCoordinator<T: Coordinator>(title: String, image: UIImage) -> T {
        let navigation = MainNavigationController(title: title.localized, image: image)
        let coordinator = T.init(navigationController: navigation)
        return coordinator
    }

}
