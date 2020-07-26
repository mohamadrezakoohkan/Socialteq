//
//  DIContainer.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

final class DIContainer: DIContainerProtocol {
    
    private init() { }
    
    static let shared = DIContainer()
    
    func resolve<T>() -> T {
        if T.self == User.self {
            return User() as! T
        }else{
            fatalError("Container could not resolve: \(String(describing: T.self))")
        }
    }
}

