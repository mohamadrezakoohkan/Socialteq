//
//  TypeIdentifiable.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

protocol TypeIdentifiable {
    
    static var identifier: String { get }
}

extension TypeIdentifiable where Self: UITableViewCell {
    
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UITableViewCell: TypeIdentifiable { }
