//
//  TitleSource.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias TitleSources = TitleSource & SingleTitleSource

protocol TitleSource {
    var titles: UniversalString? { get }
    var subTitles: UniversalString? { get }
}

protocol SingleTitleSource {
    var title: String? { get }
    var subTitle: String? { get }
}
