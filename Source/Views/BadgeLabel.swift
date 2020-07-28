//
//  BadgeLabel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class BadgeLabel: UILabel {
    
    private let cornerRadius: CGFloat = 10
    private let margin = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    override func drawText(in rect: CGRect) {
        rect.inset(by: self.margin)
        super.drawText(in: rect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
    }
}
