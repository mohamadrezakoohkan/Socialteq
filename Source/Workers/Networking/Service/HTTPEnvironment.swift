//
//  HTTPEnviroment.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

/// Enviroment type already handled in configurations but for mocking urlsession we can define our enviroment to keep project isolate
///
enum HTTPEnvironment {
    case production
    case development
}
