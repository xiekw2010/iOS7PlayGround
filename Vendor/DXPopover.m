//
//  DXPopover.m
//  UICategories
//
//  Created by xiekw on 11/14/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "DXPopover.h"

#define DEGREES_TO_RADIANS(degrees)  ((3.14159265359 * degrees)/ 180)

@interface DXPopover ()

@property (nonatomic, strong) UIControl *blackOverlay;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign, readwrite) DXPopoverPosition popoverPosition;
@property (nonatomic, assign) CGPoint arrowShowPoint;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, assign) CGRect contentViewFrame; //the contentview frame in the containerView coordinator

@end

@implementation DXPopover

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.arrowSize = CGSizeMake(10.0, 8.0);
        self.cornerRadius = 7.0;
        self.backgroundColor = [UIColor clearColor];
        self.animationIn = 0.4;
        self.animationOut = 0.2;
        self.animationSpring = YES;
        self.sideEdge = 0.0;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self init];
}

- (void)_setup
{
    CGRect frame = self.contentViewFrame;
    
    CGFloat frameMidx = self.arrowShowPoint.x-CGRectGetWidth(frame)*0.5;
    frame.origin.x = frameMidx;
    
    //we don't need the edge now
    CGFloat sideEdge = 0.0;
    if (CGRectGetWidth(frame)<CGRectGetWidth(self.containerView.frame)) {
        sideEdge = self.sideEdge;
    }
    
    //righter the edge
    CGFloat outerSideEdge = CGRectGetMaxX(frame)-CGRectGetWidth(self.containerView.bounds);
    if (outerSideEdge > 0) {
        frame.origin.x -= (outerSideEdge+sideEdge);
    }else {
        if (CGRectGetMinX(frame)<0) {
            frame.origin.x += abs(CGRectGetMinX(frame))+sideEdge;
        }
    }
    
    
    self.frame = frame;

    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];

    CGPoint anchorPoint;
    switch (self.popoverPosition) {
        case DXPopoverPositionDown: {
            frame.origin.y = self.arrowShowPoint.y;
            anchorPoint = CGPointMake(arrowPoint.x/CGRectGetWidth(frame), 0);
        }
            break;
        case DXPopoverPositionUp: {
            frame.origin.y = self.arrowShowPoint.y - CGRectGetHeight(frame) - self.arrowSize.height;
            anchorPoint = CGPointMake(arrowPoint.x/CGRectGetWidth(frame), 1);
        }
            break;
    }
    CGPoint DX_lastAnchor = self.layer.anchorPoint;
    self.layer.anchorPoint = anchorPoint;
    self.layer.position = CGPointMake(self.layer.position.x+(anchorPoint.x-DX_lastAnchor.x)*self.layer.bounds.size.width, self.layer.position.y+(anchorPoint.y-DX_lastAnchor.y)*self.layer.bounds.size.height);\

    frame.size.height += self.arrowSize.height;
    self.frame = frame;
}


- (void)showAtPoint:(CGPoint)point arrowDirection:(DXPopoverPosition)position withContentView:(UIView *)contentView inView:(UIView *)containerView
{
    assert(CGRectGetWidth(contentView.bounds)>0&&CGRectGetHeight(contentView.bounds)>0);
    assert(CGRectGetWidth(containerView.bounds)>0&&CGRectGetHeight(containerView.bounds)>0);
    assert(CGRectGetWidth(containerView.bounds)>=CGRectGetWidth(contentView.bounds));
    
    if (!self.blackOverlay) {
        self.blackOverlay = [[UIControl alloc] initWithFrame:containerView.bounds];
        self.blackOverlay.backgroundColor = [UIColor clearColor];
        self.blackOverlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    [containerView addSubview:self.blackOverlay];
    [self.blackOverlay addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.containerView = containerView;
    self.contentView = contentView;
    self.contentView.layer.cornerRadius = self.cornerRadius;
    self.contentView.layer.masksToBounds = YES;
    self.popoverPosition = position;
    self.arrowShowPoint = point;
    self.contentViewFrame = [containerView convertRect:contentView.frame toView:containerView];
    
    [self show];
}


- (void)show
{
    [self setNeedsDisplay];
    
    CGRect contentViewFrame = self.contentViewFrame;
    switch (self.popoverPosition) {
        case DXPopoverPositionUp:
            contentViewFrame.origin.y = 0.0;
            break;
        case DXPopoverPositionDown:
            contentViewFrame.origin.y = self.arrowSize.height;
            break;
    }
    self.contentView.frame = contentViewFrame;
    [self addSubview:self.contentView];
    [self.containerView addSubview:self];
    
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    if (self.animationSpring) {
        [UIView animateWithDuration:self.animationIn delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                if (self.didShowHandler) {
                    self.didShowHandler();
                }
            }
        }];
    }else {
        [UIView animateWithDuration:self.animationIn delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                if (self.didShowHandler) {
                    self.didShowHandler();
                }
            }
        }];
    }
}

- (void)dismiss
{
    if (self.superview) {
        [UIView animateWithDuration:self.animationOut delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        } completion:^(BOOL finished) {
            if (finished) {
                [self.blackOverlay removeFromSuperview];
                [self removeFromSuperview];
                if (self.didDimissHandler) {
                    self.didDimissHandler();
                }
            }
        }];
    }
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *arrow = [[UIBezierPath alloc] init];
    UIColor *contentColor = self.contentView.backgroundColor ? : self.backgroundColor;
    //the point in the ourself view coordinator
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    
    switch (self.popoverPosition) {
        case DXPopoverPositionDown: {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, 0)];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x+self.arrowSize.width*0.5, self.arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, self.arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, self.arrowSize.height+self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(270.0) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, CGRectGetHeight(self.bounds)-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
            [arrow addArcWithCenter:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds)-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, self.arrowSize.height+self.cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(self.cornerRadius, self.arrowSize.height+self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x-self.arrowSize.width*0.5, self.arrowSize.height)];
        }
            break;
        case DXPopoverPositionUp: {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, CGRectGetHeight(self.bounds))];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x-self.arrowSize.width*0.5, CGRectGetHeight(self.bounds)-self.arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds)-self.arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds)-self.arrowSize.height-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(90.0) endAngle:DEGREES_TO_RADIANS(180.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, self.cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(270.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, 0)];
            [arrow addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(270.0) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.arrowSize.height-self.cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, CGRectGetHeight(self.bounds)-self.arrowSize.height-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x+self.arrowSize.width*0.5, CGRectGetHeight(self.bounds)-self.arrowSize.height)];
        }
            
            break;
    }
    [contentColor setFill];
    [arrow fill];
}

- (void)layoutSubviews
{
    [self _setup];
}

@end
