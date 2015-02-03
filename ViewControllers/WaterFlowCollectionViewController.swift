//
//  WaterFlowCollectionViewController.swift
//  UICategories
//
//  Created by xiekw on 1/28/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

import UIKit


class WaterFlowCollectionViewController: UICollectionViewController, DXWaterFlowLayoutDelegate {

    var photos: [DXPhoto]!
    let waterCellId: String = "waterCellId"
    var cellWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerClass(WaterFlowCollectionViewCell.self, forCellWithReuseIdentifier: waterCellId)
        let waterLayout = self.collectionView?.collectionViewLayout as DXWaterFlowLayout
        cellWidth = CGRectGetWidth(collectionView!.frame) * 0.3
        waterLayout.itemWidth = cellWidth
        waterLayout.sectionInset = UIEdgeInsetsMake(10.0, 5.0, 5.0, 5.0)
        waterLayout.minumInterItemSpacing = 10.0
        waterLayout.lineSpacing = 10.0
        waterLayout.waterFlowDelegate = self

        photos = DXPhoto.photos() as [DXPhoto]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func collectionView(collectionView: UICollectionView, layout: DXWaterFlowLayout, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let photo = photos[indexPath.item]
        let result = WaterFlowCellSuggestHeight(photo.display, photo.photoDes, cellWidth)
        return result
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(waterCellId, forIndexPath: indexPath) as WaterFlowCollectionViewCell
    
        cell.photo = photos[indexPath.item]
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
