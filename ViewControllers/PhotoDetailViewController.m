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
    
    
    //make some custom operation to the self.imageview
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
    if (animationController == self.popTransitation) {
        return self.popTransitation.pctInteractive;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"photo";
    
    
    if (self.presentingViewController) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];

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
