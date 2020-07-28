//
//  UICollectionView+Dynamics.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

extension UICollectionView {

    func dynamicReusableViewSize(dataSource: UICollectionViewDataSource, forSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let kind = UICollectionView.elementKindSectionHeader
        let width = self.frame.width
        let height = UIView.layoutFittingExpandedSize.height
        let size = CGSize(width: width, height: height)
        let view = dataSource.collectionView!(self, viewForSupplementaryElementOfKind: kind, at: indexPath)
        return view.systemLayoutSizeFitting(
            size,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
}
