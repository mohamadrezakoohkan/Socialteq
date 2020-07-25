//
//  UIDevice+Idiom.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIDevice

extension UIDevice {
    
    var isIpad: Bool {
        return self.userInterfaceIdiom == .pad
    }
    
    var isIphone: Bool {
        return self.userInterfaceIdiom == .phone
    }
}
