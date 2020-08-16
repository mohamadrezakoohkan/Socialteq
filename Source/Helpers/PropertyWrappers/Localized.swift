//
//  Localized.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

/// Localize  assosiated interface  (`LocalizableProtocol`)  with given key
///
///
@propertyWrapper
struct Localized<Value: LocalizableProtocol> {

    private let string: String

    init(localizedString string: String) {
        self.string = string
    }
    var wrappedValue: Value? = nil {
        didSet {
            self.wrappedValue?.set(localizedString: self.string)
        }
    }
}
