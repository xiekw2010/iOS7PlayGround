//
//  DXPhoto.h
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXPhoto : NSObject

@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *display;


+ (NSArray *)photos;
+ (UIImage *)anyImage;

@end
