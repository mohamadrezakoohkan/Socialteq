//
//  BadgeLabel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class BadgeLabel: UILabel {

    private let margin = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    private var cornerRadius: CGFloat {
        return self.frame.size.height/2
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.margin))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.setCornerRadius()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.masksToBounds = true
        self.setCornerRadius()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCornerRadius()
    }

    func setCornerRadius() {
        self.layer.cornerRadius = self.cornerRadius
    }
}
