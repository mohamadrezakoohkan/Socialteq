//
//  EventCellViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

struct EventCellViewModel: ViewModelType, SingleTitleSource {
    
    struct Input { }
    struct Output { }
    
    let title: String?
    let subTitle: String?
    
    init(home: Home) {
        self.init(title: home.title, subTitle: home.subTitle)
    }
    
    init(title: String?, subTitle: String?) {
        self.title = title
        self.subTitle = subTitle
    }
    
    func transform(input: Input) -> Output { return Output() }

}
