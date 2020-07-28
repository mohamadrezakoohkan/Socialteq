//
//  RoundedView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    private var corners: Set<UInt> = []
    private let shadowColor: UIColor = UIColor.black
    private let shadowOpacity: Float = 0.08
    private let shadowRadius: CGFloat = 20
    
    @IBInspectable
    var isShadowEnabled: Bool = true {
        didSet {
            self.layer.masksToBounds = !self.isShadowEnabled
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    var topLeft: Bool = false {
        didSet {
            self.insert(cornerRawValue: 1, activationSignal: self.topLeft)
        }
    }
    
    @IBInspectable
    var topRight: Bool = false {
        didSet {
            self.insert(cornerRawValue: 2, activationSignal: self.topRight)
        }
    }
    
    @IBInspectable
    var bottomLeft: Bool = false {
        didSet {
            self.insert(cornerRawValue: 4, activationSignal: self.bottomLeft)
        }
    }
    
    @IBInspectable
    var bottomRight: Bool = false {
        didSet {
            self.insert(cornerRawValue: 8, activationSignal: self.bottomRight)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setShadow()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setMaskedCorners()
    }
    
    func setShadow() {
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.masksToBounds = !self.isShadowEnabled
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowRadius = self.shadowRadius
    }
    
    private func insert(cornerRawValue corner: UInt, activationSignal signal: Bool) {
        guard signal else {
            self.corners.remove(corner)
            return
        }
        self.corners.insert(corner)
    }
    
    private func setMaskedCorners() {
        let corners = Array(self.corners)
        switch corners.count {
        case 0:
            self.layer.maskedCorners = []
        case 1:
            self.layer.maskedCorners = [
                .init(rawValue: corners[0])
            ]
        case 2:
            self.layer.maskedCorners = [
                .init(rawValue: corners[0]),
                .init(rawValue: corners[1])
            ]
        case 3:
            self.layer.maskedCorners = [
                .init(rawValue: corners[0]),
                .init(rawValue: corners[1]),
                .init(rawValue: corners[2])
            ]
        case 4:
            self.layer.maskedCorners = [
                .init(rawValue: corners[0]),
                .init(rawValue: corners[1]),
                .init(rawValue: corners[2]),
                .init(rawValue: corners[3]),
            ]
        default:
            fatalError("Received more than requested values")
        }
        
    }
}
