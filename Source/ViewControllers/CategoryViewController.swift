//
//  CategoryViewController.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

private typealias DataSource = UICollectionViewDiffableDataSource<CategoryViewController.Section, AnyHashable>
private typealias Snapshot = NSDiffableDataSourceSnapshot<CategoryViewController.Section, AnyHashable>

final class CategoryViewController: NavigationViewController, Storyboarded {

    @IBOutlet private weak var collectionView: CategoryCollectionView!

    @Registerable private var eventCell = EventCell.self
    @Registerable private var packageCell = PackageCell.self

    weak var coordinator: HomeCoordinator?
    var viewModel: CategoryViewModel!

    private var didCellTapped = PassthroughSubject<AnyHashable?, Never>()
    private var dataSource: DataSource!
    private var packages: [PackageCellViewModel] = []
    private var event: EventCellViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerDependencies()
        self.setupDataSource()
        self.bindViewModel()
    }

    func bindViewModel() {
        let output = self.viewModel.transform(input: self.createInput())
        self.store(subscription: output.packageTappedSubscription)
        self.subscribe(event: output.eventPublisher)
        self.subscribe(packages: output.packagePublisher)
    }

    private func createInput() -> CategoryViewModel.Input {
        .init(
            cellDidTapped: self.publishCellTapped()
        )
    }

    private func subscribe(event publisher: AnyPublisher<EventCellViewModel, Never>) {
        publisher.receive(on: DispatchQueue.main)
            .map { $0 as EventCellViewModel? }
            .weakAssign(to: \.event, on: self) { [weak self] in self?.applySnapshot() }
            .store(in: &self.subscriptions)
    }

    private func subscribe(packages publisher: AnyPublisher<[PackageCellViewModel], Never>) {
        publisher.receive(on: DispatchQueue.main)
            .weakAssign(to: \.packages, on: self) { [weak self] in self?.applySnapshot() }
            .store(in: &self.subscriptions)
    }

    private func publishCellTapped() -> AnyPublisher<AnyHashable?, Never> {
        self.didCellTapped
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    private func setupDataSource() {
        self.dataSource = DataSource(collectionView: self.collectionView) { [weak self] (_, indexPath, hashable) in
            guard let self = self else { return nil }
            switch hashable {
            case let event as EventCellViewModel:
               return self.dequeEventCell(at: indexPath, event: event)
            case let package as PackageCellViewModel:
                return self.dequePackageCell(at: indexPath, package: package)
            default:
                return nil
            }
        }
    }

    private func applySnapshot() {
        var snapshot = Snapshot()
        self.appendSections(to: &snapshot)
        self.appendEvent(to: &snapshot)
        self.appendPackages(to: &snapshot)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func appendSections(to snapshot: inout Snapshot) {
        let isHeaderVisible: Bool = self.event.hasValue
        snapshot.appendSections(isHeaderVisible ? [.event, .services] : [.services])
    }

    private func appendEvent(to snapshot: inout Snapshot) {
        let isHeaderVisible: Bool = self.event.hasValue
        snapshot.appendItems(isHeaderVisible ? [self.event] : [], toSection: .event)
    }

    private func appendPackages(to snapshot: inout Snapshot) {
        snapshot.appendItems(self.packages, toSection: .services)
    }

    private func dequeEventCell(at index: IndexPath, event: EventCellViewModel) -> EventCell {
        return self.eventCell.deque(in: self.collectionView, at: index) {
            $0.viewModel = event
        }
    }

    private func dequePackageCell(at index: IndexPath, package: PackageCellViewModel) -> PackageCell {
        return self.packageCell.deque(in: self.collectionView, at: index) {
            $0.viewModel = package
        }
    }

    private func registerDependencies() {
        self._eventCell.registerCell(in: self.collectionView)
        self._packageCell.registerCell(in: self.collectionView)
    }

}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didCellTapped.send(self.dataSource.itemIdentifier(for: indexPath))
    }
}

extension CategoryViewController {
    enum Section: CaseIterable {
        case event
        case services

        static var resolve: (_ section: Int) -> (Section) = { (section) in
            switch section {
            case .firstIndex:
                return .event
            default:
                return .services
            }
        }
    }
}
