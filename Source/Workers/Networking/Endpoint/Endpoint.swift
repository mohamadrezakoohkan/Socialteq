//
//  Endpoint.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

enum Endpoint: HTTPEndpoint {
    
    case goolgeIndex
    case customer
    case version2
    case home
    case categories
    case services(_ category: String)
    
    var baseURL: Domain {
        switch self {
        case .goolgeIndex:
            return .google
        default:
            return .appspot
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .goolgeIndex:
            return .head
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var path: String {
        switch self {
        case .goolgeIndex:
            return ""
        case .customer:
            return "customer/"
        case .version2:
            return "v2/"
        case .home:
            return Endpoint.customer.path + Endpoint.version2.path + "home/"
        case .categories:
            return Endpoint.customer.path + Endpoint.version2.path + "categories/"
        case .services(let category):
            return Endpoint.categories.path + "\(category)/" + "services/"
        }
    }
    
    var urlString: String {
        return self.baseURL.value + self.path
    }

    var url: URL {
        return URL(string: self.urlString)!
    }
}
