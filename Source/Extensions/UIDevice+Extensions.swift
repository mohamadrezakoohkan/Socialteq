//
//  UIDevice+Idiom.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var isIpad: Bool {
        return self.userInterfaceIdiom == .pad
    }
    
    var isIphone: Bool {
        return self.userInterfaceIdiom == .phone
    }
    
    class var isLandscape: Bool {
        let window = UIApplication.shared.windows.first
        let windowScene = window?.windowScene
        let orientation = windowScene?.interfaceOrientation
        return orientation?.isLandscape == true
    }
}

