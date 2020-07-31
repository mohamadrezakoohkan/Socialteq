//
//  LocalizableProtocol.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

protocol LocalizableProtocol {
    func set(localizedString string: String)
}

extension UIButton: LocalizableProtocol {
    func set(localizedString string: String) {
        self.setTitle(string, for: .normal)
    }
}

extension UILabel: LocalizableProtocol {
    func set(localizedString string: String) {
        self.text = string
    }
}

extension UITextField: LocalizableProtocol {
        func set(localizedString string: String) {
            self.placeholder = string
    }
}

