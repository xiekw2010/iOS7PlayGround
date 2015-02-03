//
//  CustomCollectionViewController.swift
//  UICategories
//
//  Created by xiekw on 1/26/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

import UIKit

@objc class CustomCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {

    let cellIdentifier: String = "cellId"
    
    var collectionView: UICollectionView!
    var photos: [DXPhoto]!
    var pinch: UIPinchGestureRecognizer!
    var rotate: UIRotationGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customLayout = SimpleLayout()
        customLayout.itemSize = CGSizeMake(150.0, 150.0)
        customLayout.minimumInteritemSpacing = 5.0
        customLayout.minimumLineSpacing = 5.0
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        photos = DXPhoto.photos() as [DXPhoto]
        
        collectionView.registerClass(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        pinch = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
        collectionView.addGestureRecognizer(pinch)
        
        rotate = UIRotationGestureRecognizer(target: self, action: "hanldeRotate:")
        collectionView.addGestureRecognizer(rotate)
        
        pinch.delegate = self
        rotate.delegate = self
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func handlePinch(pinch: UIPinchGestureRecognizer) {
        let simpleLayout = collectionView.collectionViewLayout as SimpleLayout
        switch pinch.state {
        case UIGestureRecognizerState.Began:
            let pinchP = pinch.locationInView(collectionView)
            let pinchPath = collectionView.indexPathForItemAtPoint(pinchP)
            simpleLayout.pinchedCellPath = pinchPath
        case UIGestureRecognizerState.Changed:
            simpleLayout.pinchedCellCenter = pinch.locationInView(collectionView)
            simpleLayout.pinchedCellScale = pinch.scale
        default:
            collectionView.performBatchUpdates({ () -> Void in
                simpleLayout.resetHandleAttributeState()
            }, completion: nil)
        }
    }
    
    func hanldeRotate(rotate: UIRotationGestureRecognizer) {
        let simpleLayout = collectionView.collectionViewLayout as SimpleLayout
        switch rotate.state {
        case UIGestureRecognizerState.Changed:
            simpleLayout.rotationAngle = rotate.rotation
        default:
            return
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as ThumbnailCollectionViewCell
        let image = photos[indexPath.row].thumbnail
        cell.imageView.image = image
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
