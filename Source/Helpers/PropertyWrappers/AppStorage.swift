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
    
    init(key: String, defaultValue: Value) {
        self.key = "app.storage.\(key)"
        self.defaultValue = defaultValue
    }
    
    lazy var projectedValue: CurrentValueSubject<Value,Never> = {
        return .init(self.wrappedValue)
    }()

    
    var wrappedValue: Value {
        get {
            return (UserDefaults.standard.value(forKey: self.key) as? Value) ?? self.defaultValue
        }
        set {
             UserDefaults.standard.setValue(newValue, forKey: self.key)
        }
    }
    
}
