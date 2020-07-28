//
//  String+Localized.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

extension String {
    
    static let guest: String = "guest"
    static let home: String = "home"
    static let categories: String = "categories"
    static let profile: String = "profile"
    static let help: String = "help"

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

}
