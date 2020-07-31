//
//  CollectionViewCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class CollectionViewCell<T: ViewModelType>: UICollectionViewCell {
 
    open var viewModel: T! = nil
}
