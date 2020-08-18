//
//  HTTPRouter.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

typealias HTTPRouterRequestResult = AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>

typealias HTTPRouterDownloadResult = AnyPublisher<(url: URL, response: URLResponse), Error>

protocol HTTPRouter: class {
    associatedtype EndpointType: HTTPEndpoint
    var timeout: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    func request(route: EndpointType) -> HTTPRouterRequestResult
    func download(url: URL) -> HTTPRouterDownloadResult
    func requestGenerator(fromRoute route: EndpointType) throws -> URLRequest
}

extension HTTPRouter {

    func requestGenerator(fromRoute route: EndpointType) -> URLRequest {
        var request = URLRequest(url: route.url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeout)
        request.httpMethod = route.method.rawValue
        return request
    }
}
