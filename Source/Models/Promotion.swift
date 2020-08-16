//
//  Promotion.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias PromotionSource = ImageStorageSource

struct Promotion: Codable, PromotionSource {
    let image: Image?
}

extension Promotion: Equatable {
    static func == (lhs: Promotion, rhs: Promotion) -> Bool {
        lhs.image == rhs.image
    }
}

extension Promotion: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
}
