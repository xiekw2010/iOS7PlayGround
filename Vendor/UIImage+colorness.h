//
//  UIImage+colorness.h
//  PhotoCleaner
//
//  Created by xiekw on 12/16/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCRGBReprestation : NSObject<NSCopying>

//[leftup, rightup, leftdown, rightdown]
@property (nonatomic, strong) NSArray *rgbObjs;
- (BOOL)isSatisfy:(PCRGBReprestation *)another;

@end


@interface PCImageRGBObject : NSObject

@property (nonatomic, assign) CGFloat R;
@property (nonatomic, assign) CGFloat G;
@property (nonatomic, assign) CGFloat B;

@end

@interface UIImage (colorness)

- (PCRGBReprestation *)colorness;

@end

