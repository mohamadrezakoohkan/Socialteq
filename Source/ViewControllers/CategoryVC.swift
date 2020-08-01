//
//  CategoryVC.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<CategoryVC.Section, AnyHashable>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<CategoryVC.Section, AnyHashable>


final class CategoryVC: NavigationViewController, Storyboarded {
    
    @IBOutlet private weak var collectionView: CategoryCollectionView!
    
    @Registerable private var eventCell = EventCell.self
    @Registerable private var packageCell = PackageCell.self

    weak var coordinator: HomeCoordinator?
    private var didCellTapped = PassthroughSubject<AnyHashable?, Never>()
    private var dataSource: DataSource!

    var viewModel: CategoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerDependencies()
        self.setupDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.bindViewModel()
    }
    
    func bindViewModel() {
        let output = self.viewModel.transform(input: .init(
            cellDidTapped: self.didCellTapped
                .eraseToAnyPublisher()
            )
        )
        
        output.packageTapped
            .receive(on: DispatchQueue.main)
            .compactMap { $0.category }
            .sink(receiveValue: { [weak self] _ in
                guard let _ = self else { return }
                print("Cell tapped ()")
            })
            .store(in: &self.subscriptions)
        
        output.categoryDataSubscription
            .store(in: &self.subscriptions)
        
        output.categoryDataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.handle(error: error)
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] in
                    self?.applySnapshot(packages: $0.packages, event: $0.event)
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
            case let package as PackageCellViewModel:
                return self.packageCell.deque(in: collectionView, at: indexPath) {
                    $0.viewModel = package
                }
            default:
                return nil
            }
        }
    }
    
    private func applySnapshot(packages: [PackageCellViewModel], event: EventCellViewModel) {
        var snapshot = Snapshot()
        snapshot.appendSections([.event, .services])
        snapshot.appendItems([event], toSection: .event)
        snapshot.appendItems(packages, toSection: .services)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func registerDependencies() {
        self._eventCell.registerCell(in: self.collectionView)
        self._packageCell.registerCell(in: self.collectionView)
    }
    
    private func handle(error: Error) {
        debugPrint("@ERROR:", error.localizedDescription)
    }
    
}

extension CategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didCellTapped.send(self.dataSource.itemIdentifier(for: indexPath))
    }
}

extension CategoryVC {
    enum Section: CaseIterable {
        case event
        case services
        
        static var resolve: (_ section: Int) -> (Section) = { (section) in
            switch section {
            case .firstIndex:
                return event
            default:
                return services
            }
        }
    }
}
