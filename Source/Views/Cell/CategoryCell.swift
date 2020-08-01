//
//  CategoryCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

final class CategoryCell: CollectionViewCell<CategoryCellViewModel>, DequableCellProtocol, IdentifiableProtocol {

    @IBOutlet private weak var imageView: LoadingImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var shortDescription: UILabel!
    @IBOutlet private weak var badge: BadgeLabel!
            
    override var viewModel: CategoryCellViewModel! {
        didSet {
            self.badge.isHidden = !self.viewModel.isNewBadgeVisible
            self.title.text = self.viewModel.title
            self.badge.text = self.viewModel.badgeText
            self.subTitle.text = self.viewModel.subTitle
            self.shortDescription.text = self.viewModel.shortDescription
            self.imageView.set(imageURL: self.viewModel.imageURL)?
                .store(in: &self.subscriptions)
        }
    }
}
