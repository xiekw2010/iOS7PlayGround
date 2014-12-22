//
//  TransitionCollectionViewController.m
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "TransitionCollectionViewController.h"
#import "DXPhoto.h"
#import "ThumbnailCollectionViewCell.h"
#import "SimpleNavTransition.h"
#import "PhotoDetailViewController.h"
#import "PresentationControllerDelegate.h"
#import "DXNavPushPhotoTransition.h"

@interface TransitionCollectionViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) PresentationControllerDelegate *presentDelegate;
@property (nonatomic, strong) SimpleNavTransition *navInteractive;

@end

@implementation TransitionCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.navInteractive = [[SimpleNavTransition alloc] initWithNavigationOperation:UINavigationControllerOperationNone];
    [self.navInteractive attachGesturePopToNavigationViewController:self.navigationController];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navInteractive detachGesturePop];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        self.navInteractive.navOp = operation;
        return self.navInteractive;
    }else if (operation == UINavigationControllerOperationPush) {
        return [DXNavPushPhotoTransition new];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (animationController == self.navInteractive) {
        return self.navInteractive.pctInteractive;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"PhotoWalls";
    
    // Register cell classes
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[ThumbnailCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DXPhoto photos].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThumbnailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    DXPhoto *photo = [DXPhoto photos][indexPath.row];
    cell.imageView.image = photo.thumbnail;
    NSLog(@"photo's colorness is %f", [photo.thumbnail colorness]);
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DXPhoto *photo = [DXPhoto photos][indexPath.row];
    PhotoDetailViewController *dvc = [[PhotoDetailViewController alloc] init];
    dvc.photo = photo;
    self.selectCell = (ThumbnailCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.bigImage = photo.display;
    
//    if (indexPath.row%2==0) {
//        [self.navigationController pushViewController:dvc animated:YES];
//    }else {
//        UINavigationController *target = [[UINavigationController alloc] initWithRootViewController:dvc];
//        self.presentDelegate = [[PresentationControllerDelegate alloc] initWithViewController:target];
//        [self presentViewController:target animated:YES completion:nil];
//    }
    [self.navigationController pushViewController:dvc animated:YES];

}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
