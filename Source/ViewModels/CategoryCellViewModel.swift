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
    
    let title: String?
    let subTitle: String?
    let shortDescription: String?
    let hasNewBadge: Bool?
    let imageURL: URL?

    init(category: Category) {
        self.init(title: category.title, subTitle: category.subTitle, shortDescription: category.shortDescription, hasNewBadge: category.hasNewBadge, imageURL: category.image?.imageURL)
    }
    
    init(title: String?, subTitle: String?, shortDescription: String?, hasNewBadge: Bool?, imageURL: URL?) {
        self.title = title
        self.subTitle = subTitle
        self.shortDescription = shortDescription
        self.hasNewBadge = hasNewBadge
        self.imageURL = imageURL
    }

    func transform(input: Input) -> Output { return Output() }

}

