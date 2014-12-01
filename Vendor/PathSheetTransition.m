//
//  PathSheetTransition.m
//  UICategories
//
//  Created by xiekw on 12/1/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "PathSheetTransition.h"
#import <FBPop/POP.h>

@interface PathSheetTransition ()

@property (nonatomic, strong) UIPanGestureRecognizer *panG;
@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation PathSheetTransition

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
    
    if (self.presentOperation == PathSheetPresentOperationPresent) {
        
        UIViewController *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        
        // Get the container view - where the animation has to happen
        UIView *containerView = [transitionContext containerView];
        containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        // Add the two VC views to the container. Hide the to
        
        toView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        [containerView addSubview:fromView.view];
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }else {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
        toVC.view.userInteractionEnabled = YES;
        
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        __block UIView *dimmingView;
        [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            if (view.layer.opacity < 1.f) {
                dimmingView = view;
                *stop = YES;
            }
        }];
        POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        opacityAnimation.toValue = @(0.0);
        
        POPBasicAnimation *offscreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        offscreenAnimation.toValue = @(-fromVC.view.layer.position.y);
        [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        [fromVC.view.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
        [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    }
}


@end
