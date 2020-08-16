//
//  HomeViewController.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

private typealias DataSource = UICollectionViewDiffableDataSource<HomeViewController.Section, AnyHashable>
private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeViewController.Section, AnyHashable>

final class HomeViewController: BaseViewController, Storyboarded {

    @Localized(localizedString: .greeting)
    @IBOutlet private var greetingsLabel: UILabel!
    @Localized(localizedString: .requestAddressMessage)
    @IBOutlet private var addressTextField: TextField!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var collectionView: HomeCollectionView!

    @Registerable
    private var reusableHeaderView = TitleReusableView.self
    @Registerable
    private var eventCell = EventCell.self
    @Registerable
    private var categoryCell = CategoryCell.self
    @Registerable
    private var promotionCell = PromotionCell.self

    weak var coordinator: HomeCoordinator?
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
        let output = self.viewModel.transform(input: self.createInput())
        self.subscribe(name: output.userNamePublisher)
        self.subscribe(address: output.userAddressPublisher)
        self.subscribe(home: output.homeDataPublisher)
        self.store(subscription: output.categoryTappedSubscription)
        self.store(subscription: output.addressTextFieldSubscription)
    }

    private func createInput() -> HomeViewModel.Input {
        .init(
            addressTextDidEnd: self.publishAddress(),
            cellDidTapped: self.publishCellTapped()
        )
    }

    private func publishAddress() -> AnyPublisher<String?, Never> {
        self.addressTextField
            .publisher(for: \.text)
            .eraseToAnyPublisher()
    }

    private func publishCellTapped() -> AnyPublisher<(AnyHashable?, CategoryViewing?), Never> {
        self.didCellTapped
            .map { [weak self] in return ($0, self?.coordinator) }
            .eraseToAnyPublisher()
    }

    private func subscribe(name publisher: AnyPublisher<String?, Never>) {
        publisher.receive(on: DispatchQueue.main)
            .replaceNilOrEmpty(with: .sampleUsername)
            .assign(to: \.text, on: self.usernameLabel)
            .store(in: &self.subscriptions)
    }

    private func subscribe(address publisher: AnyPublisher<String?, Never>) {
        publisher.receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.addressTextField)
            .store(in: &self.subscriptions)
    }

    private func subscribe(home publisher: AnyPublisher<(event: EventCellViewModel, categories: [CategoryCellViewModel], promotions: [PromotionCellViewModel]), Never>) {
        publisher.receive(on: DispatchQueue.main)
            .sink( receiveValue: { [weak self] in
                self?.applySnapshot(event: $0, categories: $1, promotions: $2)
            })
            .store(in: &self.subscriptions)
    }

    private func setupDataSource() {
        self.dataSource = DataSource(collectionView: self.collectionView) { [weak self] (collectionView, indexPath, hashable) in
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
        self.dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
            guard let self = self else { return nil }
            return self.reusableHeaderView.deque(in: collectionView, at: indexPath, of: kind) {
                $0.titleValue = Section.resolve(indexPath.section).title
            }
        }
    }

    private func applySnapshot(event: EventCellViewModel, categories: [CategoryCellViewModel], promotions: [PromotionCellViewModel]) {
        var snapshot = Snapshot()
        self.appendSections(to: &snapshot)
        self.append(event: event, to: &snapshot)
        self.append(categories: categories, to: &snapshot)
        self.append(promotions: promotions, to: &snapshot)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func appendSections(to snapshot: inout Snapshot) {
        snapshot.appendSections([.event, .services, .promotion])
    }

    private func append(event: EventCellViewModel,to snapshot: inout Snapshot) {
        snapshot.appendItems([event], toSection: .event)
    }

    private func append(categories: [CategoryCellViewModel],to snapshot: inout Snapshot) {
        snapshot.appendItems(categories, toSection: .services)
    }

    private func append(promotions: [PromotionCellViewModel],to snapshot: inout Snapshot) {
        snapshot.appendItems(promotions, toSection: .promotion)
    }

    private func registerDependencies() {        self._reusableHeaderView.registerReusableView(in: self.collectionView)
        self._eventCell.registerCell(in: self.collectionView)
        self._categoryCell.registerCell(in: self.collectionView)
        self._promotionCell.registerCell(in: self.collectionView)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectItem(at: indexPath)
    }

    func selectItem(at indexPath: IndexPath) {
        let item = self.dataSource.itemIdentifier(for: indexPath)
        self.didCellTapped.send(item)
    }
}

extension HomeViewController {
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
