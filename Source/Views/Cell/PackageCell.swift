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

    private var shadowRect: CGRect {
        let start: CGFloat = 20
        let width: CGFloat = self.bounds.width - start*3
        return CGRect(x: start, y: .zero, width: width, height: self.bounds.height)
    }

    override var viewModel: PackageCellViewModel! {
        didSet {
            self.view.clipsToBounds = !self.viewModel.special
            self.view.layer.masksToBounds = !self.viewModel.special
            self.view.backgroundColor = self.viewModel.special ? .appDarkBlue : .appLightBlue
            self.title.textColor = self.viewModel.special ? .appWhite : .appBlack
            self.subTitle.textColor = self.viewModel.special ? .appWhite : .appBlack
            self.shortDescription.textColor = self.viewModel.special ? .appWhite : .appSecondary
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

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadow()
    }

    func setShadow() {
        self.view.layer.masksToBounds = false
        self.view.layer.shadowColor = UIColor.appHighlight.cgColor
        self.view.layer.shadowOpacity = 0.3
        self.view.layer.shadowRadius = 20
        self.view.layer.shadowOffset = .init(width: 0, height: 5)
        self.view.layer.shadowPath = UIBezierPath(rect: self.shadowRect).cgPath
    }
}
