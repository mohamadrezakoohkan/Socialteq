//
//  NavigationBar.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    open var title: String? = nil {
        didSet {
            self.item.title = self.title
        }
    }
    
    private lazy var item: NavigationItem = {
        return .init(title: self.title ?? .emptyString, backAction: #selector(self.pop))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setClear()
        self.setBackButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setClear()
        self.setBackButton()
    }
    
    private func setBackButton() {
        self.setItems([self.item], animated: true)
    }
    
    private func setClear() {
        self.setBackgroundImage(.clear, for: UIBarMetrics.default)
        self.shadowImage = .clear
        self.isTranslucent = true
        self.backgroundColor = .clear
    }
    
    @objc private func pop() {
        sequence(first: self) { $0.next }
            .first(where: { $0 is UIViewController })
            .flatMap { $0 as? NavigationViewController }?
            .pop()
    }
    
}

