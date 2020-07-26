//
//  PriceSource.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

protocol PriceSource {
    var isSpecial: Bool? { get }
    var hasDiscount: Bool? { get }
    var discountPercentage: Double? { get }
    var basePrice: Double? { get }
    var listBasePrice: Double? { get }
}
