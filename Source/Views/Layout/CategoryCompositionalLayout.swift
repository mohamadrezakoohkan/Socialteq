//
//  CategoryCompositionalLayout.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class CategoryCompositionalLayout: CompositionalLayout {
    
    private static let horizontalSpace: CGFloat = 24
    private static let verticalSectionSpace: CGFloat = 32

    override class var sectionInset: NSDirectionalEdgeInsets {
        return .init(top: 0, leading: horizontalSpace, bottom: verticalSectionSpace, trailing: 0)
    }
    
    override class var groupInset: NSDirectionalEdgeInsets {
        return .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    override class var itemInset: NSDirectionalEdgeInsets {
        return .init(top: 0, leading: 0, bottom: 0, trailing: horizontalSpace)
    }
    

    private static var eventItemSize: NSCollectionLayoutSize {
        return .init(widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
    }
    
    private static var eventGroupSize: NSCollectionLayoutSize {
        return .init(widthDimension: .fractionalWidth(1),
                     heightDimension: .estimated(200))
    }
    
    private static var serviceItemSize: NSCollectionLayoutSize {
        let width: NSCollectionLayoutDimension = UIDevice.isLandscape || UIDevice.isIpad
            ? .absolute(171 + horizontalSpace)
            : .fractionalWidth(0.5)
        return .init(widthDimension: width,
                     heightDimension: .fractionalHeight(1))
    }
    
    private static var serviceGroupSize: NSCollectionLayoutSize {
        return .init(widthDimension: .fractionalWidth(1),
                     heightDimension: .absolute(196 + horizontalSpace))
    }
    
    static func createLayout() -> CategoryCompositionalLayout {
        CategoryCompositionalLayout { (section, environment) in
            switch section {
            case .firstIndex:
                return eventSectionLayout()
            default:
                return serviceSectionLayout()

            }
        }
    }
    
    private static func eventSectionLayout() -> NSCollectionLayoutSection {
        let item = itemProvider(size: eventItemSize)
        let group = groupProvider(size: eventGroupSize, item: item)
        return sectionProvider(group: group) {
            $0.contentInsets.top = verticalSectionSpace
        }
    }
    
    private static func serviceSectionLayout() -> NSCollectionLayoutSection {
        let item = itemProvider(size: serviceItemSize)
        let group = groupProvider(size: serviceGroupSize, item: item)
        group.contentInsets.bottom = horizontalSpace
        return sectionProvider(group: group) {
            $0.contentInsets.bottom = verticalSectionSpace - horizontalSpace
        }
    }

            
}
