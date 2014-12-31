//
//  DXSafeNavigationController.m
//  UICategories
//
//  Created by xiekw on 12/31/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "DXSafeNavigationController.h"
#import <objc/runtime.h>

/*  CLASS DESCRIPTION:
 *  ==================
 *      Delegate proxy is meant to be used as a proxy between and
 *  object and its delegate. The DelegateProxy is initialized with a
 *  target and middle man, where the target is the original delegate
 *  and the middle-man is just an object we send identical messages to.
 */

// If you also use TLShaNavBar, maybe you will get a compile error for the duplicate object, So here I change the proxy name. Thanks to https://github.com/telly/TLYShyNavBar
@interface DXDelegateProxy : NSProxy

@property (nonatomic, weak) id originalDelegate;

- (instancetype)initWithMiddleMan:(id)middleMan;

@end

@interface DXDelegateProxy ()

@property (nonatomic, weak) id middleMan;

@end

@implementation DXDelegateProxy

- (instancetype)initWithMiddleMan:(id)middleMan
{
    if (self)
    {
        self.middleMan = middleMan;
    }
    return self;
}

- (NSInvocation *)_copyInvocation:(NSInvocation *)invocation
{
    NSInvocation *copy = [NSInvocation invocationWithMethodSignature:[invocation methodSignature]];
    NSUInteger argCount = [[invocation methodSignature] numberOfArguments];
    
    for (int i = 0; i < argCount; i++)
    {
        char buffer[sizeof(intmax_t)];
        [invocation getArgument:(void *)&buffer atIndex:i];
        [copy setArgument:(void *)&buffer atIndex:i];
    }
    
    return copy;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self.middleMan respondsToSelector:invocation.selector])
    {
        NSInvocation *invocationCopy = [self _copyInvocation:invocation];
        [invocationCopy invokeWithTarget:self.middleMan];
    }
    
    if ([self.originalDelegate respondsToSelector:invocation.selector])
    {
        [invocation invokeWithTarget:self.originalDelegate];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    id result = [self.originalDelegate methodSignatureForSelector:sel];
    if (!result) {
        result = [self.middleMan methodSignatureForSelector:sel];
    }
    
    return result;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return ([self.originalDelegate respondsToSelector:aSelector]
            || [self.middleMan respondsToSelector:aSelector]);
}

@end


@interface DXSafeNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL shouldIgnorePushingViewControllers;
@property (nonatomic, strong) DXDelegateProxy *delegateProxy;

@end

@implementation DXSafeNavigationController

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"Father class did show delegate");
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = (navigationController.viewControllers.count >= 2);
    }
    self.shouldIgnorePushingViewControllers = NO;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //return  YES;
    return NO;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated  {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (!self.shouldIgnorePushingViewControllers) {
        [super pushViewController:viewController animated:animated];
    }
    self.shouldIgnorePushingViewControllers = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegateProxy = [[DXDelegateProxy alloc] initWithMiddleMan:self];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.delegate = self;
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    [super setDelegate:delegate];
    if (self.delegate != _delegateProxy) {
        self.delegateProxy.originalDelegate = self.delegate;
        [super setDelegate:(id)_delegateProxy];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
