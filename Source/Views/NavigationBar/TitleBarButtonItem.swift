//
//  TitleBarButtonItem.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class TitleBarButtonItem: BarButtonItem {
    
    override var title: String? {
        didSet {
            self.setText(text: self.title)
        }
    }
    
    open var fontSize: CGFloat {
        return 18
    }
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = self.title
        lbl.textColor = self.color
        lbl.textAlignment = .left
        lbl.font = .semiBold(size: self.fontSize)
        return lbl
    }()
    
    init(title text: String?) {
        super.init()
        self.setTitle()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setTitle()
    }

    private func setTitle() {
        self.customView = self.titleLabel
    }
    
    private func setText(text: String?) {
        self.titleLabel.text = text
    }
}
