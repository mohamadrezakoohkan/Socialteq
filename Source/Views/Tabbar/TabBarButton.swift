//
//  TabBarButton.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIButton

final class TabBarButton: UIButton {
    
    private (set) var selectedTintColor: UIColor = .clear
    private (set) var unselectedTintColor: UIColor = .clear
    private (set) var text: String = ""
    
    private (set) lazy var badge: TabBarBadge = {
        return.init(font: self.titleLabel?.font ?? .bold())
    }()
    
    private var image: UIImage? {
        get { self.imageView?.image }
        set { self.setImage(newValue, for: .normal) }
    }
    
    private var title: String? {
        get { return self.titleLabel?.text }
        set { self.setTitle("  " + (newValue ?? ""), for: .normal) }
    }
    
    private var color: UIColor {
        get { return self.tintColor }
        set {
            self.setTitleColor(newValue, for: .normal)
            self.tintColor = newValue
        }
    }
    
    private var paddingInset: CGFloat {
        get { return self.titleEdgeInsets.left }
        set {
            self.titleEdgeInsets = .init(top: 4, left: newValue, bottom: 0, right: newValue)
            self.imageEdgeInsets = .init(top: 0, left: newValue * -1, bottom: 0, right: newValue * -1)
        }
    }

    init(text: String, font: UIFont, image: UIImage?, selectedColor: UIColor, unselectedColor: UIColor, tag: Int, paddingInset: CGFloat, selected: Bool, createBadge: Bool) {
        
        super.init(frame: .zero)
        self.text = text
        self.selectedTintColor = selectedColor
        self.unselectedTintColor = unselectedColor
        self.image = image
        self.paddingInset = paddingInset
        self.tag = tag
        self.titleLabel?.font = font
        selected ? self.select() : self.deselect()
        if createBadge { self.addBadge() }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @discardableResult
    func setColor(_ aColor: UIColor) -> TabBarButton {
        self.color = aColor
        return self
    }
    
    @discardableResult
    func setText(_ text: String?) -> TabBarButton {
        self.title = text
        return self
    }
    
    func deselect() {
        self.setText(nil)
            .setColor(self.unselectedTintColor)
    }

    func select() {
        self.setText(self.text)
            .setColor(self.selectedTintColor)
    }
    
    func insert(into stackView: TabBarStackView) {
        stackView.addArrangedSubview(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func addBadge() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.addSubview(self.badge)
            self.badge.setNumber(2)
            self.badge.translatesAutoresizingMaskIntoConstraints = false
            self.badge.topAnchor.constraint(equalTo: self.imageView!.topAnchor).isActive = true
            self.badge.trailingAnchor.constraint(equalTo: self.imageView!.trailingAnchor).isActive = true
            self.badge.heightAnchor.constraint(equalToConstant: 3).isActive = true
            self.badge.widthAnchor.constraint(equalToConstant: 3).isActive = true
        })
    }
    
    class func batchCreate(using tabbarController: TabBarController,
                           badgeIndexes: Set<Int> = [],
                           padding: CGFloat = .zero) -> [TabBarButton] {
        
        guard let viewControllers = tabbarController.viewControllers else { return [] }
        return viewControllers.enumerated().map {
            return .init(text: $1.tabBarItem.title ?? "",
                         font: tabbarController.itemsFont,
                         image: $1.tabBarItem.image,
                         selectedColor: tabbarController.selectedColor,
                         unselectedColor: tabbarController.unselectedColor,
                         tag: $0,
                         paddingInset: padding,
                         selected: tabbarController.startedIndex == $0,
                         createBadge: badgeIndexes.contains($0))
        }
    }
}

