//
//  Category.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation


typealias CategorySource = TitleSource & SingleTitleSource & DescriptionSource & ShortDescriptionSource & SingleDescriptionSource & SingleShortDescriptionSource & ImageStorageSource & IdentificationSource & SlugSource & ShowOptionSource & DisplayTypeSource & CategoryPackageStorageSource & NewBadgeSource

/// Also known as services in UI, in the backend object named category
///
struct Category: Codable, CategorySource {
    
    let _id: String?
    let id: String?
    let slug: String?
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
    let data: [CategoryPackage]?
    
}

extension Category: Equatable {
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs._id == rhs._id
            && lhs.id == rhs.id
            && lhs.slug == rhs.slug
            && lhs.title == rhs.title
            && lhs.subTitle == rhs.subTitle
            && lhs.slogan == rhs.slogan
    }
}

extension Category: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine((_id ?? "") + (id ?? "") + (slug ?? ""))
        hasher.combine((title ?? "") + (subTitle ?? "") + (slogan ?? ""))
    }
}
