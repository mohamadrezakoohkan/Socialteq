//
//  TabBarStackView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIStackView

final class TabBarStackView: UIStackView {

    private let leadingPadding: CGFloat = 15
    private let trailingPadding: CGFloat = -15
    private let height: CGFloat = 50

    func add(to view: TabBarView) {
        view.addSubview(self)
    }

    func setup() {
        self.alignment = .center
        self.distribution = .fillProportionally
        self.axis = .horizontal
    }

    func autolayout(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: self.leadingPadding).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: self.trailingPadding).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.height).isActive = true
    }
}
