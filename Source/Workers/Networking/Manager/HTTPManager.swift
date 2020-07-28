//
//  HTTPManager.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

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
}

extension HTTPManager: HomeProvider {
    
    func getHome(_ completion: @escaping HomeProviderResult) {
        
        self.router.request(route: .home) { (result) in
            switch result {
            case .success((let data, let response)):
                do {
                    let value = try self.handleError(data: data, response: response)
                    let decoder = JSONDecoder()
                    let home = try decoder.decode(Home.self, from: value)
                    completion(.success(home))
                }catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension HTTPManager: CategoryProvider {
    
    func getCategory(category: Category, _ completion: @escaping CategoryProviderResult) {
        
        guard let slug = category.slug else {
            completion(.failure(HTTPError.invalidParameteres))
            return
        }
        
        self.router.request(route: .services(slug)) { (result) in
            switch result {
            case .success((let data, let response)):
                do {
                    let value = try self.handleError(data: data, response: response)
                    let decoder = JSONDecoder()
                    let category = try decoder.decode(Category.self, from: value)
                    completion(.success(category))
                }catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
