//
//  Service.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

/// Also known as packages in UI, in the backend object named service
///
struct CategoryPackage: Codable, TitleSource, SingleTitleSource, DescriptionSource, SingleDescriptionSource, SubCategorySource, ShowOptionSource, PriceSource, CoverImageStorageSource {
    
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
    let categoryId: String?
    let isActive: Bool?
    let sort: Int?
    let hasNewBadge: Bool?
    let isSpecial: Bool?
    let hasDiscount: Bool?
    let discountPercentage: Double?
    let basePrice: Double?
    let listBasePrice: Double?
    let coverImageId: String?
    let coverImage: CoverImage?
    
    
}
