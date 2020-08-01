//
//  Number+Formatter.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

extension Formatter {
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = .comma
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var price: String {
        return (Formatter.priceFormatter.string(for: self) ?? .emptyString) + .space + .currency
    }
}

extension Double {
    var price: String {
        return (Formatter.priceFormatter.string(for: self) ?? .emptyString) + .space + .currency
    }
}
