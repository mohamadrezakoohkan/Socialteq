//
//  CurvedTabbar.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UITabBar

/// Curved tabbar controller
///
/// TODO: Radar - properties not working 
///
class CurvedTabbar: UITabBar {
    
    private var shape: CALayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.preapre()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.preapre()
    }
    
    func preapre() {
        self.removeSeparator()
        self.setShape()
        self.setShadow()
    }
    
    func removeSeparator() {
        self.shadowImage = UIImage()
        self.backgroundImage = UIImage()
    }
    
    func setShape() {
        let shape = self.createShape()
        if let oldShape = self.shape {
            self.layer.replaceSublayer(oldShape, with: shape)
        }else{
            self.layer.insertSublayer(shape, at: 0)
        }
        self.shape = shape
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.08
        self.layer.shadowRadius = 20
    }
    
    func createShape() -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = createCurvedPath().cgPath
        shape.strokeColor = UIColor.clear.cgColor
        shape.fillColor = UIColor.white.cgColor
        shape.lineWidth = 0
        return shape
    }
        
    func createCurvedPath() -> UIBezierPath {
        let corners:  UIRectCorner = [.topLeft, .topRight]
        let radius: CGSize = CGSize(width: 25, height: 25)
        return .init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radius)
    }
}
