//
//  BackBarButtonItem.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class BackBarButtonItem: BarButtonItem {
    
    private let img: UIImage = .arrowLeft
    
    init(action: Selector?) {
        super.init()
        self.setAction(action: action)
        self.setImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setImage()
    }
    
    private func setAction(action: Selector?) {
        guard let action = action else { return }
        self.action = action
    }
    
    private func setImage() {
        self.image = self.img
    }
    
    private func setColor() {
        self.tintColor = self.color
    }

}



