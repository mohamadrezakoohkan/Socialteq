//
//  HomeReusableView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class TitleReusableView: UICollectionReusableView, DequableReusableViewProtocol, IdentifiableProtocol {

    @IBOutlet private weak var title: UILabel!

    var titleValue: String = .emptyString {
        didSet {
            self.title.text = self.titleValue
        }
    }

}
