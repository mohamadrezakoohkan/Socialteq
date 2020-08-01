//
//  PackageCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

final class PackageCell: CollectionViewCell<PackageCellViewModel>, DequableCellProtocol, IdentifiableProtocol {

    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var imageView: LoadingImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var shortDescription: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var badge: BadgeLabel!
            
    override var viewModel: PackageCellViewModel! {
        didSet {
            self.clipsToBounds = !self.viewModel.special
            self.view.backgroundColor = self.viewModel.special ? .appHighlight : .appLightBlue
            self.title.backgroundColor = self.viewModel.special ? .appWhite : .appBlack
            self.subTitle.backgroundColor = self.viewModel.special ? .appWhite : .appBlack
            self.shortDescription.backgroundColor = self.viewModel.special ? .appWhite : .appBlack
            self.badge.isHidden = !self.viewModel.isDiscountBadgeVisible
            self.title.text = self.viewModel.title
            self.badge.text = self.viewModel.discountText
            self.subTitle.text = self.viewModel.subTitle
            self.shortDescription.text = self.viewModel.shortDescription
            self.price.text = self.viewModel.priceText
            self.imageView.set(imageURL: self.viewModel.imageURL)?
                .store(in: &self.subscriptions)
        }
    }
}
