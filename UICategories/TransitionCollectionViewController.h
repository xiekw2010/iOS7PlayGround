//
//  TransitionCollectionViewController.h
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavPhotoTransitionProtocol.h"

@interface TransitionCollectionViewController : UICollectionViewController<NavPhotoTransitionFromVCProtocol>

@property (nonatomic, strong) ThumbnailCollectionViewCell *selectCell;
@property (nonatomic, strong) UIImage *bigImage;

@end
