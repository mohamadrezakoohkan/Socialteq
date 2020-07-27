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

    init(text: String, font: UIFont, image: UIImage?, selectedColor: UIColor, unselectedColor: UIColor, tag: Int, paddingInset: CGFloat, selected: Bool) {
        
        super.init(frame: .zero)
        self.text = text
        self.selectedTintColor = selectedColor
        self.unselectedTintColor = unselectedColor
        self.image = image
        self.paddingInset = paddingInset
        self.tag = tag
        self.titleLabel?.font = font
        selected ? self.select() : self.deselect()
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
    
    class func batchCreate(using tabbarController: TabBarController, padding: CGFloat) -> [TabBarButton] {
        guard let viewControllers = tabbarController.viewControllers else { return [] }
        return viewControllers.enumerated().map {
            return .init(text: $1.tabBarItem.title ?? "",
                         font: tabbarController.itemsFont,
                         image: $1.tabBarItem.image,
                         selectedColor: tabbarController.selectedColor,
                         unselectedColor: tabbarController.unselectedColor,
                         tag: $0,
                         paddingInset: padding,
                         selected: tabbarController.startedIndex == $0)
        }
    }
}

