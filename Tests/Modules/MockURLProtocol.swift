//
//  MockURL.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

/// Apple way to intercept network requests
///
class MockURLProtocol: URLProtocol {

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let requestHandler = MockURLProtocol.requestHandler else {
            fatalError("Did not pass request handler to MockURLProtocol")
        }
        
        do {
            let (response, data) = try requestHandler(self.request)
            self.setProtocol(with: response)
            if let data = data {
                self.setProtocol(with: data)
            }
            client?.urlProtocolDidFinishLoading(self)
            
        } catch {
             self.setProtocol(with: error)
            client?.urlProtocolDidFinishLoading(self)
        }
        
    }

    override func stopLoading() {
        
    }
    
    private func setProtocol(with data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
    }
    
    private func setProtocol(with response: URLResponse) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }
    
    private func setProtocol(with error: Error) {
        self.client?.urlProtocol(self, didFailWithError: error)
    }
}
