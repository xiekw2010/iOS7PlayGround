//
//  LineFlowLayout.swift
//  UICategories
//
//  Created by xiekw on 1/27/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

import UIKit

class LineFlowLayout: UICollectionViewFlowLayout {
    
    let cellItemSize: CGSize = CGSizeMake(80.0, 80.0)
    let activeDistance: CGFloat = 200.0
    let zoomFactor: CGFloat = 0.4
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        itemSize = cellItemSize
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        sectionInset = UIEdgeInsetsMake(100.0, 0.0, 0.0, 100.0)
        minimumLineSpacing = 35.0
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        let superAttributes = super.layoutAttributesForElementsInRect(rect) as [UICollectionViewLayoutAttributes]
        let visibleBounds = collectionView?.bounds
        for atr in superAttributes {
            if CGRectIntersectsRect(atr.frame, rect) {
                let distance = CGRectGetMidX(atr.frame) - CGRectGetMidX(visibleBounds!)
                let normlizedDistance = abs(distance / activeDistance)
                if abs(distance) < activeDistance {
                    let zoom = 1 + zoomFactor * (1.0 - normlizedDistance)
                    atr.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0)
                }
            }
        }
        return superAttributes
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var adjust: CGFloat = CGFloat.max
        let midx = proposedContentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
        let targetRect = CGRect(origin: CGPointMake(proposedContentOffset.x, 0.0), size: collectionView!.bounds.size)
        let atrsInTarget = super.layoutAttributesForElementsInRect(targetRect) as [UICollectionViewLayoutAttributes]
        for atr in atrsInTarget {
            let atrCenter = atr.center.x
            if (abs(atrCenter - midx) < abs(adjust)) {
                adjust = atrCenter - midx
            }
        }
        return CGPoint(x: (proposedContentOffset.x + round(adjust)), y: proposedContentOffset.y)
    }
}
