//
//  EventCellViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias EventCellViewModelSource = SingleTitleSource & ImageUrlResolver

struct EventCellViewModel: ViewModelType, EventCellViewModelSource {
    
    struct Input { }
    struct Output { }
    
    let imageURL: URL?
    let title: String?
    let subTitle: String?
    
   var isImageVisible: Bool {
        return self.imageURL != nil
    }
    
    init(home: Home) {
        self.init(title: home.title, subTitle: home.subTitle, imageURL: nil)
    }
    
    init(category: Category) {
        let img = URL(string: category.image?.originalUrl4x ?? "") ?? category.image?.imageURL
        self.init(title: category.slogan ?? category.subTitle ?? category.title, subTitle: category.description, imageURL: img)
    }
    
    init(title: String?, subTitle: String?, imageURL: URL?) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
    
    func transform(input: Input) -> Output { return Output() }

}

extension EventCellViewModel: Equatable {
    static func == (lhs: EventCellViewModel, rhs: EventCellViewModel) -> Bool {
        return lhs.title == rhs.title
            && lhs.subTitle == rhs.subTitle
    }
}

extension EventCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine((title ??  "") + (subTitle ?? ""))
    }
}
