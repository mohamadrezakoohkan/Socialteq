//
//  Combine+Extensions.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/10/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

extension Publisher where Output == String? {

    func replaceNilOrEmpty(with string: String) -> AnyPublisher<Output, Failure> {
        self.map { $0 == "" || ($0 as AnyOptional).isNil == true ? string : $0 }
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == String {
    
    func optional() -> AnyPublisher<Output?, Failure> {
        self.map { ($0 as String?) }
            .eraseToAnyPublisher()
    }
}

extension Publisher where Failure == Never {

    func weakAssign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
        self.sink { [weak root] in
            root?[keyPath: keyPath] = $0
        }
    }
}
