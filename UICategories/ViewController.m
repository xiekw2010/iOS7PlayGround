//
//  ViewController.m
//  UICategories
//
//  Created by xiekw on 10/21/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "ViewController.h"
#import "BlurEffectViewController.h"
#import "TransitionCollectionViewController.h"
#import "NavigationControllerDelegate.h"
#import "SimpleNavTransition.h"
#import "SingeImageViewController.h"
#import "ContainerExampleViewController.h"
#import "MotionEffectViewController.h"
#import "PopoverDisplayViewController.h"
#import "DXSafeNavigationController.h"

@interface ViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *funcs;
@property (nonatomic, strong) NavigationControllerDelegate *navDelegate;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [[SimpleNavTransition alloc] initWithNavigationOperation:operation];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.funcs = @[@"Blur effects", @"Navigation transition", @"Present transitation", @"ContainerViewController", @"Motion Effect", @"PopOver"];
    
    NSLog(@"self.navigationViewController is %@ and delegate is %@", self.navigationController, self.navigationController.delegate);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.funcs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.funcs[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        BlurEffectViewController *bvc = [[BlurEffectViewController alloc] initWithNibName:@"BlurEffectViewController" bundle:nil];
        [self.navigationController pushViewController:bvc animated:YES];
        bvc.imageHandler = ^(UIImage *image) {
            self.tableView.backgroundView = [[UIImageView alloc] initWithImage:image];
        };
    }else if (indexPath.row == 1) {
        CGFloat allFlowWidth = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 171 : 70;
        CGFloat itemSpacing = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 7 : 5);
        CGFloat lineSpacing = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 10 : 5;
        UICollectionViewFlowLayout *allFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        allFlowLayout.itemSize = CGSizeMake(allFlowWidth, allFlowWidth);
        allFlowLayout.minimumInteritemSpacing = itemSpacing;
        allFlowLayout.sectionInset = UIEdgeInsetsMake( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 30 : 5, UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 27 : 12, 15,  UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 27 : 12);
        allFlowLayout.minimumLineSpacing = lineSpacing;
        
        TransitionCollectionViewController *tvc = [[TransitionCollectionViewController alloc] initWithCollectionViewLayout:allFlowLayout];
        [self.navigationController pushViewController:tvc animated:YES];
    }else if (indexPath.row == 2) {
        
        SingeImageViewController *single = [SingeImageViewController new];
        [self presentViewController:single animated:YES completion:nil];
    }else if (indexPath.row == 3) {
        [ContainerExampleViewController showFromParent:self];
    }else if (indexPath.row == 4) {
        [self.navigationController pushViewController:[MotionEffectViewController new] animated:YES];
    }else if (indexPath.row == 5) {
        PopoverDisplayViewController *pop = [PopoverDisplayViewController new];
        UINavigationController *navcon = [[DXSafeNavigationController alloc] initWithRootViewController:pop];
        [self presentViewController:navcon animated:YES completion:nil];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
