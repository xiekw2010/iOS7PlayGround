//
//  TKPreferredFontCategory.h
//  IntroToTextKitDemo2013
//
//  Created by xiekw on 1/16/15.
//  Copyright (c) 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*Notice: Please try to observe UIContentSizeCategoryDidChangeNotification notification to update the layout*/

@interface UIFont (TextKitDemo)
+ (UIFont *)tkd_preferredFontWithTextStyle:(NSString *)aTextStyle scale:(CGFloat)aScale;
- (NSString *)tkd_textStyle;
- (UIFont *)tkd_fontWithScale:(CGFloat)fontScale;
@end

@interface UIFontDescriptor (TextKitDemo)
+ (UIFontDescriptor *)tkd_preferredFontDescriptorWithTextStyle:(NSString *)aTextStyle scale:(CGFloat)aScale;
- (NSString *)tkd_textStyle;
- (UIFontDescriptor *)tkd_fontDescriptorWithScale:(CGFloat)aScale;
@end

@interface UITextView (TextKitDemo)
- (NSString *)tkd_textStyle;
- (void)usePreferredFontWithScale:(CGFloat)scale;
- (UIFont *)preferredFontWithScale:(CGFloat)scale;
@end

@interface UILabel (TextKitDemo)
- (NSString *)tkd_textStyle;
- (void)usePreferredFontWithScale:(CGFloat)scale;
- (UIFont *)preferredFontWithScale:(CGFloat)scale;
@end

@interface UITextField (TextKitDemo)
- (NSString *)tkd_textStyle;
- (void)usePreferredFontWithScale:(CGFloat)scale;
- (UIFont *)preferredFontWithScale:(CGFloat)scale;
@end

@interface UIButton (TDKDemo)
- (NSString *)tkd_textStyle;
- (void)usePreferredFontWithScale:(CGFloat)scale;
- (UIFont *)preferredFontWithScale:(CGFloat)scale;
@end
