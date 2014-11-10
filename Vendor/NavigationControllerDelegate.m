//
//  NavigationControllerDelegate.m
//  UICategories
//
//  Created by xiekw on 10/23/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "SimpleNavTransition.h"
#import "TransitionCollectionViewController.h"
#import "PhotoDetailViewController.h"
#import "DXNavPushPhotoTransition.h"
#import "ViewController.h"
#import "NavPhotoTransitionProtocol.h"
#import "DXNavPopPhotoTransition.h"

@interface NavigationControllerDelegate ()
{
}

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;
@property (nonatomic, weak) UINavigationController *nav;
@property (nonatomic, strong) SimpleNavTransition *popToRootAnimator;
@property (nonatomic, strong) DXNavPushPhotoTransition *pushToPhotoAnimator;
@property (nonatomic, strong) DXNavPopPhotoTransition *popToPhotoAnimator;
@property (nonatomic, weak) UIViewController *currentViewController;

@end

@implementation NavigationControllerDelegate

- (id)initWithNavigationViewController:(UINavigationController *)nav;
{
    if (self=[super init]) {
        self.nav = nav;
        self.nav.delegate = self;
        
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.nav.view addGestureRecognizer:panRecognizer];
        
        self.popToRootAnimator = [SimpleNavTransition new];
        self.pushToPhotoAnimator = [DXNavPushPhotoTransition new];
        self.popToPhotoAnimator = [DXNavPopPhotoTransition new];
    }
    return self;
}

- (BOOL)shouldHandlePan
{
    if ([self.currentViewController isKindOfClass:[TransitionCollectionViewController class]]) {
        return YES;
    }
    return NO;
}

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    if (![self shouldHandlePan]) {
        return;
    }
    UIView* view = self.nav.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.x <  CGRectGetMidX(view.bounds) && self.nav.viewControllers.count > 1) {// left half

            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self.nav popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.currentViewController = viewController;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation==UINavigationControllerOperationPop && [fromVC isKindOfClass:[TransitionCollectionViewController class]]) {
        return self.popToRootAnimator;
    }else if (operation==UINavigationControllerOperationPush && [fromVC conformsToProtocol:@protocol(NavPhotoTransitionFromVCProtocol)] && [toVC conformsToProtocol:@protocol(NavPhotoTransitionToVCProtocol)]) {
        return self.pushToPhotoAnimator;
    }else if (operation==UINavigationControllerOperationPop && [fromVC conformsToProtocol:@protocol(NavPhotoTransitionToVCProtocol)] && [toVC conformsToProtocol:@protocol(NavPhotoTransitionFromVCProtocol)]){
        return self.popToPhotoAnimator;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (self.popToRootAnimator == animationController) {
        return self.interactionController;
    }
    return nil;
}

@end
