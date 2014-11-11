//
//  SingeImageViewController.m
//  UICategories
//
//  Created by xiekw on 11/11/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "SingeImageViewController.h"
#import "DXPhoto.h"
#import "DXPresentationExampleTransition.h"

@interface SingeImageViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) DXPresentationExampleTransition *presentTransitation;

@end

@implementation SingeImageViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.imageView.image.isLight) {
        return UIStatusBarStyleDefault;
    }else {
        return UIStatusBarStyleLightContent;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.presentTransitation attachGestureToDismissViewController:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.presentTransitation detachGestureDismiss];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.presentTransitation.presentOperation = DXPresentationOperationPresent;
    return self.presentTransitation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presentTransitation.presentOperation = DXPresentationOperationDimiss;
    return self.presentTransitation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.presentTransitation.pctInteractive;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    [self.view addSubview:self.imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.image = [DXPhoto anyImage];
    
    self.transitioningDelegate = self;
    self.presentTransitation = [DXPresentationExampleTransition new];
}

- (void)handleTap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
