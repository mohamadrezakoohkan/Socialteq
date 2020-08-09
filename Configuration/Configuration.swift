//
//  Configuration.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

class Configuration {
    
    private init() { }
    static let shared = Configuration()
    
    private let info: [String: Any] = Bundle.main.infoDictionary ?? [:]
    
    @available(*, deprecated, message: "Please use github repository instead because this url is not stable")
    var baseURL: String {
        return self.info["APIBaseURL"] as! String
    }
    
    var githubRepository: String {
        return self.info["GitHub Repository"] as! String
    }
    
}
