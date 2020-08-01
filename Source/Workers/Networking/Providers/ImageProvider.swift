//
//  ImageProvider.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/10/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Combine
import Foundation

protocol ImageProvider {
    func getImage(url: URL) -> AnyPublisher<String, Error>
}
