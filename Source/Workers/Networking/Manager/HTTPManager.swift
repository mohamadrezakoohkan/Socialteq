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
    
    fileprivate func handleError(data: Data?, response: URLResponse?) -> Result<Data,Error> {
        guard let httpResponse = response as? HTTPURLResponse,
            let responeData = data else {
                return .failure(HTTPError.invalidResponseData)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return .success(responeData)
        case 501...599:
            return .failure(HTTPError.badRequest)
        case 600:
            return .failure(HTTPError.outdated)
        default:
            return .failure(HTTPError.canceled)
        }
        
    }
}

extension HTTPManager: HomeProvider {
    
    func getHome(_ completion: @escaping HomeProviderResult) {
        
        self.router.request(route: .home) { (result) in
            switch result {
            case .success((let data, let response)):
                do {
                    let dataValue = try self.handleError(data: data, response: response).get()
                    let decoder = JSONDecoder()
                    let home = try decoder.decode(Home.self, from: dataValue)
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
                    let dataValue = try self.handleError(data: data, response: response).get()
                    let decoder = JSONDecoder()
                    let category = try decoder.decode(Category.self, from: dataValue)
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
