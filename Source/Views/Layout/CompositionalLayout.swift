//
//  CompositionalLayout.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

class CompositionalLayout: UICollectionViewCompositionalLayout {
    
    class var sectionInset: NSDirectionalEdgeInsets {
        return .zero
    }
    
    class var groupInset: NSDirectionalEdgeInsets {
        return .zero
    }
    
    class var itemInset: NSDirectionalEdgeInsets {
       return .zero
    }
    
    class var headerInset: NSDirectionalEdgeInsets {
        return .zero
    }
    
    class func sectionProvider(group: NSCollectionLayoutGroup, supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = [], modificationBlock block: ((NSCollectionLayoutSection) -> ())? = nil) -> NSCollectionLayoutSection {
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.boundarySupplementaryItems = supplementaryItems
        section.contentInsets = sectionInset
        block?(section)
        return section
    }
    
    class func groupProvider(size: NSCollectionLayoutSize, item: NSCollectionLayoutItem, modificationBlock block: ((NSCollectionLayoutGroup) -> ())? = nil) -> NSCollectionLayoutGroup {
        
        let group: NSCollectionLayoutGroup = .horizontal(layoutSize: size, subitems: [item])
        group.contentInsets = groupInset
        block?(group)
        return group
    }
    
    class func itemProvider(size: NSCollectionLayoutSize, modificationBlock block: ((NSCollectionLayoutItem) -> ())? = nil) -> NSCollectionLayoutItem {
        
        let item: NSCollectionLayoutItem = .init(layoutSize: size)
        item.contentInsets = itemInset
        block?(item)
        return item
    }
    
    class func headerProvider(size: NSCollectionLayoutSize, alignment: NSRectAlignment = .topLeading, modificationBlock block: ((NSCollectionLayoutBoundarySupplementaryItem) -> ())? = nil) -> NSCollectionLayoutBoundarySupplementaryItem{
        
        let supplementaryView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionHeader, alignment: alignment)
        supplementaryView.contentInsets = self.headerInset
        block?(supplementaryView)
        return supplementaryView
    }
    
}



