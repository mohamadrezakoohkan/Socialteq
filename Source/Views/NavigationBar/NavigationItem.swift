//
//  NavigationItem.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class NavigationItem: UINavigationItem {
    
    override var title: String? {
        didSet {
            self.titleItem.title = self.title
        }
    }
    
    private lazy var titleItem: TitleBarButtonItem = {
        return .init(title: self.title)
    }()
    
    private var backItem: BackBarButtonItem!
    
    init(title: String, backAction: Selector) {
        super.init(title: title)
        self.createBackButton(action: backAction)
        self.setBackButton()
        self.removeDefaultTitle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createBackButton(action: nil)
        self.setBackButton()
        self.removeDefaultTitle()
    }
    
    private func createBackButton(action: Selector?) {
        self.backItem = .init(action: action)
    }

    private func setBackButton() {
        self.leftBarButtonItems = [self.backItem, self.titleItem]
    }
    
    private func removeDefaultTitle() {
        self.titleView = UIView()
    }
    

}
