//
//  HomeCollectionView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class HomeCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: HomeCompositionalLayout.createLayout())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setLayout()
    }

    func setLayout() {
        self.collectionViewLayout = HomeCompositionalLayout.createLayout()
    }

}
