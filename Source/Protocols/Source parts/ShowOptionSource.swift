//
//  ShowOption.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

protocol ShowOptionSource {
    var isActive: Bool? { get }
    var sort: Int? { get }
    var hasNewBadge: Bool? { get }
}
