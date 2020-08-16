//
//  Injected.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

@propertyWrapper
struct Injected<Value> {

    var value: Value

    init(container: DIContainerProtocol) {
        self.value = container.resolve()
    }

    var wrappedValue: Value {
        return self.value
    }
}
