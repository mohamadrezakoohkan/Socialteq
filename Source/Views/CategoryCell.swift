//
//  CategoryCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class CategoryCell: UICollectionViewCell, DequableCellProtocol, IdentifiableProtocol {

    @IBOutlet weak var image: LoadingImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var newBadge: BadgeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
