//
//  UniversalString.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

struct UniversalString: Codable, Multilingual {
    
    let en: String?
    let ar: String?
    
    var value: String? {
        return self.en
    }
}
