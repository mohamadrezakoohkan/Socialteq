//
//  Router.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

final class Router<EndpointType: HTTPEndpoint>: HTTPRouter {
    
    private var task: URLSessionTask?
    unowned let session: URLSession
    
    let timeout: TimeInterval
    let cachePolicy: URLRequest.CachePolicy
    
    init(session: URLSession = URLSession.shared,
         cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad,
         timeout: TimeInterval = 30) {
        
        self.session = session
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
    
    func request(route: EndpointType, completion: @escaping HTTPRouterCompletion) {
        do {
            let request = try self.requestGenerator(fromRoute: route)
            self.task = self.session.dataTask(with: request) { data, response, error in
                if let err = error {
                    DispatchQueue.main.async {
                        completion(.failure(err))
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(.success((data, response)))
                    }
                }
            }
        }catch{
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
}
