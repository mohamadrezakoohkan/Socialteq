//
//  DescriptionSource.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

protocol DescriptionSource {
    var descriptions: UniversalString? { get }
    var shortDescriptions: UniversalString? { get }
    var slogans: UniversalString? { get }
}

typealias Descriptioned = DescriptionSource & SingleDescriptionSource
