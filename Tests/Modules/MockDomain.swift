//
//  MockDomain.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

enum MockDomain: HTTPDomain {
    
    case appspot
    
    var value: String {
        return "https://api-dot-rafiji-staging.appspot.com/"
    }
    
    var isSecure: Bool {
        return self.value.contains("https://")
    }
    
    
}
