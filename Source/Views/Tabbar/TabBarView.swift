//
//  TabBarView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIView

final class TabBarView: UIView {
    
    private var shape: CALayer?
    private var safeArea: UIEdgeInsets = .zero
    private let cornerRadius: CGFloat = 25
    private let rectCorners: UIRectCorner = [.topLeft, .topRight]
    private var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func add(to view: UIView) {
        self.frame = view.frame
        view.addSubview(self)
    }
    
    func setup() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.setShape()
        self.setShadow()
    }
    
    func autolayout(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func deviceRotated(with coordinator: UIViewControllerTransitionCoordinator) {
        self.safeArea = coordinator.containerView.safeAreaInsets
        self.setShape()
    }
    
    private func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.08
        self.layer.shadowRadius = 20
    }
    
    private func setShape() {
        let shape = self.createShape()
        if let oldShape = self.shape {
            self.layer.replaceSublayer(oldShape, with: shape)
        }else{
            self.layer.insertSublayer(shape, at: 0)
        }
        self.shape = shape
    }
    
    private func createShape() -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = createCurvedPath().cgPath
        shape.strokeColor = UIColor.clear.cgColor
        shape.fillColor = UIColor.appWhite.cgColor
        shape.lineWidth = 0
        return shape
    }
    
    private func createCurvedPath() -> UIBezierPath {
        let corners:  UIRectCorner = self.rectCorners
        let cornerRadius: CGFloat = self.cornerRadius
        let radius: CGSize = .init(width: cornerRadius, height: cornerRadius)
        let width: CGFloat = self.width
        let height: CGFloat = self.bounds.height + self.safeArea.bottom
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        return .init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radius)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setShape()
    }
}
