//
//  CategoryViewModel.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol CategoryViewModelInput {
    var cellDidTapped: AnyPublisher<AnyHashable?, Never> { get }
}

protocol CategoryViewModelOutput {
    var packageTapped: AnyPublisher<CategoryCellViewModel, Never> { get }
    var categoryDataSubscription: AnyCancellable { get }
    var categoryDataPublisher: AnyPublisher<(event: EventCellViewModel, packages: [PackageCellViewModel]), Never> { get }
}

final class CategoryViewModel: ViewModelType {
    
    struct Input: CategoryViewModelInput {
        let cellDidTapped: AnyPublisher<AnyHashable?, Never>
    }
    
    struct Output: CategoryViewModelOutput {
        let packageTapped: AnyPublisher<CategoryCellViewModel, Never>
        var categoryDataSubscription: AnyCancellable
        let categoryDataPublisher:  AnyPublisher<(event: EventCellViewModel, packages: [PackageCellViewModel]), Never>
    }
    
    @Injected(container: NetworkingDIContainer.shared)
    private var service: CategoryProvider
    private let category: Category
    private let publisher: CurrentValueSubject<(event: EventCellViewModel, packages: [PackageCellViewModel]), Never>

        
    init(category: Category) {
        self.category = category
        self.publisher = .init((EventCellViewModel(category: category), []))
    }
    
    
    func transform(input: Input) -> Output {
        let slug = self.category.slug ?? ""
        
        return Output(
            packageTapped: input
                .cellDidTapped
                .receive(on: DispatchQueue.main)
                .compactMap({ $0 as? CategoryCellViewModel })
                .eraseToAnyPublisher(),
            categoryDataSubscription: self.service.getCategory(slug: slug)
                .map { $0?.data }
                .compactMap { ($0) }
                .map { packages in
                    let event = EventCellViewModel(category: self.category)
                    let packs = packages.map { PackageCellViewModel(package: $0) }
                    return (event: event, packages: packs)
            }
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint("@ERROR", error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { (value) in
                self.publisher.send(value)
            }),
            categoryDataPublisher: self.publisher
                .eraseToAnyPublisher()
        )
    }
    
}

