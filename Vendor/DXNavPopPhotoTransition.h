//
//  DXNavPopPhotoTransition.h
//  UICategories
//
//  Created by xiekw on 10/23/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavPhotoTransitionProtocol.h"


@interface DXNavPopPhotoTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *pctInteractive;


- (void)attachGesturePopToNavigationViewController:(id<NavPhotoTransitionToVCProtocol>)nav;
- (void)detachGesturePop;

@end
