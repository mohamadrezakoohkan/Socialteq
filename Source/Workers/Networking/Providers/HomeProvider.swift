//
//  HomeProvider.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/5/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias HomeProviderResult = (Result<Home, Error>) -> Void

protocol HomeProvider {
    func getHome(_ completion: @escaping HomeProviderResult)
}
