//
//  TabBarController.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UITabBarController

class TabBarController: UITabBarController {

    private lazy var tabbarView: TabBarView = .init()
    private lazy var itemsStackView: TabBarStackView = .init()
    private var buttons = [TabBarButton]()
    private var didSetupedTabbar: Bool = false
    private let animationDuration: TimeInterval = 0.4
    private let animationVelocity: CGFloat = 0.9

    open var itemsFont: UIFont {
        .semiBold()
    }

    open var startedIndex: Int {
        return self.selectedIndex
    }

    open var selectedColor: UIColor {
        self.tabBar.tintColor ?? .appHighlight
    }

    open var unselectedColor: UIColor {
        self.tabBar.unselectedItemTintColor ?? .appSecondary
    }

    override var viewControllers: [UIViewController]? {
        didSet {
            self.setupTabbar()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setupSubviews()
        self.setupTabbar()
    }

    @objc func buttonSelected(_ sender: TabBarButton) {
        self.changeIndex(selected: sender.tag)
        self.updateButtons(selected: sender.tag)
        self.animateOnTap()
    }

    private func updateButtons(selected selectedIndex: Int) {
        self.buttons.enumerated().forEach { index, btn in
            _ = index != selectedIndex
                ? btn.setText(nil)
                    .setColor(self.unselectedColor)
                : btn.setText(self.viewControllers![index].tabBarItem.title)
                    .setColor(self.selectedColor)
        }
    }

    private func changeIndex(selected selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        self.view.layoutIfNeeded()
    }

    private func animateOnTap() {
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
    }

    private func setupTabbar() {
        self.tabBar.subviews.filter { $0 as? TabBarView == nil }.forEach { $0.alpha = 0 }
        guard self.viewControllers?.isEmpty == false, !self.didSetupedTabbar else { return }
        self.didSetupedTabbar = true
        self.addButtons()
        self.autolayoutSubviews()
    }

    private func addSubviews() {
        self.tabbarView.add(to: self.tabBar)
        self.itemsStackView.add(to: self.tabbarView)
    }

    private func setupSubviews() {
        self.tabbarView.setup()
        self.itemsStackView.setup()
    }

    private func autolayoutSubviews() {
        self.tabbarView.autolayout(to: self.tabBar)
        self.itemsStackView.autolayout(to: self.tabbarView)
    }

    private func addButtons() {
        self.buttons = TabBarButton.batchCreate(using: self, badgeIndexes: [1])
        self.buttons.forEach { btn in
            btn.insert(into: self.itemsStackView)
            btn.addTarget(self, action: #selector(self.buttonSelected(_:)), for: .touchUpInside)
        }
        self.view.setNeedsLayout()
    }
}
