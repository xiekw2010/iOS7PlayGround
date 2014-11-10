//
//  NavPhotosToDetailPhotoTransition.h
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleNavTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UINavigationControllerOperation navOp;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *pctInteractive;

- (instancetype)initWithNavigationOperation:(UINavigationControllerOperation)operation;

- (void)attachGesturePopToNavigationViewController:(UINavigationController *)nav;
- (void)detachGesturePop;

@end
