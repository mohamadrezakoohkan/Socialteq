//
//  Localized.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

@propertyWrapper
struct Localized<Value: LocalizableProtocol> {
    
    private let key: String
    
    init(_ key: String) {
        self.key = key
    }
    
    var wrappedValue: Value? = nil {
        didSet {
            self.wrappedValue?.set(localizationKey: key)
        }
    }
}
