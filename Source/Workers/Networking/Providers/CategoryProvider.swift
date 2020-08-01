//
//  CategoryProvider.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/5/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

protocol CategoryProvider {
    func getCategory(slug: String) -> AnyPublisher<Category?, Error>
}
