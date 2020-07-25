//
//  LocalizableProtocol.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

protocol LocalizableProtocol {
    func set(localizationKey: String)
}

extension UIButton: LocalizableProtocol {
    func set(localizationKey key: String) {
        self.setTitle(key.localized, for: .normal)
    }
}

extension UILabel: LocalizableProtocol {
    func set(localizationKey key: String) {
        self.text = key.localized
    }
}

extension UITextField: LocalizableProtocol {
        func set(localizationKey key: String) {
            self.placeholder = key.localized
    }
}

