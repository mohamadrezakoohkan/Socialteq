//
//  TextField.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    @IBInspectable
    var placeholderColor: UIColor = UIColor.appGray {
        didSet {
            let attributes = [NSAttributedString.Key.foregroundColor: self.placeholderColor]
            let string = NSAttributedString(string: self.placeholder!,
            attributes: attributes)
            self.attributedPlaceholder = string
        }
    }
    
    override var placeholder: String? {
        didSet {
            
        }
    }
}
