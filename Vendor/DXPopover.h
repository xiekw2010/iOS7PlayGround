//
//  DXPopover.h
//  UICategories
//
//  Created by xiekw on 11/14/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DXPopoverPosition) {
    DXPopoverPositionUp,
    DXPopoverPositionDown,
};

@interface DXPopover : UIView

@property (nonatomic, assign, readonly) DXPopoverPosition popoverPosition;
@property (nonatomic, assign) CGSize arrowSize;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat animationIn;
@property (nonatomic, assign) CGFloat animationOut;
@property (nonatomic, assign) BOOL animationSpring;


/**
 *  The popover default is centered by the arrowShowPoint, but if it's outsider the container's edge, this value will be used to pin the left of right edge to containerView's border.
 */
@property (nonatomic, assign) CGFloat sideEdge;

/**
 *  The contentInset in the popover for the contentView
 */
@property (nonatomic, assign) UIEdgeInsets contentInset;

@property (nonatomic, copy) dispatch_block_t didShowHandler;
@property (nonatomic, copy) dispatch_block_t didDimissHandler;

/**
 *  Show API
 *
 *  @param point         the point in the container coordinator system.
 *  @param position      stay up or stay down from the showAtPoint
 *  @param contentView   the contentView
 *  @param containerView the containerView
 */
- (void)showAtPoint:(CGPoint)point arrowDirection:(DXPopoverPosition)position withContentView:(UIView *)contentView inView:(UIView *)containerView;


- (void)showAtPoint:(CGPoint)point withContentView:(UIView *)contentView inView:(UIView *)containerView;

- (void)dismiss;


@end
