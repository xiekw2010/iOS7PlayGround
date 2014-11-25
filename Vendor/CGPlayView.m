//
//  CGPlayView.m
//  UICategories
//
//  Created by xiekw on 11/14/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "CGPlayView.h"

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0};
    NSArray *colors = @[(__bridge id)startColor, (__bridge id)endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, CGRectOffset(rect, -50, -50));
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@implementation CGPlayView


- (void)drawRect:(CGRect)rect {
    UIBezierPath *arrow = [UIBezierPath new];

    UIColor *redcolor = [UIColor redColor];
    [redcolor setFill];
    arrow = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 10, 10) cornerRadius:5.0];
    
    [arrow fill];
}


@end
