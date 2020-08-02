//
//  Domain.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

@frozen enum Domain: HTTPDomain {
    
    case google
    case appspot
    
    var value: String {
        switch self {
        case .google:
            return "https://google.com/"
        case .appspot:
            return Configuration.shared.baseURL
        }
    }
    
    var isSecure: Bool {
        return self.value.contains("https")
    }
    
}
