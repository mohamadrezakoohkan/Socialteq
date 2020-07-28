//
//  BaseViewController.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    
    private lazy var subscriptions: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.willSetCancelables {
           return []
        }
    }
    
    func willSetCancelables(_ cancelables: @escaping () -> [AnyCancellable]) {
        guard !cancelables().isEmpty else { return }
        self.subscriptions = cancelables()
    }
}
