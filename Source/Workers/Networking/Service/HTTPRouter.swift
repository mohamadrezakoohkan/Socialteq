//
//  HTTPRouter.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

typealias HTTPRouterCompletion = (Result<(Data?, URLResponse?), Error>) -> ()

protocol HTTPRouter: class {
    associatedtype EndpointType: HTTPEndpoint
    var timeout: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    func request(route: EndpointType, completion: @escaping HTTPRouterCompletion)
    func cancel()
    func requestGenerator(fromRoute route: EndpointType) throws -> URLRequest
}

extension HTTPRouter {
    
    func requestGenerator(fromRoute route: EndpointType) throws -> URLRequest {
        guard let url = URL(string: route.baseURL.rawValue + route.path) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeout)
        request.httpMethod = route.method.rawValue
        return request
    }
}

