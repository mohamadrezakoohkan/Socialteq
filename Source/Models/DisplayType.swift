//
//  DisplayType.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

enum DisplayType: String, Codable {
    
    case subServices
    case priceList
}

extension DisplayType: Equatable {
    
    static func == (lhs: DisplayType, rhs: DisplayType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension DisplayType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
