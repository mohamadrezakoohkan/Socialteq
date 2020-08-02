//
//  MockRouter.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
@testable import Socialteq

class MockRouter<EndpointType: HTTPEndpoint>: Router<EndpointType> {
    
    convenience init(urlProtocol: URLProtocol.Type) {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [urlProtocol.self]
        self.init(session: URLSession(configuration: configuration))
    }
}
