//
//  HTTPManagerTests.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import XCTest
import Combine
@testable import Socialteq

class HTTPManagerTests: XCTestCase {
    
    private var sut: HTTPManager? = nil
    private var subscriptions: [AnyCancellable] = []
    private let homeResponse: String = APIResponseData.home
    private let categoryResponse: String = APIResponseData.carwash
    private let categorySlug = "carwash"
    private let timeout: TimeInterval = 3.0
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession.init(configuration: configuration)
        self.sut = HTTPManager(router: Router<Endpoint>(session: session, cachePolicy: .reloadIgnoringCacheData))
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
        self.subscriptions = []
    }
    
    func testGetHome() {
        let route: Endpoint = .home
        let expectedResult = self.homeResponse
        let statusCode = 200
        let expectation = XCTestExpectation(description: "Getting home from decoded object")
        self.response(route: route, object: expectedResult, code: statusCode)
        self.sut!.request(route: route)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }, receiveValue: { (actualResult: Home) in
                let expected: Home = self.decode(string: expectedResult)
                let result = self.toString(encodable: actualResult)
                if actualResult == expected {
                    expectation.fulfill()
                }else{
                    XCTFail(TestError.diffrentResponse(result, expectedResult).localizedDescription)
                }
            }).store(in: &self.subscriptions)
        wait(for: [expectation], timeout: self.timeout)
    }
    
    func testGetCategory() {
        let route: Endpoint = .services(self.categorySlug)
        let expectedResult = self.categoryResponse
        let statusCode = 200
        let expectation = XCTestExpectation(description: "Getting category from decoded object")
        self.response(route: route, object: expectedResult, code: statusCode)
        self.sut!.request(route: route)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }, receiveValue: { (actualResult: Socialteq.Category) in
                let expected: Socialteq.Category = self.decode(string: expectedResult)
                let result = self.toString(encodable: actualResult)
                if actualResult == expected {
                    expectation.fulfill()
                }else{
                    XCTFail(TestError.diffrentResponse(result, expectedResult).localizedDescription)
                }
            }).store(in: &self.subscriptions)
        wait(for: [expectation], timeout: self.timeout)
    }
    
    private func decode<D: Decodable>(string: String) -> D {
        let data = string.data(using: .utf8)!
        let decoder = JSONDecoder.init()
        return try! decoder.decode(D.self, from: data)
    }
    
    private func toString<E: Encodable>(encodable: E) -> String {
        let encoder = JSONEncoder.init()
        let data = try! encoder.encode(encodable)
        return String(data: data, encoding: .utf8)!
    }
    
    private func string(_ data: Data) -> String {
        return String(data: data, encoding: .utf8)!
    }

    private func response(route: Endpoint, object: String, code: Int) {
        MockURLProtocol.requestHandler = { (request) in
            guard let url = request.url, url == route.url else {
                throw URLError(.badURL)
            }
            let response = HTTPURLResponse(url: route.url, statusCode: code, httpVersion: nil, headerFields: nil)!
            return (response, object.data(using: .utf8))
        }
    }
}



