//
//  Router.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

final class Router<EndpointType: HTTPEndpoint>: HTTPRouter {
    
    unowned let session: URLSession
    
    let timeout: TimeInterval
    let cachePolicy: URLRequest.CachePolicy
    let qos: DispatchQoS
    let receiver: DispatchQueue
    let threadLabel: String
    var subscriper: DispatchQueue {
        return DispatchQueue(label: self.threadLabel, qos: self.qos, attributes: .concurrent)
    }
    
    init(session: URLSession = URLSession.shared,
         cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad,
         threadLabel: String = "com.socialteq.view.httpcalls",
         subscribeOnQos qos: DispatchQoS = .background,
         receiveOn receiver: DispatchQueue = .main,
         timeout: TimeInterval = 30) {
        
        self.session = session
        self.cachePolicy = cachePolicy
        self.timeout = timeout
        self.threadLabel = threadLabel
        self.qos = qos
        self.receiver = receiver
    }
    
    func request(route: EndpointType) -> HTTPRouterRequestResult {
        return self.pureRequest(url: self.requestGenerator(fromRoute: route),
                                subscribeOn: self.subscriper,
                                receiveIn: self.receiver)
    }
    
    func download(url: URL) -> HTTPRouterDownloadResult {
        self.session
            .downloadTaskPublisher(for: url, cache: self.cachePolicy, timeout: 10)
            .eraseToAnyPublisher()
    }
    
    func pureRequest<Subscriber: Scheduler, Receiver: Scheduler>(url: URLRequest, subscribeOn subscribtion: Subscriber, receiveIn receiver: Receiver) -> HTTPRouterRequestResult {
        return self.session
            .dataTaskPublisher(for: url)
            .subscribe(on: subscribtion)
            .receive(on: receiver)
            .eraseToAnyPublisher()
    }
    
}
