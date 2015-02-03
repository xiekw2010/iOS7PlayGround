//
//  RunTimeViewController.h
//  UICategories
//
//  Created by xiekw on 1/29/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Event Delivery: The Responder Chain
 
    通过hitTestView递归传到最底层的view，有第一机会响应事件如果不响应然后在把事件一层层的传上去，直到找到响应的对象为止。
 
    扩大button的点击对象。通过pointInside:(CGPoint)point withEvent:(UIEvent *)event方法。
 */


@interface RunTimeViewController : UIViewController

@end
