//
//  Category.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

/// Also known as services in UI, in the backend object named category
///
struct Category: Codable, TitleSource, SingleTitleSource, DescriptionSource, SingleDescriptionSource, ImageStorageSource, IdentificationSource, SlugSource, ShowOptionSource, DisplayTypeSource, ServiceStorageSource {
    
    let _id: String?
    let slug: String?
    let id: String?
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
    let data: [Service]?
    
}

extension Category: Equatable {
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs._id == rhs._id
            && lhs.id == rhs.id
            && lhs.slug == rhs.slug
            && lhs.title == rhs.title
            && lhs.subTitle == rhs.subTitle
    }
}

extension Category: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine((_id ?? "") + (id ?? "") + (slug ?? ""))
    }
}
