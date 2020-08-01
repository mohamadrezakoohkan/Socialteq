//
//  NavigationViewController.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class NavigationViewController: BaseViewController {
    
    @IBOutlet weak var navigationBar: NavigationBar! {
        didSet {
            self.navigationBar.title = self.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle()
    }
    
    open func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setTitle() {
        self.navigationBar.title = self.title
    }
}
