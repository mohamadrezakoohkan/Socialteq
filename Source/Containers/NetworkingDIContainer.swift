//
//  NetworkingDIContainer.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/5/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

final class NetworkingDIContainer: DIContainerProtocol {

    private init() { }

    static let shared = NetworkingDIContainer()

    func resolve<T>() -> T {
        if T.self == HomeProvider.self {
            return self.resolve(manager: .init())
        } else if T.self == CategoryProvider.self {
            return self.resolve(manager: .init())
        } else if T.self == HTTPManager.self {
            return self.resolve(manager: .init())
        } else if T.self == ImageProvider.self {
            return self.resolve(manager: .init())
        } else {
            fatalError("\(String(describing: Self.self)) could not resolve: \(String(describing: T.self))")
        }
    }

    func resolve<T>(manager: HTTPManager) -> T {
        guard let manager = manager as? T else {
            fatalError("Could not resolve manager")
        }
        return manager
    }
}
