//
//  UIView+Constraint.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

extension UIView {
    
    func constraintFill(view: UIView, edgesPadding: CGFloat = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor,
                                    constant: edgesPadding/2).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor,
                                     constant: edgesPadding).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
