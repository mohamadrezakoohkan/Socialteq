//
//  HomeVC.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class HomeVC: UIViewController, Storyboarded {
    
    weak var coordinator: CategoryViewing?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.coordinator?.show(category: Category(_id: "", slug: "", id: "", titles: nil, subTitles: nil, title: nil, subTitle: nil, descriptions: nil, shortDescriptions: nil, slogans: nil, description: nil, shortDescription: nil, slogan: nil, image: nil, isActive: nil, sort: nil, hasNewBadge: nil, displayType: nil, data: []))
    }
}
