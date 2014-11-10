//
//  BlurEffectViewController.h
//  UICategories
//
//  Created by xiekw on 10/21/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurEffectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *ChoosImageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *darkLight;
@property (weak, nonatomic) IBOutlet UIButton *extraDarkLight;
@property (copy, nonatomic) void(^imageHandler)(UIImage *image);

@end
