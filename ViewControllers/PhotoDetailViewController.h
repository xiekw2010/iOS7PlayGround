//
//  PhotoDetailViewController.h
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavPhotoTransitionProtocol.h"

@class DXPhoto;
@interface PhotoDetailViewController : UIViewController<NavPhotoTransitionToVCProtocol>

@property (nonatomic, strong) DXPhoto *photo;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end
