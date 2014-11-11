//
//  DXNavPopPhotoTransition.m
//  UICategories
//
//  Created by xiekw on 10/23/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "DXNavPopPhotoTransition.h"
#import "NavPhotoTransitionProtocol.h"
#import "ThumbnailCollectionViewCell.h"
#import "TransitionCollectionViewController.h"

static CGPoint centerOfFrame(CGRect frame)
{
    return CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
}

@interface DXNavPopPhotoTransition ()<UIGestureRecognizerDelegate>
{
    CGFloat _lastScale;
    CGFloat _lastRotation;
    CGRect _selectCellFrame;
    CGRect _fakeImageViewOriginFrame;
}

@property (nonatomic, strong) UIPinchGestureRecognizer *pinchG;
@property (nonatomic, strong) UIRotationGestureRecognizer *rotateG;
@property (nonatomic, strong) UIPanGestureRecognizer *panG;
@property (nonatomic, weak) id<NavPhotoTransitionToVCProtocol> nav;
@property (nonatomic, weak) id<NavPhotoTransitionFromVCProtocol> fromNav;

@end

@implementation DXNavPopPhotoTransition


- (void)dealloc
{
    [self detachGesturePop];
}

- (void)attachGesturePopToNavigationViewController:(id<NavPhotoTransitionToVCProtocol>)nav
{
    self.nav = nav;
    self.nav.imageView.userInteractionEnabled = YES;
    
    self.pinchG = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.nav.imageView addGestureRecognizer:self.pinchG];
    
    self.rotateG = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [self.nav.imageView addGestureRecognizer:self.rotateG];
    
    self.panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.nav.imageView addGestureRecognizer:self.panG];
    
    self.pinchG.delegate = self;
    self.rotateG.delegate = self;
    self.panG.delegate = self;
}

- (void)detachGesturePop
{
    [self.nav.imageView removeGestureRecognizer:self.pinchG];
    [self.nav.imageView removeGestureRecognizer:self.rotateG];
    [self.nav.imageView removeGestureRecognizer:self.panG];

    self.pinchG.delegate = self.rotateG.delegate = self.panG.delegate = nil;
    self.pinchG = nil;
    self.rotateG = nil;
    self.panG = nil;
    self.nav = nil;
    self.fromNav = nil;
    self.pctInteractive = nil;
    _lastScale = 0.0;
    _lastRotation = 0.0;
}


- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    UIView *view = self.nav.imageView;
    UIViewController *nav = (UIViewController *)self.nav;
    UINavigationController *navNav = nav.navigationController;
    NSUInteger currentIndex = [navNav.viewControllers indexOfObject:nav];
    if (currentIndex > 1 && currentIndex != NSNotFound) {
        _fromNav = navNav.viewControllers[currentIndex-1];
    }

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
        
        if (recognizer.scale < 1.0 && nav.navigationController.viewControllers.count > 1) {
            if (!self.pctInteractive) {
                self.pctInteractive = [[UIPercentDrivenInteractiveTransition alloc] init];
                [navNav popViewControllerAnimated:YES];
            }
        }
    }
    
    CGFloat scale = 1.0 - (_lastScale - recognizer.scale);
    CGAffineTransform currentTransform = view.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    CGFloat const target = 0.99;
    CGFloat targetViewAlphaDelta = 1.2 - recognizer.scale;
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        _fromNav.collectionView.alpha = targetViewAlphaDelta;
        view.transform = newTransform;
    }else if (recognizer.state == UIGestureRecognizerStateEnded) {
        _fromNav.collectionView.alpha = 1.0;
        if (self.pinchG.scale < target) {
            [UIView animateWithDuration:0.4 animations:^{
                view.center = centerOfFrame(_selectCellFrame);
                view.transform = CGAffineTransformMakeRotation(0);
                view.bounds = CGRectMake(0, 0, _selectCellFrame.size.width, _selectCellFrame.size.height);

            } completion:^(BOOL finished) {
            }];
            [self.pctInteractive finishInteractiveTransition];
        } else {
            [self.pctInteractive cancelInteractiveTransition];
        }
        self.pctInteractive = nil;
    }
    _lastScale = recognizer.scale;
}

- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer
{
    UIView *view = self.nav.imageView;
    UIViewController *nav = (UIViewController *)self.nav;

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (recognizer.rotation != 0 && nav.navigationController.viewControllers.count > 1) {
            if (!self.pctInteractive) {
                self.pctInteractive = [[UIPercentDrivenInteractiveTransition alloc] init];
                [nav.navigationController popViewControllerAnimated:YES];
            }
        }
    }else if([recognizer state] == UIGestureRecognizerStateEnded) {
        _lastRotation = 0.0;
        
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - recognizer.rotation);
    CGAffineTransform currentTransform = view.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    [view setTransform:newTransform];
    _lastRotation = recognizer.rotation;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    if (self.pinchG.scale == 1.0) {
        return;
    }
    
    UIView *view = self.nav.imageView;

    CGPoint translation = [recognizer translationInView:view];
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                             recognizer.view.center.y + translation.y);
        
        [recognizer setTranslation:CGPointMake(0, 0) inView:view];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer==self.pinchG && otherGestureRecognizer==self.panG) {
        return NO;
    };
    return YES;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Get the container view - where the animation has to happen
    UIView *containerView = [transitionContext containerView];
    
    // Add the two VC views to the container. Hide the to
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];

    id<NavPhotoTransitionToVCProtocol> pfromVC = (id<NavPhotoTransitionToVCProtocol>)fromVC;
    id<NavPhotoTransitionFromVCProtocol> pToVC = (id<NavPhotoTransitionFromVCProtocol>)toVC;
    
    ThumbnailCollectionViewCell *thumbnailCell = pToVC.selectCell;
    CGRect thumbnailCellFrame = [pToVC.collectionView convertRect:thumbnailCell.frame toView:fromVC.view];
    _selectCellFrame = thumbnailCellFrame;
    
    UIImageView *fakeImageView = pfromVC.imageView;
    [toVC.view addSubview:fakeImageView];

    // fake image should be the big image size into the container view
    
    
    _fakeImageViewOriginFrame = centerFrameWithContainerAndImageSize(containerView.bounds.size, pToVC.bigImage.size);
    NSLog(@"fakeImageViewOriginFrame is %@", NSStringFromCGRect(_fakeImageViewOriginFrame));
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fakeImageView.center = centerOfFrame(thumbnailCellFrame);
        fakeImageView.transform = CGAffineTransformMakeRotation(0);
        fakeImageView.bounds = CGRectMake(0, 0, thumbnailCellFrame.size.width, thumbnailCellFrame.size.height);
        
    } completion:^(BOOL finished) {
        BOOL transitationCancelled = [transitionContext transitionWasCancelled];
        if (!transitationCancelled) {
            [fakeImageView removeFromSuperview];
            [pToVC.collectionView addSubview:pToVC.selectCell];
        }else {
            [fromVC.view addSubview:fakeImageView];
            [UIView animateWithDuration:0.25 animations:^{
                fakeImageView.transform = CGAffineTransformMakeRotation(0);
                fakeImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                fakeImageView.frame = _fakeImageViewOriginFrame;
            } completion:^(BOOL finished) {
            }];

            [pToVC.selectCell removeFromSuperview];
        }
        [transitionContext completeTransition:!transitationCancelled];
    }];
}





@end
