//
//  EndpointTests.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/12/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import XCTest
@testable import Socialteq

class EndpointTests: XCTestCase {
    
    private var sut: MockEndpoint? = nil
    private let slug: String = "carwash"
    private let baseURL: String = "https://api-dot-rafiji-staging.appspot.com/"

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
 
    func testMethod() {
        self.sut = .home
        XCTAssertEqual(self.sut?.method, .get)
        self.sut = .services(self.slug)
        XCTAssertEqual(self.sut?.method, .get)
    }
    
    func testTask() {
        self.sut = .home
        XCTAssertEqual(self.sut?.task, .request)
        self.sut = .services(self.slug)
        XCTAssertEqual(self.sut?.task, .request)
    }

    func testHeaders() {
        self.sut = .home
        XCTAssertNil(self.sut?.headers)
        self.sut = .services(self.slug)
        XCTAssertNil(self.sut?.headers)
    }

    func testBaseURL() {
        self.sut = .home
        XCTAssertEqual(self.sut?.baseURL.value, self.baseURL)
        self.sut = .services(self.slug)
        XCTAssertEqual(self.sut?.baseURL.value, self.baseURL)
    }

    func testPath() {
        self.sut = .home
        XCTAssertEqual(self.sut?.path, "customer/v2/home/")
        self.sut = .services(self.slug)
        XCTAssertEqual(self.sut?.path, "customer/v2/categories/\(slug)/services/")
    }
    
    func testIsBaseURLSecure() {
        self.sut = .home
        XCTAssertEqual(self.sut?.baseURL.isSecure, true)
        self.sut = .services(self.slug)
        XCTAssertEqual(self.sut?.baseURL.isSecure, true)
    }
    
    func testURL() {
        self.sut = .home
        let homeURL = self.baseURL + "customer/v2/home/"
        XCTAssertEqual(self.sut?.urlString, homeURL)
        let servicesURL = self.baseURL + "customer/v2/categories/\(slug)/services/"
        self.sut = .services(self.slug)
        XCTAssertEqual(self.sut?.urlString, servicesURL)
    }

}
