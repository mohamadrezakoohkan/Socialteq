//
//  Storyboarded.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/6/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIStoryboard


protocol Storyboarded: UIViewController {
    
    static var id: String { get }
    
    static func instantiate(in board: UIStoryboard) -> Self
    
}

extension Storyboarded {
    
    static var id: String {
        return String(describing: self)
    }
    
    static func instantiate(in board: UIStoryboard) -> Self {
        return board.instantiateViewController(identifier: id)
    }
}
