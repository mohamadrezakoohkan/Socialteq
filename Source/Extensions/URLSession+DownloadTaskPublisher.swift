//
//  URLSession+DownloadTaskPublisher.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/10/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine
import UIKit

extension URLSession {
    
    func downloadTaskPublisher(for url: URL, cache policy: NSURLRequest.CachePolicy, timeout: TimeInterval) -> URLSession.DownloadTaskPublisher {
        let request = URLRequest(url: url, cachePolicy: policy, timeoutInterval: timeout)
        return self.downloadTaskPublisher(for: request)
    }
    
    func downloadTaskPublisher(for request: URLRequest) -> URLSession.DownloadTaskPublisher {
        return .init(request: request, session: self)
    }
    
    /// DataTask Publisher for subscription
    ///
    struct DownloadTaskPublisher: Publisher {
        
        typealias Output = (url: URL, response: URLResponse)
        typealias Failure = Error
        
        let request: URLRequest
        let session: URLSession
        
        init(request: URLRequest, session: URLSession) {
            self.request = request
            self.session = session
        }
        
        func receive<SubscriberType>(subscriber: SubscriberType) where SubscriberType: Subscriber,
            DownloadTaskPublisher.Failure == SubscriberType.Failure,
            DownloadTaskPublisher.Output == SubscriberType.Input
        {
            let subscription = DownloadTaskSubscription(subscriber: subscriber, session: self.session, request: self.request)
            subscriber.receive(subscription: subscription)
        }
    }
    
    /// URLSession download task wrapper
    ///
    final class DownloadTaskSubscription<SubscriberType: Subscriber>: Subscription where
        SubscriberType.Input == (url: URL, response: URLResponse),
        SubscriberType.Failure == Error
    {
        private var subscriber: SubscriberType?
        private weak var session: URLSession!
        private var request: URLRequest!
        private var task: URLSessionDownloadTask!
                
        init(subscriber: SubscriberType, session: URLSession, request: URLRequest) {
            self.subscriber = subscriber
            self.session = session
            self.request = request
        }
        
        func request(_ demand: Subscribers.Demand) {
            
            guard demand > 0 else {
                return
            }
            self.task = self.session.downloadTask(with: self.request) { [weak self] url, response, error in
                if let error = error as? URLError {
                    self?.subscriber?.receive(completion: .failure(error))
                    return
                }
                guard let response = response else {
                    self?.subscriber?.receive(completion: .failure(URLError(.badServerResponse)))
                    return
                }
                guard let url = url else {
                    self?.subscriber?.receive(completion: .failure(URLError(.badURL)))
                    return
                }
                do {
                    let file = HTTPFile(url: self?.request.url)!
                    try file.write(from: url.path)
                    _ = self?.subscriber?.receive((url: URL(string: file.path)!, response: response))
                    self?.subscriber?.receive(completion: .finished)
                }
                catch {
                    print("ERR", error.localizedDescription)
                    self?.subscriber?.receive(completion: .failure(error))
                }
            }
            self.task.resume()
        }
        
        func cancel() {
            self.task.cancel()
        }
    }
}
