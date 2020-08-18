//
//  Domain.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

@frozen enum Domain: HTTPDomain {
    case google
    case appspot
    case github

    var value: String {
        switch self {
        case .google:
            return "https://google.com/"
        case .appspot:
            return Configuration.shared.baseURL
        case .github:
            return Configuration.shared.githubRepository
        }
    }

    var isSecure: Bool {
        return self.value.contains("https")
    }

}
