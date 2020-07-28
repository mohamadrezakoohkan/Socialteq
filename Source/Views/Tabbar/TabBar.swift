//
//  TabBar.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class TabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeSeparator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.removeSeparator()
    }
    
    private func removeSeparator() {
        self.shadowImage = UIImage()
        self.backgroundImage = UIImage()
    }
    
}
