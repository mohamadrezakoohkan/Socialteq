//
//  RouterTests.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import XCTest
import Combine
@testable import Socialteq

class RouterTests: XCTestCase {
    
    private var sut: MockRouter<MockEndpoint>? = nil
    private var subscriptions: [AnyCancellable] = []
    private let homeResponse: String = APIResponseData.home
    private let carwashCategoryResponse: String = APIResponseData.carwash
    private let sampleResponse: String = APIResponseData.sample
    private let timeout: TimeInterval = 3.0
    
    override func setUp() {
        super.setUp()
        self.sut = MockRouter(urlProtocol: MockURLProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
        self.subscriptions = []
    }
    
    func testMocking() {
        let endpoint = MockEndpoint.sample
        let expectedResult = self.sampleResponse
        let expectation = XCTestExpectation(description: "Getting response from given endpoint")
        self.response(endpoint: endpoint, object: expectedResult, code: 200)
        self.sut!.request(route: endpoint)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    XCTFail(TestError.failed(failure).localizedDescription)
                }
            }, receiveValue: { output in
                   let actualResult = String(data: output.data, encoding: .utf8)
                if actualResult == expectedResult {
                    expectation.fulfill()
                }else{
                    XCTFail(TestError.diffrentResponse(actualResult ?? "nil", expectedResult).localizedDescription)
                }
            }).store(in: &self.subscriptions)
        wait(for: [expectation], timeout: self.timeout)
    }

    func testGetHome() {
        let endpoint = MockEndpoint.home
        let expectedResult = self.homeResponse
        let expectation = XCTestExpectation(description: "Getting home data")
        self.response(endpoint: endpoint, object: expectedResult, code: 200)
        self.sut!.request(route: endpoint)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    XCTFail(TestError.failed(failure).localizedDescription)
                }
            }, receiveValue: { output in
                let actualResult = String(data: output.data, encoding: .utf8)
                if actualResult == expectedResult {
                    expectation.fulfill()
                }else{
                    XCTFail(TestError.diffrentResponse(actualResult ?? "nil", expectedResult).localizedDescription)
                }
            }).store(in: &self.subscriptions)
        wait(for: [expectation], timeout: self.timeout)
    }
    
    func testGetCategory() {
        let endpoint = MockEndpoint.services("carwash")
        let expectedResult = self.carwashCategoryResponse
        let expectation = XCTestExpectation(description: "Getting carwash data")
        self.response(endpoint: endpoint, object: expectedResult, code: 200)
        self.sut!.request(route: endpoint)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    XCTFail(TestError.failed(failure).localizedDescription)
                }
            }, receiveValue: { output in
                let actualResult = String(data: output.data, encoding: .utf8)
                if actualResult == expectedResult {
                    expectation.fulfill()
                }else{
                    XCTFail(TestError.diffrentResponse(actualResult ?? "nil", expectedResult).localizedDescription)
                }
            }).store(in: &self.subscriptions)
        wait(for: [expectation], timeout: self.timeout)
    }
    
    private func response(endpoint: MockEndpoint, object: String, code: Int) {
        MockURLProtocol.requestHandler = { (request) in
            guard let url = request.url, url == endpoint.url else {
                throw URLError(.badURL)
            }
            let response = HTTPURLResponse(url: endpoint.url, statusCode: code, httpVersion: nil, headerFields: nil)!
            return (response, object.data(using: .utf8))
        }
    }
}



