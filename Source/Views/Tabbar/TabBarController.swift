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
    
    open var itemsFont: UIFont {
        .semiBold()
    }
    
    open var startedIndex: Int {
        return self.selectedIndex
    }
    
    open var selectedColor: UIColor {
        self.tabBar.tintColor ?? .highlight
    }
    
    open var unselectedColor: UIColor {
        self.tabBar.unselectedItemTintColor ?? .secondary
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.tabbarView.deviceRotated(with: coordinator)
    }
    
    @objc func buttonSelected(_ sender: TabBarButton) {
        self.selectedIndex = sender.tag
        self.buttons.enumerated().forEach { index, btn in
            if index != self.selectedIndex {
                btn.setText(nil)
                    .setColor(self.unselectedColor)
            }else{
                btn.setText(self.viewControllers![index].tabBarItem.title)
                    .setColor(self.selectedColor)
            }
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    private func setupTabbar() {
        self.tabBar.isHidden = true
        guard self.viewControllers?.isEmpty == false, !self.didSetupedTabbar else { return }
        self.didSetupedTabbar = true
        self.addButtons()
        self.autolayoutSubviews()
    }
    
    private func addSubviews() {
        self.tabbarView.add(to: self.view)
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
        self.buttons = TabBarButton.batchCreate(using: self, padding: .zero)
        self.buttons.forEach { btn in
            btn.insert(into: self.itemsStackView)
            btn.addTarget(self, action: #selector(self.buttonSelected(_:)), for: .touchUpInside)
        }
        self.view.setNeedsLayout()
    }
    
    
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didBeginCustomizing items: [UITabBarItem]) {
        print("customizing")
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("S")
    }
}
