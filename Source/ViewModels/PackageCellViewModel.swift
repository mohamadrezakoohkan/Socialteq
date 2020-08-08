//
//  PackageCellViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

typealias PackageCellViewModelSource = ImageUrlResolver

struct PackageCellViewModel: ViewModelType, PackageCellViewModelSource  {
    
    struct Input { }
    struct Output { }
    
    let package: Package?
    let title: String?
    let subTitle: String?
    let shortDescription: String?
    let hasDiscount: Bool?
    let basePrice: Double?
    let discountPercentage: Double?
    let isSpecial: Bool?
    let imageURL: URL?
    
    var isDiscountBadgeVisible: Bool {
        return self.hasDiscount == true
    }
    
    var discountText: String {
        return String(self.discountPercentage ?? 0) + .space + .percentage
    }
    
    var priceText: String {
        return self.basePrice?.price ?? .free
    }
    
    var special: Bool {
        return self.isSpecial == true
    }
    
    init(package: Package) {
        self.init(title: package.title, subTitle: package.subTitle, shortDescription: package.shortDescription, hasDiscount: package.hasDiscount, basePrice: package.basePrice, discountPercentage: package.discountPercentage, isSpecial: package.isSpecial, imageURL: package.image?.imageURL, package: package)
    }
    
    init(title: String?, subTitle: String?, shortDescription: String?, hasDiscount: Bool?, basePrice: Double?, discountPercentage: Double?, isSpecial: Bool?, imageURL: URL?, badgeText: String = .new, package: Package? = nil) {
        self.package = package
        self.title = title
        self.subTitle = subTitle
        self.shortDescription = shortDescription
        self.hasDiscount = hasDiscount
        self.basePrice = basePrice
        self.discountPercentage = discountPercentage
        self.isSpecial = isSpecial
        self.imageURL = imageURL
    }

    func transform(input: Input) -> Output { return Output() }

}

extension PackageCellViewModel: Equatable {
    static func == (lhs: PackageCellViewModel, rhs: PackageCellViewModel) -> Bool {
        lhs.imageURL == rhs.imageURL
    }
}

extension PackageCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageURL)
    }
}

