//
//  TabBarBadge.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

// MARK - TODO: Create layout
//
final class TabBarBadge: UIView {
    
    private (set) var number: Int = 0 {
        didSet {
            self.isHidden = self.number == 0
        }
    }
    
    private let font: UIFont
    
    private (set) lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.font = self.font.withSize(12)
        lbl.textAlignment = .center
        lbl.textColor = .appWhite
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private (set) lazy var badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .appRed
        return view
    }()
    
    
    init(font: UIFont) {
        self.font = font
        super.init(frame: .zero)
        self.setup()
        self.autolayout()
        self.update()
    }
    
    required init?(coder: NSCoder) {
        self.font = .bold()
        super.init(coder: coder)
        self.setup()
        self.autolayout()
        self.update()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.update()
    }
    
    func setNumber(_ num: Int) {
        self.number = num
    }
    
    func increaseNumber() {
        self.number += 1
    }
    
    private func setup() {
        self.isHidden = true
        self.addSubview(self.badgeView)
        self.badgeView.addSubview(self.label)
        self.backgroundColor = .appWhite
    }
    
    private func update() {
        self.layer.cornerRadius = self.frame.size.height/2
    }
    
    private func autolayout() {
        self.badgeView.constraintFill(view: self, edgesPadding: 6)
        self.label.constraintFill(view: self.badgeView)
    }
    
}
