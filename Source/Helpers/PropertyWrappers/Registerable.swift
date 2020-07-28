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
        
    private var nib: UINib {
        return UINib(nibName: self.id, bundle: .main)
    }
    
    init(wrappedValue: Value) {
        self.id = String(describing: wrappedValue)
        self.value = wrappedValue
        self.wrappedValue = wrappedValue
    }
    
    func registerReusableView(in collectionView: UICollectionView) {
        let kind: String = UICollectionView.elementKindSectionHeader
        collectionView.register(self.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.id)
    }

    func registerCell(in collectionView: UICollectionView) {
        collectionView.register(self.nib, forCellWithReuseIdentifier: self.id)
    }
    

}
