//
//  Home.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias HomeSource = SingleTitleSource & CategoryStorageSource &  PromotionStorageSource
    
struct Home: Codable, HomeSource {
    
    let title: String?
    let subTitle: String?
    let categories: [Category]
    let promotions: [Promotion]
    
}

extension Home: Equatable {
    static func == (lhs: Home, rhs: Home) -> Bool {
        lhs.title == rhs.title
            && lhs.subTitle == rhs.subTitle
            && lhs.categories == rhs.categories
            && lhs.promotions == rhs.promotions
    }
    
}

extension Home: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine((title ?? "") + (subTitle ?? ""))
    }
}
