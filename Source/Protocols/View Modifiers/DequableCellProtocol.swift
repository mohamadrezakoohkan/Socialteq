//
//  DequableCellProtocol.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

protocol DequableCellProtocol: UICollectionViewCell {
    
    
    static func deque(in collectionView: UICollectionView, at indexPath: IndexPath, id identifier: String, modificationBlock block: ((Self) -> Void)?) -> Self
    
    static func transform(_ view: UICollectionViewCell, completion: @escaping (Self) -> Void)
    
    
}

extension DequableCellProtocol where Self: IdentifiableProtocol {
        
    static func deque(in collectionView: UICollectionView, at indexPath: IndexPath, id identifier: String = identifier, modificationBlock block: ((Self) -> Void)? = nil) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Self
        block?(cell)
        return cell
    }
    
    static func transform(_ view: UICollectionViewCell, completion: @escaping (Self) -> Void) {
        completion(view as! Self)
    }
    
}

