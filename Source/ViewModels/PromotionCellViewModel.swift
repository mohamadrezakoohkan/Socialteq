//
//  PromotionCellViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/10/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

typealias PromotionCellViewModelSource = ImageUrlResolver

struct PromotionCellViewModel: ViewModelType, PromotionCellViewModelSource  {
    
    struct Input { }
    
    struct Output { }
    
    let promotion: Promotion?
    let imageURL: URL?
    
    init(promotion: Promotion) {
        self.init(urlString: promotion.image?.originalUrl ?? "", promotion: promotion)
    }
    
    init(urlString: String, promotion: Promotion?) {
        self.imageURL = URL(string: urlString)
        self.promotion = promotion
    }

    func transform(input: Input) -> Output { return Output() }

}

extension PromotionCellViewModel: Equatable {
    static func == (lhs: PromotionCellViewModel, rhs: PromotionCellViewModel) -> Bool {
        lhs.imageURL == rhs.imageURL
    }
}

extension PromotionCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageURL)
    }
}

