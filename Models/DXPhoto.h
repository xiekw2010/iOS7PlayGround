//
//  DXPhoto.h
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DXPhoto : NSObject


@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *display;
@property (nonatomic, strong) NSString *photoDes;

+ (NSArray *)photos;
+ (UIImage *)anyImage;
+ (DXPhoto *)onlyPhoto;

@end
