//
//  EventCell.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/8/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class EventCell: CollectionViewCell<EventCellViewModel>, DequableCellProtocol, IdentifiableProtocol {

    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    
    override var viewModel: EventCellViewModel! {
        didSet {
            self.title.text = self.viewModel.title
            self.subTitle.text = self.viewModel.subTitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
