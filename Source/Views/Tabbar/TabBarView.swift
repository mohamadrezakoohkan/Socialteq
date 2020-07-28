//
//  TabBarView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIView

final class TabBarView: UIView {
    
    private let cornerRadius: CGFloat = 25
    private let corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    func add(to view: UITabBar) {
        self.frame = view.frame
        view.addSubview(self)
    }
    
    func setup() {
        self.backgroundColor = .appWhite
        self.clipsToBounds = true
        self.setShadow()
        self.setShape()
    }
    
    func autolayout(to view: UIView) {
        self.constraintFill(view: view)
    }
    
    private func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.08
        self.layer.shadowRadius = 20
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.layer.cornerRadius = self.cornerRadius
    }
    
    private func setShape() {
        self.layer.maskedCorners = self.corners
        self.layer.cornerRadius = self.cornerRadius
    }
}
