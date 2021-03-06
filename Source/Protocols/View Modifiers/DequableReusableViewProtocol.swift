//
//  DequableProtocol.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/7/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

protocol DequableReusableViewProtocol: UICollectionReusableView {

    static func deque(in collectionView: UICollectionView, at indexPath: IndexPath, of kind: String, id identifier: String, modificationBlock block: ((Self) -> Void)?) -> Self

    static func transform(_ view: UICollectionReusableView, completion: @escaping (Self) -> Void)

}

extension DequableReusableViewProtocol where Self: IdentifiableProtocol {

    static func deque(in collectionView: UICollectionView,
                      at indexPath: IndexPath,
                      of kind: String,
                      id identifier: String = identifier,
                      modificationBlock block: ((Self) -> Void)? = nil) -> Self {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,  withReuseIdentifier: identifier, for: indexPath) as? Self else {
            fatalError("Could not deque reusable view with identifier: \(self.identifier)")
        }
        block?(view)
        return view
    }

    static func transform(_ reusableView: UICollectionReusableView, completion: @escaping (Self) -> Void) {
        guard let view = reusableView as? Self else {
            fatalError("Could not transform \(String(describing: reusableView))")
        }
        completion(view)
    }

}
