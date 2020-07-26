//
//  Domain.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

enum Domain: String {
    
    case google = "https://google.com/"
    case appspot = "https://api-dot-rafiji-staging.appspot.com/"
    
    var isSecure: Bool {
        return self.rawValue.contains("https")
    }
    
}
