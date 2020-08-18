//
//  HTTPManager.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine
import UIKit.UIImage

struct HTTPManager {

    static let environment: HTTPEnvironment = .production
    fileprivate let router: Router<Endpoint>

    init(router: Router<Endpoint> = .init()) {
        self.router = router
    }

    fileprivate func handleError(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
            let responeData = data else {
                throw HTTPError.invalidResponseData
        }

        switch httpResponse.statusCode {
        case 200...299:
            return responeData
        case 403:
            throw HTTPError.badRequest
        case 404:
            throw HTTPError.notFound
        case 501...599:
            throw HTTPError.serverError
        case 600:
            throw HTTPError.outdated
        default:
            throw HTTPError.canceled
        }

    }

    fileprivate func handlePublishError(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        try self.handleError(data: output.data, response: output.response)
    }

    func request<D: Decodable>(route: Endpoint) -> AnyPublisher<D, Error> {
        self.router.request(route: route)
            .tryMap { try self.handlePublishError(output: $0) }
            .decode(type: D.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension HTTPManager: HomeProvider {
    func getHome() -> AnyPublisher<Home?, Error> {
        return self.request(route: .home)
    }
}

extension HTTPManager: CategoryProvider {
    func getCategory(slug: String) -> AnyPublisher<Category?, Error> {
        return self.request(route: .services(slug))
    }
}

extension HTTPManager: ImageProvider {

    /// Publish path to image file
    ///
    func getImage(url: URL) -> AnyPublisher<String, Error> {
        let file = HTTPFile(url: url)
        if file.exist {
            let publisher = CurrentValueSubject<String, Error>.init(file.path)
            return publisher
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } else {
            return self.router.download(url: url)
                .map { _ in HTTPFile(url: url).path }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }

}
