//
//  HomeProvider.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/5/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

protocol HomeProvider {
    func getHome() -> AnyPublisher<Home?, Error>
}
