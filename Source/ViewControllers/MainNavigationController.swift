//
//  MainNavigationController.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class MainNavigationController: UINavigationController {
    
    convenience init(title: String, image: UIImage) {
        self.init()
        self.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup() {
        self.hidesBottomBarWhenPushed = true
        self.navigationBar.isHidden = true
    }
}
