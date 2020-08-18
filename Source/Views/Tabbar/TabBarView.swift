//
//  TabBarView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIView

final class TabBarView: RoundedView {

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

    private func setShape() {
        self.cornerRadius = 25
        self.topLeft = true
        self.topRight = true
    }
}
