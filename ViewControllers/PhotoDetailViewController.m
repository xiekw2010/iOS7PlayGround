//
//  PhotoDetailViewController.m
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "DXPhoto.h"
#import "TransitionCollectionViewController.h"
#import "DXNavPopPhotoTransition.h"

@interface PhotoDetailViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) DXNavPopPhotoTransition *popTransitation;

@end

@implementation PhotoDetailViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.popTransitation = [DXNavPopPhotoTransition new];
    [self.popTransitation attachGesturePopToNavigationViewController:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.popTransitation detachGesturePop];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.popTransitation;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.popTransitation.pctInteractive;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"photo";
    
    
    if (self.presentingViewController) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.scrollView];
        
        CGFloat igvWidth = CGRectGetWidth(self.view.bounds);
        CGFloat igvHeight = self.photo.display.size.height/self.photo.display.size.width * igvWidth;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, igvWidth, igvHeight)];
        self.imageView.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y-64.0);
        [self.scrollView addSubview:self.imageView];
        
        self.imageView.image = self.photo.display;

    }
    
    NSLog(@"self.navigationViewController is %@ and delegate is %@", self.navigationController, self.navigationController.delegate);

}

- (void)dismiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
