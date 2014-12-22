//
//  MotionEffectViewController.m
//  UICategories
//
//  Created by xiekw on 11/13/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "MotionEffectViewController.h"
#import "DXPhoto.h"

@interface MotionEffectViewController ()

@end

@implementation MotionEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.userInteractionEnabled = YES;
    imageV.center = self.view.center;
    [self.view addSubview:imageV];
    imageV.image = [DXPhoto anyImage];
    
    [imageV centerX_addMotionEffectWithMin:-100 max:100];
    [imageV centerY_addMotionEffectWithMin:-100 max:100];

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
