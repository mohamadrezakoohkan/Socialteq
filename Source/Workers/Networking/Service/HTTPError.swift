//
//  HTTPError.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

enum HTTPError: String, Error {
    
    case canceled = "Network request canceled."
    case outdated = "The url you requested is outdated."
    case badRequest = "Bad request"
    case notReachable = "Given url is not reachable"
    case invalidURL = "Give url for request is invalid"
    case invalidParameteres = "Given parameter is invalid"
    case invalidResponseData = "Received response is nil"
    case invalidDecodable = "Received response is diffrent from give decodable object"
}
