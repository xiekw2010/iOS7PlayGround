//
//  DXNavPushPhotoTransition.m
//  UICategories
//
//  Created by xiekw on 10/23/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "DXNavPushPhotoTransition.h"
#import "NavPhotoTransitionProtocol.h"
#import "ThumbnailCollectionViewCell.h"

@implementation DXNavPushPhotoTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Get the container view - where the animation has to happen
    UIView *containerView = [transitionContext containerView];
    
    // Add the two VC views to the container. Hide the to
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    id<NavPhotoTransitionFromVCProtocol> pfromVC = (id<NavPhotoTransitionFromVCProtocol>)fromVC;
    id<NavPhotoTransitionToVCProtocol> pToVC = (id<NavPhotoTransitionToVCProtocol>)toVC;

    ThumbnailCollectionViewCell *thumbnailCell = pfromVC.selectCell;
    CGRect thumbnailCellFrame = [pfromVC.collectionView convertRect:thumbnailCell.frame toView:fromVC.view];
    
    if (!pToVC.imageView) {
        pToVC.imageView = [[UIImageView alloc] init];
    }
    pToVC.imageView.image = pfromVC.bigImage;
    pToVC.imageView.frame = thumbnailCellFrame;
    [toVC.view addSubview:pToVC.imageView];
    [thumbnailCell removeFromSuperview];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:25 options:0 animations:^{
        
        fromVC.view.alpha = 0.0;
        CGRect toVCViewFrame = toVC.view.frame;
        CGSize bigImageSize = pfromVC.bigImage.size;
        pToVC.imageView.frame = centerFrameWithContainerAndImageSize(toVCViewFrame.size, bigImageSize);
        
    } completion:^(BOOL finished) {
        
        fromVC.view.alpha = 1.0;
        [fromVC.view removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
