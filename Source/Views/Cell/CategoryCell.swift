//
//  CategoryCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class CategoryCell: CollectionViewCell<CategoryCellViewModel>, DequableCellProtocol, IdentifiableProtocol {

    @IBOutlet private weak var image: LoadingImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var shortDescription: UILabel!
    @IBOutlet private weak var newBadge: BadgeLabel!
    
    override var viewModel: CategoryCellViewModel! {
        didSet {
            self.title.text = self.viewModel.title
            self.subTitle.text = self.viewModel.subTitle
            self.shortDescription.text = self.viewModel.shortDescription
            self.newBadge.isHidden = self.viewModel.hasNewBadge != true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}