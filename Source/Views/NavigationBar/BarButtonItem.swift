//
//  BarButtonItem.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIBarButtonItem

class BarButtonItem: UIBarButtonItem {
    
    open var color: UIColor = .appBlack
    
    override init() {
        super.init()
        self.setColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setColor()
    }
    
    private func setColor() {
        self.tintColor = self.color
    }
}
