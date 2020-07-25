//
//  Category.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

struct Category: Titled, Descriptioned, ImageSource, ShowOption {
    
        
    let titles: UniversalString?
    let subTitles: UniversalString?
    
    let title: String?
    let subTitle: String?
    
    let descriptions: UniversalString?
    let shortDescriptions: UniversalString?
    let slogans: UniversalString?
    
    let description: String?
    let shortDescription: String?
    let slogan: String?
    
    let image: Image?

    let isActive: Bool?
    let sort: Int?
    let hasNewBadge: Bool?
    let displayType: DisplayType?
    
}
