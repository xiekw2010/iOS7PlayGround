//
//  NavPhotoTransitionProtocol.h
//  UICategories
//
//  Created by xiekw on 10/23/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DXPhoto;
@class ThumbnailCollectionViewCell;

@protocol NavPhotoTransitionFromVCProtocol <NSObject>

@property (nonatomic, strong) ThumbnailCollectionViewCell *selectCell;
@property (nonatomic, strong) UIImage *bigImage;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@protocol NavPhotoTransitionToVCProtocol <NSObject>

@property (nonatomic, strong) UIImageView *imageView;

@end
