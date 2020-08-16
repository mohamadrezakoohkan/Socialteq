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

    func constraintCenter(in view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func dynamicHeight(wdith widthValue: CGFloat? = nil) -> CGSize {
        let width = widthValue == nil ? self.frame.width : widthValue!
        let height = UIView.layoutFittingExpandedSize.height
        return self.systemLayoutSizeFitting(
            CGSize(width: width, height: height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }

    func dynamicWidth(height heightValue: CGFloat? = nil) -> CGSize {
        let width = UIView.layoutFittingExpandedSize.height
        let height = heightValue == nil ? self.frame.height : heightValue!
        return self.systemLayoutSizeFitting(
            CGSize(width: width, height: height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }

}
