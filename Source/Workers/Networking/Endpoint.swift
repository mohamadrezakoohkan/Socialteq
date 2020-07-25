//
//  Endpoint.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case customer
    case version2
    case home
    case categories
    case services(_ category: String)
    
    static var origin: String {
        Endpoint.customer.resolve + Endpoint.version2.resolve
    }
    
    var resolve: String {
        switch self {
        case .customer:
            return "customer/"
        case .version2:
            return "v2/"
        case .home:
            return Endpoint.origin + "home/"
        case .categories:
            return Endpoint.home.resolve  + "categories/"
        case .services(let category):
            return Endpoint.categories.resolve + "\(category)/" + "services/"
        }
    }
    
    func url(domain: Domain) -> URL {
        return URL(string: domain.rawValue + self.resolve)!
    }
}
