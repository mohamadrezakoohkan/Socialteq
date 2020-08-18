//
//  UIFont+AppFonts.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIFont

extension UIFont {

    private class var globalFontSize: CGFloat {
        return 17
    }

    class func bold(size: CGFloat = globalFontSize) -> UIFont {
       return UIFont(name: "Poppins-Bold", size: size)!
    }

    class func semiBold(size: CGFloat = globalFontSize) -> UIFont {
       return UIFont(name: "Poppins-SemiBold", size: size)!
    }

    class func medium(size: CGFloat = globalFontSize) -> UIFont {
       return UIFont(name: "Poppins-Medium", size: size)!
    }

    class func regular(size: CGFloat = globalFontSize) -> UIFont {
       return UIFont(name: "Poppins-Regular", size: size)!
    }

    class func light(size: CGFloat = globalFontSize) -> UIFont {
       return UIFont(name: "Poppins-Light", size: size)!
    }

    class func lightItalic(size: CGFloat = globalFontSize) -> UIFont {
       return UIFont(name: "Poppins-LightItalic", size: size)!
    }

}
