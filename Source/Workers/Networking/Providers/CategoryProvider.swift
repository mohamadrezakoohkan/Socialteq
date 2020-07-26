//
//  CategoryProvider.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/5/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias CategoryProviderResult = (Result<Category, Error>) -> Void

protocol CategoryProvider {
    func getCategory(category: Category,_ completion: @escaping CategoryProviderResult)
}
