//
//  TKPreferredFontCategory.m
//  IntroToTextKitDemo2013
//
//  Created by xiekw on 1/16/15.
//  Copyright (c) 2015 Apple Inc. All rights reserved.
//

#import "TKPreferredFontCategory.h"

@implementation UIFont (TextKitDemo)
+ (UIFont *)tkd_preferredFontWithTextStyle:(NSString *)aTextStyle scale:(CGFloat)aScale
{
    UIFontDescriptor *newFontDescriptor = [UIFontDescriptor tkd_preferredFontDescriptorWithTextStyle:aTextStyle scale:aScale];
    
    return [UIFont fontWithDescriptor:newFontDescriptor size:newFontDescriptor.pointSize];
}

- (NSString *)tkd_textStyle
{
    NSString *style = [self.fontDescriptor tkd_textStyle];
    if ([style rangeOfString:@"UICTFontTextStyle"].length == 0) {
        style = UIFontTextStyleHeadline;
    }
    return style;
}

- (UIFont *)tkd_fontWithScale:(CGFloat)aScale
{
    return [self fontWithSize:lrint(self.pointSize * aScale)];
}
@end

@implementation UIFontDescriptor (TextKitDemo)
+ (UIFontDescriptor *)tkd_preferredFontDescriptorWithTextStyle:(NSString *)aTextStyle scale:(CGFloat)aScale
{
    UIFontDescriptor *newBaseDescriptor = [self preferredFontDescriptorWithTextStyle:aTextStyle];
    
    return [newBaseDescriptor fontDescriptorWithSize:lrint([newBaseDescriptor pointSize] * aScale)];
}

- (NSString *)tkd_textStyle
{
    return [self objectForKey:@"NSCTFontUIUsageAttribute"];
}

- (UIFontDescriptor *)tkd_fontDescriptorWithScale:(CGFloat)aScale
{
    return [self fontDescriptorWithSize:lrint(self.pointSize * aScale)];
}
@end

@implementation UITextView (TextKitDemo)
- (NSString *)tkd_textStyle
{
    return [self.font tkd_textStyle];
}

- (void)usePreferredFontWithScale:(CGFloat)scale
{
    UIFont *cellTitleFont = [self preferredFontWithScale:scale];
    self.font = cellTitleFont;
}

- (UIFont *)preferredFontWithScale:(CGFloat)scale
{
    NSString *cellTitleTextStyle = [self tkd_textStyle];
    UIFont *cellTitleFont = [UIFont tkd_preferredFontWithTextStyle:cellTitleTextStyle scale:scale];
    return cellTitleFont;
}
@end

@implementation UILabel (TextKitDemo)

- (NSString *)tkd_textStyle
{
    return [self.font tkd_textStyle];
}

- (void)usePreferredFontWithScale:(CGFloat)scale
{
    UIFont *cellTitleFont = [self preferredFontWithScale:scale];
    self.font = cellTitleFont;
}

- (UIFont *)preferredFontWithScale:(CGFloat)scale
{
    NSString *cellTitleTextStyle = [self tkd_textStyle];
    UIFont *cellTitleFont = [UIFont tkd_preferredFontWithTextStyle:cellTitleTextStyle scale:scale];
    return cellTitleFont;
}

@end

@implementation UITextField (TextKitDemo)
- (NSString *)tkd_textStyle
{
    return [self.font tkd_textStyle];
}

- (void)usePreferredFontWithScale:(CGFloat)scale
{
    UIFont *cellTitleFont = [self preferredFontWithScale:scale];
    self.font = cellTitleFont;
}

- (UIFont *)preferredFontWithScale:(CGFloat)scale
{
    NSString *cellTitleTextStyle = [self tkd_textStyle];
    UIFont *cellTitleFont = [UIFont tkd_preferredFontWithTextStyle:cellTitleTextStyle scale:scale];
    return cellTitleFont;
}
@end

@implementation UIButton (TDKDemo)
- (NSString *)tkd_textStyle
{
    return [self.titleLabel.font tkd_textStyle];
}

- (void)usePreferredFontWithScale:(CGFloat)scale
{
    UIFont *cellTitleFont = [self preferredFontWithScale:scale];
    self.titleLabel.font = cellTitleFont;
}

- (UIFont *)preferredFontWithScale:(CGFloat)scale
{
    NSString *cellTitleTextStyle = [self tkd_textStyle];
    UIFont *cellTitleFont = [UIFont tkd_preferredFontWithTextStyle:cellTitleTextStyle scale:scale];
    return cellTitleFont;
}
@end

