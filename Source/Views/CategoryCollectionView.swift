//
//  CategoryCollectionView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class CategoryCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: CategoryCompositionalLayout.createLayout())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.collectionViewLayout = CategoryCompositionalLayout.createLayout()
    }
}
