//
//  UICategory.h
//  MoreLikers
//
//  Created by xiekw on 14-1-20.
//  Copyright (c) 2014年 周和生. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (ScreenShot)

//target frame should in self coordinator system, so you may use the [self convertRect:targetFrame to:nil] to get the targetFrame
- (UIImage *)screenShotImageWithBounds:(CGRect)targetFrame;
- (UIImage *)screenShotImage;

@end


@interface UIImage (ImageEffects)

//apple wwdc session code for the blur
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

//crop images, supports only aspectFit and UIViewContentModeScaleToFill, default is UIViewContentModeScaleAspectFit
- (UIImage *)thumbnailForSize:(CGSize)thumbnailSize contentMode:(UIViewContentMode)mode;
- (UIImage *)thumbnailForSize:(CGSize)thumbnailSize;
- (UIImage *)thumbnailForScale:(CGFloat)scale;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color cropSize:(CGSize)targetSize;


//maybe for you to judge status bar style, if YES the statusbar style should be default, otherwise it should be UIStatusBarStyleLightContent.
- (BOOL)isLight;

@end


@interface NSArray (RandomIt)

- (NSArray *)shortIt:(NSInteger)expectCount;

@end




extern CGRect centerFrameWithContainerAndImageSize(CGSize containerSize, CGSize imageSize);


