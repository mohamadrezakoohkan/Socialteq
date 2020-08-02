//
//  MockEndpoint.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
@testable import Socialteq

enum MockEndpoint: HTTPEndpoint {

    case sample
    case home
    case services(_ slug: String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var baseURL: MockDomain {
        return .appspot
    }
    
    var path: String {
        switch self {
        case .sample:
            return ""
        case .home:
            return "customer/" + "v2/" + "home/"
        case .services(let slug):
            return "customer/" + "v2/" + "categories/" + "\(slug)/" + "services/"
        }
    }
    
    var urlString: String {
        return self.baseURL.value + self.path
    }
    
    var url: URL {
        return URL(string: self.urlString)!
    }

    
    
}
