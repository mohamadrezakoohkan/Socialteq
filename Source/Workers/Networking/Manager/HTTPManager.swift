//
//  HTTPManager.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

struct HTTPManager {
    
    static let environment: HTTPEnvironment = .production
    fileprivate let router: Router<Endpoint> = .init()
    
    
    fileprivate func handleError(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
            let responeData = data else {
                throw HTTPError.invalidResponseData
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return responeData
        case 403:
            throw HTTPError.badRequest
        case 404:
            throw HTTPError.notFound
        case 501...599:
            throw HTTPError.serverError
        case 600:
            throw HTTPError.outdated
        default:
            throw HTTPError.canceled
        }
        
    }
    
    fileprivate func handlePublishError(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        try self.handleError(data: output.data, response: output.response)
    }
}

extension HTTPManager: HomeProvider {
    
    func getHome() -> AnyPublisher<Home?, Error> {
        return self.router.request(route: .home)
            .tryMap { try self.handlePublishError(output: $0) }
            .decode(type: Home?.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

extension HTTPManager: CategoryProvider {
    
    func getCategory(slug: String) -> AnyPublisher<Category, Error> {
        return self.router.request(route: .services(slug))
            .tryMap { try self.handlePublishError(output: $0) }
            .decode(type: Category.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
}
