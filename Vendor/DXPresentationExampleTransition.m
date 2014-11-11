//
//  DXPresentationExampleTransition.m
//  UICategories
//
//  Created by xiekw on 10/27/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "DXPresentationExampleTransition.h"

@interface DXPresentationExampleTransition ()

@property (nonatomic, strong) UIPanGestureRecognizer *panG;
@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation DXPresentationExampleTransition

- (void)dealloc
{
    [self detachGestureDismiss];
}

- (void)attachGestureToDismissViewController:(UIViewController *)controller
{
    self.viewController = controller;
    self.panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.viewController.view addGestureRecognizer:self.panG];
}

- (void)detachGestureDismiss
{
    [self.viewController.view removeGestureRecognizer:self.panG];
    self.panG = nil;
    self.pctInteractive = nil;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    UIView* view = self.viewController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.y >  CGRectGetMidY(view.bounds)) {
            self.pctInteractive = [UIPercentDrivenInteractiveTransition new];
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.y / CGRectGetHeight(view.bounds));
        [self.pctInteractive updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat yVelocity = [recognizer velocityInView:view].y;
        
        if (yVelocity < 0) {
            [self.pctInteractive finishInteractiveTransition];
        } else {
            [self.pctInteractive cancelInteractiveTransition];
        }
        self.pctInteractive = nil;
    }
}


// duration of animation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Get the container view - where the animation has to happen
    UIView *containerView = [transitionContext containerView];
    
    
    if (self.presentOperation == DXPresentationOperationPresent) {
        [containerView addSubview:fromVC.view];
        [containerView addSubview:toVC.view];
        
        //make some animation here
        toVC.view.alpha = 0.0;
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(toVC.view.bounds));
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.alpha = 1.0;
            toVC.view.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else {
        [containerView addSubview:toVC.view];
        [containerView addSubview:fromVC.view];
        
        //make some animation here
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(fromVC.view.bounds));
            fromVC.view.alpha = 0.1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}


@end
