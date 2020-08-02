//
//  HTTPEndpoint.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

protocol HTTPEndpoint {
    
    associatedtype DomainType: HTTPDomain
    
    var baseURL: DomainType { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var urlString: String { get }
    var url: URL { get }
}
