//
//  DXPresentationExampleTransition.h
//  UICategories
//
//  Created by xiekw on 10/27/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DXPresentationOperation) {
    DXPresentationOperationPresent,
    DXPresentationOperationDimiss,
};

@interface DXPresentationExampleTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) DXPresentationOperation presentOperation;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *pctInteractive;

- (void)attachGestureToDismissViewController:(UIViewController *)controller;
- (void)detachGestureDismiss;

@end
