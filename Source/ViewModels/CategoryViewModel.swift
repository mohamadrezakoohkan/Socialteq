//
//  CategoryViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine

protocol CategoryViewModelInput {
    var cellDidTapped: AnyPublisher<AnyHashable?, Never> { get }
}

protocol CategoryViewModelOutput {
    var packageTappedSubscription: AnyCancellable { get }
    var eventPublisher: AnyPublisher<EventCellViewModel, Never> { get }
    var packagePublisher: AnyPublisher<[PackageCellViewModel], Never> { get }
}

final class CategoryViewModel: ViewModelType {

    struct Input: CategoryViewModelInput {
        let cellDidTapped: AnyPublisher<AnyHashable?, Never>
    }

    struct Output: CategoryViewModelOutput {
        let packageTappedSubscription: AnyCancellable
        let eventPublisher: AnyPublisher<EventCellViewModel, Never>
        let packagePublisher: AnyPublisher<[PackageCellViewModel], Never>
    }

    @Injected(container: NetworkingDIContainer.shared)
    private var service: CategoryProvider

    @CurrentValue
    private var category: Category

    init(category: Category) {
        self.category = category
    }

    func transform(input: Input) -> Output {
        return Output(
            packageTappedSubscription: self.subscribe(packageTapped: input.cellDidTapped),
            eventPublisher: self.publishEvent(),
            packagePublisher: self.publishPackage()
        )
    }

    private func subscribe(packageTapped publisher: AnyPublisher<AnyHashable?, Never>) -> AnyCancellable {
        publisher.receive(on: DispatchQueue.main)
            .compactMap({ $0 as? CategoryCellViewModel })
            .eraseToAnyPublisher()
            .sink(receiveValue: { _ in
                // do something
            })
    }

    private func publishEvent() -> AnyPublisher<EventCellViewModel, Never> {
        self.$category
            .map { self.createViewModels(from: $0) }
            .eraseToAnyPublisher()
    }

    private func publishPackage() -> AnyPublisher<[PackageCellViewModel], Never> {
        self.service.getCategory(slug: self.category.slug ?? "")
            .compactMap { $0?.data }
            .map { self.createViewModels(from: $0) }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    private func createViewModels(from category: Category) -> EventCellViewModel {
        return .init(category: category)
    }

    private func createViewModels(from packages: [Package]) -> [PackageCellViewModel] {
        return packages.map { .init(package: $0) }
    }
}
