//
//  PathSheetTransition.h
//  UICategories
//
//  Created by xiekw on 12/1/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PathSheetPresentOperation) {
    PathSheetPresentOperationPresent,
    PathSheetPresentOperationDismiss,
};

@interface PathSheetTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) PathSheetPresentOperation presentOperation;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *pctInteractive;

- (void)attachGestureToDismissViewController:(UIViewController *)controller;
- (void)detachGestureDismiss;

@end
