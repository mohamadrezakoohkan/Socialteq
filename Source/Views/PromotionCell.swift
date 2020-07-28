//
//  PromotionCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class PromotionCell: UICollectionViewCell, DequableCellProtocol, IdentifiableProtocol {

    @IBOutlet weak var image: LoadingImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
