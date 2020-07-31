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
        
        output.homeDataPublisher
            .receive(on: DispatchQueue.main)
            .compactMap( { $0 })
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.handle(error: error)
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] home in
                    self?.applySnapshot(home: home)
            })
            .store(in: &self.subscriptions)
    }

    private func setupDataSource() {
        self.dataSource = DataSource(collectionView: self.collectionView) { [weak self]
            (collectionView, indexPath, hashable) in
            guard let self = self else { return nil }
            switch hashable {
            case let home as Home:
                return self.eventCell.deque(in: collectionView, at: indexPath) {
                    $0.viewModel = .init(home: home)
                }
            case let category as Category:
                return self.categoryCell.deque(in: collectionView, at: indexPath) {
                    $0.viewModel = .init(category: category)
                }
            case let promotion as Promotion:
                return self.promotionCell.deque(in: collectionView, at: indexPath) {
                    $0.viewModel = .init(promotion: promotion)
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
    
    private func applySnapshot(home: Home) {
        var snapshot = Snapshot()
        snapshot.appendSections([.event, .services, .promotion])
        self.insert(home: home, to: &snapshot)
        self.insert(categories: home.categories, to: &snapshot)
        self.insert(promotions: home.promotions, to: &snapshot)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func insert(home: Home, to snapshot: inout Snapshot) {
        snapshot.appendItems([home], toSection: .event)
    }

    private func insert(categories: [Category], to snapshot: inout Snapshot) {
        snapshot.appendItems(categories, toSection: .services)
    }
    
    private func insert(promotions: [Promotion], to snapshot: inout Snapshot) {
        snapshot.appendItems(promotions, toSection: .promotion)
    }
    
    private func registerDependencies() {        self._reusableHeaderView.registerReusableView(in: self.collectionView)
        self._eventCell.registerCell(in: self.collectionView)
        self._categoryCell.registerCell(in: self.collectionView)
        self._promotionCell.registerCell(in: self.collectionView)
    }
    
    private func handle(error: Error) {
        print("@ERROR:", error.localizedDescription)
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

