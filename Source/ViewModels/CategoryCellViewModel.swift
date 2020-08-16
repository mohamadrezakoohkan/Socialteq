//
//  CategoryCellViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/10/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

typealias CategoryCellViewModelSource = SingleTitleSource & SingleShortDescriptionSource & NewBadgeSource & ImageUrlResolver

struct CategoryCellViewModel: ViewModelType, CategoryCellViewModelSource {

    struct Input { }
    struct Output { }

    let category: Category?
    let title: String?
    let subTitle: String?
    let shortDescription: String?
    let hasNewBadge: Bool?
    let badgeText: String
    let imageURL: URL?

    var isNewBadgeVisible: Bool {
        return self.hasNewBadge == true
    }

    init(category: Category) {
        self.init(
            title: category.title,
            subTitle: category.subTitle,
            shortDescription: category.shortDescription,
            hasNewBadge: category.hasNewBadge,
            imageURL: category.image?.imageURL,
            category: category)
    }

    init(title: String?,
         subTitle: String?,
         shortDescription: String?,
         hasNewBadge: Bool?,
         imageURL: URL?,
         badgeText: String = .new,
         category: Category? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.shortDescription = shortDescription
        self.hasNewBadge = hasNewBadge
        self.imageURL = imageURL
        self.category = category
        self.badgeText = badgeText
    }

    func transform(input: Input) -> Output {
        return Output()
    }
}

extension CategoryCellViewModel: Equatable {
    static func == (lhs: CategoryCellViewModel, rhs: CategoryCellViewModel) -> Bool {
        return lhs.title == rhs.title
            && lhs.subTitle == rhs.subTitle
            && lhs.shortDescription == rhs.shortDescription
            && lhs.hasNewBadge == rhs.hasNewBadge
            && lhs.imageURL == rhs.imageURL
    }
}

extension CategoryCellViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine((title ??  "") + (subTitle ?? ""))
        hasher.combine(shortDescription)
        hasher.combine(hasNewBadge)
        hasher.combine(imageURL)
    }
}
