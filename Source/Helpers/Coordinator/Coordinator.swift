//
//  Coordinator.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

public protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }

    init(navigationController: UINavigationController)

    func start()
}
