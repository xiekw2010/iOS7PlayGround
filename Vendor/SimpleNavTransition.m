//
//  NavPhotosToDetailPhotoTransition.m
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "SimpleNavTransition.h"

@interface SimpleNavTransition ()

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, weak) UINavigationController *nav;

@end

@implementation SimpleNavTransition

- (void)dealloc
{
    [self detachGesturePop];
}

- (instancetype)initWithNavigationOperation:(UINavigationControllerOperation)operation
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.navOp = operation;
    
    return self;
}

- (void)attachGesturePopToNavigationViewController:(UINavigationController *)nav
{
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.nav = nav;
    [self.nav.view addGestureRecognizer:self.pan];
}

- (void)detachGesturePop
{
    [self.nav.view removeGestureRecognizer:self.pan];
    self.nav = nil;
    self.pan = nil;
    self.pctInteractive = nil;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    UIView* view = self.nav.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.x <  CGRectGetMidX(view.bounds) && self.nav.viewControllers.count > 1) {// left half
            
            self.pctInteractive = [UIPercentDrivenInteractiveTransition new];
            [self.nav popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        NSLog(@"recognizer is %f", d);
        [self.pctInteractive updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.pctInteractive finishInteractiveTransition];
        } else {
            [self.pctInteractive cancelInteractiveTransition];
        }
        self.pctInteractive = nil;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    // Get the two view controllers
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Get the container view - where the animation has to happen
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    
    // Add the two VC views to the container. Hide the to
    
    if (self.navOp == UINavigationControllerOperationPop) {
        [containerView addSubview:toVC.view];
        [containerView addSubview:fromVC.view];
        
        toVC.view.backgroundColor = [UIColor redColor];
        
        CGRect toVCFrame = toVC.view.frame;
        toVCFrame.origin.x -= 100.0;
        toVC.view.frame = toVCFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toVC.view.backgroundColor = [UIColor blueColor];
            
            CGRect fromVcRect = fromVC.view.frame;
            fromVcRect.origin.x = CGRectGetMaxX(fromVcRect);
            fromVC.view.frame = fromVcRect;
            
            toVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(toVCFrame), CGRectGetHeight(toVCFrame));
            
        } completion:^(BOOL finished) {
            
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else if (self.navOp == UINavigationControllerOperationPush) {
        [containerView addSubview:fromVC.view];
        [containerView addSubview:toVC.view];
        CGRect toVCFrame = toVC.view.frame;
        toVCFrame.origin.x += CGRectGetWidth(containerView.bounds);
        toVC.view.frame = toVCFrame;
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]*0.8 delay:0.0 usingSpringWithDamping:350 initialSpringVelocity:30 options:kNilOptions animations:^{
            toVC.view.frame = containerView.bounds;
        } completion:^(BOOL finished) {
            
        }];
        
        __block CGRect fromVCFrame = fromVC.view.frame;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromVCFrame.origin.x -= CGRectGetWidth(containerView.bounds);
            fromVC.view.frame = fromVCFrame;
            fromVC.view.backgroundColor = [UIColor orangeColor];
            
        } completion:^(BOOL finished) {
            fromVCFrame.origin.x += CGRectGetWidth(containerView.bounds);
            fromVC.view.frame = fromVCFrame;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }

}

@end
