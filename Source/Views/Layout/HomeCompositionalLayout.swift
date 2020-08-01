//
//  HomeCompositionalLayout.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class HomeCompositionalLayout: CompositionalLayout {
    
    private static let horizontalSpace: CGFloat = 24
    private static let verticalSectionSpace: CGFloat = 32
    private static let headerSpaceFromGroup: CGFloat = 16

    override class var sectionInset: NSDirectionalEdgeInsets {
        return .init(top: 0, leading: horizontalSpace, bottom: verticalSectionSpace, trailing: 0)
    }
    
    override class var groupInset: NSDirectionalEdgeInsets {
        return .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    override class var itemInset: NSDirectionalEdgeInsets {
        return .init(top: 0, leading: 0, bottom: 0, trailing: horizontalSpace)
    }
    
    override class var headerInset: NSDirectionalEdgeInsets {
        return .init(top: 0, leading: 0, bottom: headerSpaceFromGroup, trailing: 0)
    }
    

    private static var eventItemSize: NSCollectionLayoutSize {
        return .init(widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
    }
    
    private static var eventGroupSize: NSCollectionLayoutSize {
        return .init(widthDimension: .fractionalWidth(1),
                     heightDimension: .estimated(95))
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
                     heightDimension: .absolute(190 + horizontalSpace))
    }
    
    private static var promotionItemSize: NSCollectionLayoutSize {
        return .init(widthDimension: .fractionalWidth(1),
                     heightDimension: .fractionalHeight(1))
    }
    
    private static var promotionGroupSize: NSCollectionLayoutSize {
        let width: NSCollectionLayoutDimension = UIDevice.isLandscape || UIDevice.isIpad
            ? .absolute(330 + horizontalSpace)
            : .fractionalWidth(0.85)
        return .init(widthDimension: width,
                     heightDimension: .absolute(140))
    }
    
    private static var supplementaryViewSize: NSCollectionLayoutSize {
        return .init(widthDimension: .fractionalWidth(1),
                     heightDimension: .absolute(20 + headerSpaceFromGroup))
    }
    
    static func createLayout() -> HomeCompositionalLayout {
        HomeCompositionalLayout { (section, environment) in
            switch section {
            case .firstIndex:
                return eventSectionLayout()
            case .secondIndex:
                return serviceSectionLayout()
            default:
                return promotionSectionLayout()

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
        let supplimentaryItem = headerProvider(size: supplementaryViewSize)
        return sectionProvider(group: group, supplementaryItems: [supplimentaryItem]) {
            $0.contentInsets.bottom = verticalSectionSpace - horizontalSpace
        }
    }
    
    private static func promotionSectionLayout() -> NSCollectionLayoutSection {
        let item = itemProvider(size: promotionItemSize)
        let group = groupProvider(size: promotionGroupSize, item: item)
        let supplimentaryItem = headerProvider(size: supplementaryViewSize)
        return sectionProvider(group: group, supplementaryItems: [supplimentaryItem]) {
            $0.orthogonalScrollingBehavior = .paging
        }
    }
            
}
