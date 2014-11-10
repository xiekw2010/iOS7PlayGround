//
//  DXPresentationExampleTransition.m
//  UICategories
//
//  Created by xiekw on 10/27/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "DXPresentationExampleTransition.h"

@implementation DXPresentationExampleTransition

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
    
    
    if (self.presenting) {
        // Add the two VC views to the container. Hide the to
        [containerView addSubview:toVC.view];
        [containerView addSubview:fromVC.view];
        
        
        //make some animation here
        
        fromVC.view.backgroundColor = [UIColor redColor];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromVC.view.backgroundColor = [UIColor redColor];
            fromVC.view.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            [fromVC.view removeFromSuperview];
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else {
        [containerView addSubview:toVC.view];
        [containerView addSubview:fromVC.view];

        
        //make some animation here
        
        fromVC.view.backgroundColor = [UIColor redColor];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromVC.view.backgroundColor = [UIColor blueColor];
            
        } completion:^(BOOL finished) {
            [fromVC.view removeFromSuperview];

            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
}


@end
