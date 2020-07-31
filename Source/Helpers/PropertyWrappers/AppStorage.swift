//
//  UserDefaultsStorage.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

/// Introduced in iOS 14 and SwiftUI 2, wrapper around `UserDefaults`
///
///
@propertyWrapper
struct AppStorage<Value> {
    
    private let key: String
    private let defaultValue: Value
    private var storage: UserDefaults {
       return UserDefaults.standard
    }
    
    init(key: String, defaultValue: Value) {
        self.key = "app.storage.\(key)"
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: Value {
        get { return self.storage.object(forKey: self.key) as? Value ?? self.defaultValue }
        set {
            if let optional = newValue as? AnyOptional,
                optional.isNil {
                self.storage.removeObject(forKey: self.key)
            } else {
                self.storage.set(newValue, forKey: self.key)
            }
        }
    }
}

extension AppStorage where Value: ExpressibleByNilLiteral {
    init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}
