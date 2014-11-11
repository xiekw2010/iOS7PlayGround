//
//  ContainerExampleViewController.m
//  UICategories
//
//  Created by xiekw on 11/11/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "ContainerExampleViewController.h"
#import "DXPhoto.h"

@interface ContainerExampleViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ContainerExampleViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.imageView.image.isLight) {
        return UIStatusBarStyleDefault;
    }else {
        return UIStatusBarStyleLightContent;
    }
}

- (void)backNow:(id)sender
{
    [self willMoveToParentViewController:Nil];
    [self.view removeFromSuperview];;
    [self removeFromParentViewController];
}

- (void)moveToParentVC:(UIViewController *)vc
{
    UIViewController *tvc = vc;
    if (vc.navigationController) {
        tvc = vc.navigationController;
    }
    [tvc addChildViewController:self];
    [tvc.view addSubview:self.view];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:300 options:kNilOptions animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
    }];
    
    
    [self didMoveToParentViewController:tvc];

}

+ (void)showFromParent:(UIViewController *)parent
{
    ContainerExampleViewController *container = [ContainerExampleViewController new];
    [container moveToParentVC:parent];
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
    
}

- (void)handleTap
{
    [self backNow:nil];
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
