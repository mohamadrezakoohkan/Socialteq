//
//  Registerable.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UINib

/// This property delegate provide registration method
///
/// Currently conforms to UITableViewCells only
///
@propertyWrapper
struct Registerable<Value> {
    
    private let id: String
    var value: Value
    let wrappedValue: Value
    
    
    init(wrappedValue: Value) {
        self.id = String(describing: wrappedValue)
        self.value = wrappedValue
        self.wrappedValue = wrappedValue
    }
    
    func register(in tableView: UITableView) {
        let nib = UINib(nibName: self.id, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: self.id)
    }

}
