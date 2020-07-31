//
//  PromotionCellViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/10/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

struct PromotionCellViewModel: ViewModelType, ImageUrlResolver {
    
    struct Input { }
    struct Output { }
    
    private let urlString: String
    let imageURL: URL?
    
    init(promotion: Promotion) {
        self.init(urlString: promotion.image?.originalUrl ?? "")
    }
    
    init(urlString: String) {
        self.urlString = urlString
        self.imageURL = URL(string: urlString)
    }
    
    func transform(input: Input) -> Output { return Output() }

}
