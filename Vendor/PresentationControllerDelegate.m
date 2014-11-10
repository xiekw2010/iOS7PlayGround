//
//  PresentationControllerDelegate.m
//  UICategories
//
//  Created by xiekw on 10/27/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "PresentationControllerDelegate.h"
#import "DXPresentationExampleTransition.h"

@interface PresentationControllerDelegate ()

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation PresentationControllerDelegate

- (id)initWithViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        self.viewController = viewController;
        self.viewController.modalPresentationStyle = UIModalPresentationCustom;
        self.viewController.transitioningDelegate = self;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    DXPresentationExampleTransition *animator = [DXPresentationExampleTransition new];
    animator.presenting = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    DXPresentationExampleTransition *animator = [DXPresentationExampleTransition new];
    return animator;
}

@end
