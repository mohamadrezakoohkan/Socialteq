//
//  Service.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias CategoryPackageSource = TitleSource & SingleTitleSource & DescriptionSource & ShortDescriptionSource & SingleDescriptionSource & SingleShortDescriptionSource & SubCategorySource & ShowOptionSource & PriceSource & CoverImageStorageSource

/// Also known as packages in UI, in the backend object named service
///
struct CategoryPackage: Codable, CategoryPackageSource {
    
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
    let isSpecial: Bool?
    let hasDiscount: Bool?
    let discountPercentage: Double?
    let basePrice: Double?
    let listBasePrice: Double?
    let coverImageId: String?
    let coverImage: CoverImage?
    
    
}

extension CategoryPackage: Equatable {
    
    static func == (lhs: CategoryPackage, rhs: CategoryPackage) -> Bool {
        lhs.titles == rhs.titles
            && lhs.subTitles == rhs.subTitles
            && lhs.title == rhs.title
            && lhs.subTitle == rhs.subTitle
            && lhs.slogan == rhs.slogan
            && lhs.categoryId == rhs.categoryId
            && lhs.shortDescription == rhs.shortDescription
    }
}

extension CategoryPackage: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine((title ?? "") + (slogan ?? ""))
        hasher.combine((categoryId ?? "") + (shortDescription ?? ""))
    }
}
