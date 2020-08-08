//
//  HomeViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

protocol HomeViewModelInput {
    var addressTextDidEnd: AnyPublisher<String?, Never> { get }
    var cellDidTapped: AnyPublisher<(AnyHashable?, CategoryViewing?), Never> { get }
}

protocol HomeViewModelOutput {
    var addressTextFieldSubscription: AnyCancellable { get }
    var categoryTappedSubscription: AnyCancellable { get }
    var userNamePublisher: AnyPublisher<String?, Never> { get }
    var userAddressPublisher: AnyPublisher<String?, Never> { get }
    var homeDataPublisher: AnyPublisher<(event: EventCellViewModel, categories: [CategoryCellViewModel], promotions: [PromotionCellViewModel]), Never> { get }
}

final class HomeViewModel: ViewModelType {
    
    struct Input: HomeViewModelInput {
        let addressTextDidEnd: AnyPublisher<String?, Never>
        let cellDidTapped: AnyPublisher<(AnyHashable?, CategoryViewing?), Never>
    }
    
    struct Output: HomeViewModelOutput {
        let addressTextFieldSubscription: AnyCancellable
        let categoryTappedSubscription: AnyCancellable
        let userNamePublisher: AnyPublisher<String?, Never>
        let userAddressPublisher: AnyPublisher<String?, Never>
        let homeDataPublisher: AnyPublisher<(event: EventCellViewModel, categories: [CategoryCellViewModel], promotions: [PromotionCellViewModel]), Never>
    }
    
    @Injected(container: NetworkingDIContainer.shared)
    private var service: HomeProvider
    
    @Injected(container: DIContainer.shared)
    private var user: User
    
    @CurrentValue
    private var userPublisher: (name: String?, address: String?)
    
    init() {
        self.userPublisher = (name: self.user.name, address: self.user.address)
    }
    
    func transform(input: Input) -> Output {
        return Output(
            addressTextFieldSubscription: self.subscribe(address: input.addressTextDidEnd),
            categoryTappedSubscription: self.subscribe(cellTapped: input.cellDidTapped),
            userNamePublisher: self.publishName(),
            userAddressPublisher: self.publishAddress(),
            homeDataPublisher: self.publishHome()
        )
    }
    
    
    private func subscribe(address publisher: AnyPublisher<String?, Never>) -> AnyCancellable {
        publisher.receive(on: DispatchQueue.global(qos: .background))
            .compactMap({ $0 })
            .filter(\.isNotEmpty)
            .optional()
            .assign(to: \.address, on: self.user)
    }
    
    private func subscribe(cellTapped publisher: AnyPublisher<(AnyHashable?, CategoryViewing?), Never>) -> AnyCancellable {
        publisher.receive(on: DispatchQueue.main)
            .map { return ($0 as? CategoryCellViewModel, $1) }
            .sink(receiveValue: {  viewModel, coordinator in
                guard let category = viewModel?.category  else {
                    // log or present errors
                    return
                }
                coordinator?.show(category: category)
            })
    }
    
    private func publishName() -> AnyPublisher<String?, Never> {
        self.$userPublisher
            .map { $0.name }
            .eraseToAnyPublisher()
    }
    
    private func publishAddress() -> AnyPublisher<String?, Never> {
        self.$userPublisher
            .map { $0.address }
            .eraseToAnyPublisher()
    }
    
    private func publishHome() -> AnyPublisher<(event: EventCellViewModel, categories: [CategoryCellViewModel], promotions: [PromotionCellViewModel]), Never> {
        self.service.getHome()
            .compactMap { $0 }
            .replaceError(with: Home(title: .eventAlternativeTitle, subTitle: .eventAlternativeSubTitle, categories: [], promotions: []))
            .map {
                return (
                    self.createViewModels(from: $0),
                    self.createViewModels(from: $0.categories),
                    self.createViewModels(from: $0.promotions)
                )
        }
        .eraseToAnyPublisher()
    }
    
    private func createViewModels(from home: Home) -> EventCellViewModel {
        return .init(home: home)
    }
    
    private func createViewModels(from promotions: [Promotion]) -> [PromotionCellViewModel] {
        return promotions.map { .init(promotion: $0) }
    }
    
    private func createViewModels(from categories: [Category]) -> [CategoryCellViewModel] {
        return categories.map { .init(category: $0) }
    }
    

}
