//
//  LoadingImageView.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class LoadingImageView: UIImageView {
    
    final var isLoading: Bool {
        return self.activityIndicator.isAnimating
    }
    
    @IBInspectable
    final var activityIndicatorColor: UIColor = .appSecondary {
        didSet {
            self.activityIndicator.color = self.activityIndicatorColor
        }
    }
    
    final var activityIndicatorSyle: UIActivityIndicatorView.Style = .medium {
        didSet {
            self.activityIndicator.style = self.activityIndicatorSyle
        }
    }
    
    override var image: UIImage? {
        didSet {
            self.controlActivityIndicator()
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = self.activityIndicatorSyle
        indicator.color = self.activityIndicatorColor
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addActivityIndicator()
        self.autolayoutActivityIndicator()
        self.controlActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addActivityIndicator()
        self.autolayoutActivityIndicator()
        self.controlActivityIndicator()
    }
    
    private func controlActivityIndicator() {
        DispatchQueue.main.async {
            
            self.image == nil ? self.start() : self.stop()
        }
        
    }
    
    private func start() {
        self.activityIndicator.startAnimating()
    }
    
    private func stop() {
        self.activityIndicator.stopAnimating()
    }
    
    private func addActivityIndicator() {
        self.addSubview(self.activityIndicator)
    }
    
    private func autolayoutActivityIndicator() {
        self.activityIndicator.constraintCenter(in: self)
    }
    
}
