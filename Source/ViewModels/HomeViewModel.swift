//
//  HomeViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol HomeViewModelInput {
    var addressTextDidEnd: AnyPublisher<String?, Never> { get }
}

protocol HomeViewModelOutput {
    var addressTextFieldSubscription: AnyCancellable { get }
    var usernamePublisher: AnyPublisher<String?, Never> { get }
    var userAddressPublisher: AnyPublisher<String?, Never> { get }
    var homeDataPublisher: AnyPublisher<Home?, Error> { get }

}

final class HomeViewModel: ViewModelType {
    
    @Injected(container: NetworkingDIContainer.shared)
    private var service: HomeProvider
    
    @CurrentValue
    private var user: User
    
    struct Input: HomeViewModelInput {
        let addressTextDidEnd: AnyPublisher<String?, Never>
    }
    
    struct Output: HomeViewModelOutput {
        let addressTextFieldSubscription: AnyCancellable
        let usernamePublisher: AnyPublisher<String?, Never>
        let userAddressPublisher: AnyPublisher<String?, Never>
        let homeDataPublisher: AnyPublisher<Home?, Error>
    }
        
    init(user: User = .shared) {
        self.user = user
    }
    
    func transform(input: Input) -> Output {
        return Output(
            addressTextFieldSubscription: input
                .addressTextDidEnd
                .receive(on: DispatchQueue.global(qos: .background))
                .compactMap({ $0 })
                .filter(\.isNotEmpty)
                .optional()
                .assign(to: \.address, on: self.user),
            usernamePublisher: self.$user
                .compactMap { $0.name }
                .eraseToAnyPublisher(),
            userAddressPublisher: self.$user
                .compactMap { $0.address }
                .eraseToAnyPublisher(),
            homeDataPublisher: self.service.getHome()
                .eraseToAnyPublisher()
        )
    }
}
