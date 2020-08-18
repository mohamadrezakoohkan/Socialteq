//
//  CollectionViewCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

class CollectionViewCell<T: ViewModelType>: UICollectionViewCell {

    open var subscriptions: [AnyCancellable] = []

    open var viewModel: T! = nil

    override func prepareForReuse() {
        super.prepareForReuse()
        self.subscriptions = []
    }
}
