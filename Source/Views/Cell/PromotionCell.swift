//
//  PromotionCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

final class PromotionCell: CollectionViewCell<PromotionCellViewModel>, DequableCellProtocol, IdentifiableProtocol {

    @IBOutlet private weak var imageView: LoadingImageView!

    override var viewModel: PromotionCellViewModel! {
        didSet {
            self.imageView.set(imageURL: self.viewModel.imageURL)?
                .store(in: &self.subscriptions)
        }
    }


}

