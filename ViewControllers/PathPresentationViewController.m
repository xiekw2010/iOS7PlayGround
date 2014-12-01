//
//  PathPresentationViewController.m
//  UICategories
//
//  Created by xiekw on 12/1/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "PathPresentationViewController.h"
#import "PathSheetTransition.h"

@interface PathPresentationViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) PathSheetTransition *sheetTransition;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIControl *dimView;

@end

@implementation PathPresentationViewController

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.sheetTransition.presentOperation = PathSheetPresentOperationPresent;
    return self.sheetTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.sheetTransition.presentOperation = PathSheetPresentOperationDismiss;
    return self.sheetTransition;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.transitioningDelegate = self;
    self.sheetTransition = [PathSheetTransition new];

    
//    self.dimView = [[UIControl alloc] initWithFrame:self.view.bounds];
//    self.dimView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//    [self.view addSubview:self.dimView];
//    self.dimView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
    self.contentView.center = self.view.center;
    self.contentView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.contentView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 100, 100);
    [self.contentView addSubview:backBtn];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)back
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
