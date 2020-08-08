//
//  HomeVC.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<HomeVC.Section, AnyHashable>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<HomeVC.Section, AnyHashable>

final class HomeVC: BaseViewController, Storyboarded {
    
    @Localized(localizedString: .greeting)
    @IBOutlet private var greetingsLabel: UILabel!
    @Localized(localizedString: .requestAddressMessage)
    @IBOutlet private var addressTextField: TextField!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var collectionView: HomeCollectionView!
    
    @Registerable private var reusableHeaderView = TitleReusableView.self
    @Registerable private var eventCell = EventCell.self
    @Registerable private var categoryCell = CategoryCell.self
    @Registerable private var promotionCell = PromotionCell.self
    
    weak var coordinator: CategoryViewing?
    private var viewModel = HomeViewModel()
    private var dataSource: DataSource!
    private var didCellTapped = PassthroughSubject<AnyHashable?, Never>()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerDependencies()
        self.setupDataSource()
        self.setupSectionHeader()
        self.bindViewModel()
    }
    
    func bindViewModel() {
        let output = self.viewModel.transform(input: .init(
            addressTextDidEnd: self.addressTextField
                .publisher(for: \.text)
                .eraseToAnyPublisher(),
            cellDidTapped: self.didCellTapped
                .eraseToAnyPublisher()
            )
        )
        
        output.addressTextFieldSubscription
            .store(in: &self.subscriptions)
        
        output.usernamePublisher
            .receive(on: DispatchQueue.main)
            .replaceNilOrEmpty(with: .sampleUsername)
            .assign(to: \.text, on: self.usernameLabel)
            .store(in: &self.subscriptions)
        
        output.userAddressPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.addressTextField)
            .store(in: &self.subscriptions)
        
        output.categoryTapped
            .receive(on: DispatchQueue.main)
            .compactMap { $0.category }
            .sink(receiveValue: { [weak self] in self?.coordinator?.show(category: $0)})
            .store(in: &self.subscriptions)
        
        output.homeDataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.handle(error: error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] in
                    self?.applySnapshot(event: $0, categories: $1, promotions: $2)
            })
            .store(in: &self.subscriptions)
    }

    private func setupDataSource() {
        self.dataSource = DataSource(collectionView: self.collectionView) { [weak self]
            (collectionView, indexPath, hashable) in
            guard let self = self else { return nil }
            switch hashable {
            case let event as EventCellViewModel:
                return self.eventCell.deque(in: collectionView, at: indexPath) {
                    $0.viewModel = event
                }
            case let category as CategoryCellViewModel:
                return self.categoryCell.deque(in: collectionView, at: indexPath) {
                    $0.viewModel = category
                }
            case let promotion as PromotionCellViewModel:
                return self.promotionCell.deque(in: collectionView, at: indexPath) {
                    $0.viewModel = promotion
                }
            default:
                return nil
            }
        }
    }
    
    private func setupSectionHeader() {
        self.dataSource.supplementaryViewProvider = { [weak self]
            (collectionView, kind, indexPath) in
            guard let self = self else { return nil }
            return self.reusableHeaderView.deque(in: collectionView, at: indexPath, of: kind) {
                $0.titleValue = Section.resolve(indexPath.section).title
            }
        }
    }
    
    private func applySnapshot(event: EventCellViewModel, categories: [CategoryCellViewModel], promotions: [PromotionCellViewModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.event, .services, .promotion])
        snapshot.appendItems([event], toSection: .event)
        snapshot.appendItems(categories, toSection: .services)
        snapshot.appendItems(promotions, toSection: .promotion)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func registerDependencies() {        self._reusableHeaderView.registerReusableView(in: self.collectionView)
        self._eventCell.registerCell(in: self.collectionView)
        self._categoryCell.registerCell(in: self.collectionView)
        self._promotionCell.registerCell(in: self.collectionView)
    }
    
    private func handle(error: Error) {
        debugPrint("@ERROR:", error.localizedDescription)
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didCellTapped.send(self.dataSource.itemIdentifier(for: indexPath))
    }
}

extension HomeVC {
    enum Section: CaseIterable {
        case event
        case services
        case promotion
        
        var title: String {
            switch self {
            case .event:
                return .emptyString
            case .services:
                return .services
            case .promotion:
                return .promotion
            }
        }
        
        static var resolve: (_ section: Int) -> (Section) = { (section) in
            switch section {
            case .secondIndex:
               return services
            case .thirdIndex:
                return promotion
            default:
                return event
            }
        }
    }
}
