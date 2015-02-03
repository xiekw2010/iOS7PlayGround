//
//  SimpleLayout.swift
//  UICategories
//
//  Created by xiekw on 1/27/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

/*
1. add new kinds of views
2. Tweak layout attributes
3. add new layout attributes
4. add gesture support
*/


import UIKit

class SimpleLayout: UICollectionViewFlowLayout {
    
    var pinchedCellPath: NSIndexPath!
    var pinchedCellScale: CGFloat = 1.0 {
        didSet {
            invalidateLayout()
        }
    }
    var pinchedCellCenter: CGPoint = CGPoint() {
        didSet {
            invalidateLayout()
        }
    }
    var rotationAngle: CGFloat = 0.0 {
        didSet {
            invalidateLayout()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        let attributes = super.layoutAttributesForElementsInRect(rect) as [UICollectionViewLayoutAttributes]
        for atr in attributes {
            applyPinchToLayoutAttributes(atr)
        }
        return attributes
    }
   
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let atr = super.layoutAttributesForItemAtIndexPath(indexPath)
        applyPinchToLayoutAttributes(atr)
        return atr
    }
    
    private func applyPinchToLayoutAttributes(atr: UICollectionViewLayoutAttributes) {
        if atr.indexPath.isEqual(pinchedCellPath) {
            atr.transform3D = CATransform3DMakeScale(pinchedCellScale, pinchedCellScale, 1.0)
//            atr.transform3D = CATransform3DMakeRotation(rotationAngle, 0.0, 0.0, 1.0)
            atr.center = pinchedCellCenter
            atr.zIndex = 1
            println("rotation angle is \(rotationAngle) pinch scale is \(pinchedCellScale) and atr.transform is \(atr)")
        }
    }
    
    func resetHandleAttributeState() {
        pinchedCellScale = 1.0
        pinchedCellPath = nil
        rotationAngle = 0.0
    }
    
    
}
