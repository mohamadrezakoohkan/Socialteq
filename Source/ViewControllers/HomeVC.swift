//
//  HomeVC.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

final class HomeVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var coordinator: CategoryViewing?
    
    @Registerable
    private var reusableView = HomeReusableView.self
    
    @Injected(container: DIContainer.shared)
    private var user: User
    
    @Injected(container: NetworkingDIContainer.shared)
    private var service: HomeProvider
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerDependencies()
    }
    
    override func willSetCancelables(_ cancelables: @escaping () -> [AnyCancellable]) {
        super.willSetCancelables {
            return []
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.service.getHome { (result) in
            switch result {
            case .success(let home):
                print(home)
            case .failure(let error):
                print("@NET err", error.localizedDescription)
            }
        }
    }
    
    fileprivate func registerDependencies() {        self._reusableView.registerReusableView(in: self.collectionView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
//        self.coordinator?.show(category: Category(_id: "", slug: "", id: "", titles: nil, subTitles: nil, title: nil, subTitle: nil, descriptions: nil, shortDescriptions: nil, slogans: nil, description: nil, shortDescription: nil, slogan: nil, image: nil, isActive: nil, sort: nil, hasNewBadge: nil, displayType: nil, data: []))
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return self.reusableView.deque(in: collectionView, at: indexPath, of: kind)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return collectionView.dynamicReusableViewSize(dataSource: self, forSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        self.reusableView.transform(view) { [weak self] in
            guard let _ = self else { return }
            $0.title.text = "Test"
            $0.subTitle.text = "Double test"
        }
    }
    
    
    
}
