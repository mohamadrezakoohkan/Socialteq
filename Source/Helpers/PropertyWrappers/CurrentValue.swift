//
//  CurrentValue.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
class CurrentValue<Value> {
    
    private lazy var subject = CurrentValueSubject<Value, Never>(wrappedValue)

    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    var projectedValue: AnyPublisher<Value, Never> {
        return subject.eraseToAnyPublisher()
    }
    
    var wrappedValue: Value {
        didSet {
            subject.send(self.wrappedValue)
        }
    }
}
