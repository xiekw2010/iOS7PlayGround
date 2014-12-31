//
//  DXSafeNavigationController.h
//  UICategories
//
//  Created by xiekw on 12/31/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  If the navigationViewController back button is customlized, the popG is disabled, if manually set the delegate, comes several bugs, here is the solution for it, just use it instead of UINavigationController
 
    And why safe? If the origin navigationViewController use pushViewController:animated:YES fast over 3 times, when you pop the topViewController, app will get crashed([UIView _addSubview:self] raise the exception). Here we make a lock to disable the mutli push.
 
    And the delegate, you won't worry about set the delegate to something else will break the current function. Here we use a proxy for this class implement the delegate
 */
@interface DXSafeNavigationController : UINavigationController

@end
