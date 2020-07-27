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
    
    override var itemsFont: UIFont {
        .semiBold(size: 14)
    }
    
    override var startedIndex: Int {
        return 0
    }
    
    override var selectedColor: UIColor {
        .highlight
    }
    
    override var unselectedColor: UIColor {
       .secondary
    }
    

}
