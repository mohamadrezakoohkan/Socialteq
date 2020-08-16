//
//  DescriptionSource.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias DescriptionSources = DescriptionSource & SingleDescriptionSource
typealias ShortDescriptionSources = ShortDescriptionSource & SingleShortDescriptionSource

protocol DescriptionSource {
    var descriptions: UniversalString? { get }
    var slogans: UniversalString? { get }
}

protocol ShortDescriptionSource {
    var shortDescriptions: UniversalString? { get }
}

protocol SingleDescriptionSource {
    var description: String? { get }
    var slogan: String? { get }
}

protocol SingleShortDescriptionSource {
    var shortDescription: String? { get }
}
