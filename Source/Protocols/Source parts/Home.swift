//
//  Home.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

struct Home: Codable, SingleTitleSource, CategoryStorageSource, PromotionStorageSource {
    
    let title: String?
    let subTitle: String?
    let categories: [Category]
    let promotions: [Promotion]
    
}
