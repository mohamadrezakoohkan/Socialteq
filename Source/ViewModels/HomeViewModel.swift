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
    var cellDidTapped: AnyPublisher<AnyHashable?, Never> { get }
}

protocol HomeViewModelOutput {
    var addressTextFieldSubscription: AnyCancellable { get }
    var categoryTapped: AnyPublisher<CategoryCellViewModel, Never> { get }
    var usernamePublisher: AnyPublisher<String?, Never> { get }
    var userAddressPublisher: AnyPublisher<String?, Never> { get }
    var homeDataPublisher: AnyPublisher<(event: EventCellViewModel, categories: [CategoryCellViewModel], promotions: [PromotionCellViewModel]), Error> { get }

}

final class HomeViewModel: ViewModelType {
    
    @Injected(container: NetworkingDIContainer.shared)
    private var service: HomeProvider
    
    @Injected(container: DIContainer.shared)
    private var user: User
    
    @CurrentValue
    private var userPublisher: (name: String?, address: String?)
    
    struct Input: HomeViewModelInput {
        let addressTextDidEnd: AnyPublisher<String?, Never>
        let cellDidTapped: AnyPublisher<AnyHashable?, Never>
    }
    
    struct Output: HomeViewModelOutput {
        let addressTextFieldSubscription: AnyCancellable
        let categoryTapped: AnyPublisher<CategoryCellViewModel, Never>
        let usernamePublisher: AnyPublisher<String?, Never>
        let userAddressPublisher: AnyPublisher<String?, Never>
        let homeDataPublisher: AnyPublisher<(event: EventCellViewModel, categories: [CategoryCellViewModel], promotions: [PromotionCellViewModel]), Error>
    }
        
    init() {
        self.userPublisher = (name: self.user.name, address: self.user.address)
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
            categoryTapped: input
                .cellDidTapped
                .receive(on: DispatchQueue.main)
                .compactMap({ $0 as? CategoryCellViewModel })
                .eraseToAnyPublisher(),
            usernamePublisher: self.$userPublisher
                .compactMap { $0.name }
                .eraseToAnyPublisher(),
            userAddressPublisher: self.$userPublisher
                .compactMap { $0.address }
                .eraseToAnyPublisher(),
            homeDataPublisher: self.service.getHome()
                .compactMap { $0 }
                .map { home in
                    let event: EventCellViewModel = .init(home: home)
                    let categories: [CategoryCellViewModel] =  home.categories.map {
                        .init(category: $0)
                    }
                    let promotions: [PromotionCellViewModel] = home.promotions.map {
                        .init(promotion: $0)
                    }
                    return (event, categories, promotions)
            }
            .eraseToAnyPublisher()
        )
    }
}
