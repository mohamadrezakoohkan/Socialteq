//
//  TestError.swift
//  SocialteqTests
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

enum TestError: Error {
    
    case diffrentResponse(_ actual: String, _ expected: String)
    case failed(_ failure: (URLSession.DataTaskPublisher.Failure))
    
    var localizedDescription: String {
        switch self {
        case .diffrentResponse(let acutal, let expected):
            return "Received: \(acutal) instead of \(expected)"
        case .failed(let failure):
            return "Description: \(failure.localizedDescription), Userinfo: \(failure.userInfo), Code: \(failure.errorCode)"
        }
    }
}
