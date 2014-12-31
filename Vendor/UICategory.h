//
//  UICategory.h
//  MoreLikers
//
//  Created by xiekw on 14-1-20.
//  Copyright (c) 2014年 周和生. All rights reserved.
//

#import <UIKit/UIKit.h>

// ios7 api to get the label text size
#define TextSizeWithTextAndFontConstrainedWidth(text, font, width) \
[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) \
options:NSStringDrawingUsesLineFragmentOrigin \
attributes:@{NSFontAttributeName:font} context:nil].size

#define LabelTextSizeWithConstrainedWidth(label, width) \
TextSizeWithTextAndFontConstrainedWidth(label.text, label.font, width)

#define LabelTextSize(label) LabelTextSizeWithConstrainedWidth(label, CGFLOAT_MAX)

//change anchor point and change position
#define DX_ChangeLayerAnchorPointAndAjustPositionToStayFrame(layer, nowAnchorPoint) \
CGPoint DX_lastAnchor = layer.anchorPoint;\
layer.anchorPoint = nowAnchorPoint;\
layer.position = CGPointMake(layer.position.x+(nowAnchorPoint.x-DX_lastAnchor.x)*layer.bounds.size.width, layer.position.y+(nowAnchorPoint.y-DX_lastAnchor.y)*layer.bounds.size.height);\


@interface UIView (ScreenShot)

//target frame should in self coordinator system, so you may use the [self convertRect:targetFrame to:nil] to get the targetFrame
- (UIImage *)screenShotImageWithBounds:(CGRect)targetFrame;
- (UIImage *)screenShotImage;

@end

@interface UIView (MotionEffect)

- (void)centerX_addMotionEffectWithMin:(CGFloat)min max:(CGFloat)max;
- (void)centerY_addMotionEffectWithMin:(CGFloat)min max:(CGFloat)max;

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
- (CGFloat)colorness;

@end


@interface NSArray (RandomIt)

- (NSArray *)shortIt:(NSInteger)expectCount;

@end




extern CGRect CenterFrameWithContainerAndContentSize(CGSize containerSize, CGSize contentSize);
extern CGFloat RandomFloatBetweenLowAndHigh(CGFloat low, CGFloat high);


