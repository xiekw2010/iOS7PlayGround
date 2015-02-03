//
//  RunTimeViewController.m
//  UICategories
//
//  Created by xiekw on 1/29/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

#import "RunTimeViewController.h"
#import <objc/runtime.h>

@interface RunTimeObj : NSObject<NSCopying>

@property (nonatomic, strong) NSString *text;

@end

@implementation RunTimeObj

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.text = @"initNow";
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    NSLog(@"%@", sig);
    return sig;
}

+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *sig = [super instanceMethodSignatureForSelector:aSelector];
    NSLog(@"%@", sig);
    return sig;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    NSString *superDes = [super description];
    return [NSString stringWithFormat:@"%@ isand self.text is %@", superDes, self.text];
}

@end

@interface Btn1 : UIButton
@end

@implementation Btn1

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    UIView *result = [super hitTest:point withEvent:event];
//    NSLog(@"super hittest is %@", result);
//    return result;
//}
//
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    NSLog(@"point is %@", NSStringFromCGPoint(point));
//    CGRect outSide = CGRectInset(self.bounds, -10, -10);
//    return CGRectContainsPoint(outSide, point);
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        NSLog(@"%@", NSStringFromClass([self class]));
//        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

- (void)playNow
{
    NSLog(@"class Play");
}

@end


@interface DaryView : UIView

@end

@implementation DaryView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *result = [super hitTest:point withEvent:event];
    NSLog(@"super hittest is %@", result);
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"point is %@", NSStringFromCGPoint(point));
    CGRect outSide = CGRectInset(self.bounds, -10, -10);
    return CGRectContainsPoint(outSide, point);
}

@end

@interface Btn1 (play)

- (void)playNow;

@end

@implementation Btn1 (play)

- (void)playNow
{
    NSLog(@"category1 play");
}

@end

@interface Btn1 (play2)

- (void)playNow;

@end

@implementation Btn1 (play2)

- (void)playNow
{
    NSLog(@"category2 play");
}


- (void)drawRect:(CGRect)rect
{
    NSLog(@"category drawRect");
    
    UIBezierPath *arrow = [UIBezierPath new];
    
    UIColor *redcolor = [UIColor greenColor];
    [redcolor setFill];
    arrow = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 10, 10) cornerRadius:5.0];
    
    [arrow fill];

}

@end

@interface Btn2 : UIButton

@end

@implementation Btn2

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *result = [super hitTest:point withEvent:event];
    NSLog(@"super hittest is %@", result);
    return result;
}

@end

@interface Btn3 : UIButton

@end

@implementation Btn3

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    UIView *result = [super hitTest:point withEvent:event];
//    NSLog(@"super hittest is %@", result);
//    return result;
//}
@end

@interface RunTimeViewController ()

@property (nonatomic, strong) RunTimeObj *runObj;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

typedef void (^qBlock)();

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.runObj = [RunTimeObj new];
    RunTimeObj *cpRunObj = [self.runObj copy];
    NSLog(@"self.runObj is %@ and cpRunObj is %@", self.runObj, cpRunObj);
    
    NSDictionary *map = @{cpRunObj : @"play now"};
    NSLog(@"before map is %@ and self.runObj is %@ copyObj is %@", map, self.runObj, cpRunObj);
    cpRunObj = nil;
    self.runObj = nil;
    NSLog(@"after map is %@ and self.runObj is %@ copyObj is %@", map, self.runObj, cpRunObj);
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hi" style:UIBarButtonItemStylePlain target:self.runObj action:@selector(playNow)];
    
    
    UIButton *btn1 = [Btn1 new];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(100, 100, 200, 200);
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"1" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    DaryView *testView = [[DaryView alloc] initWithFrame:btn1.frame];
    testView.backgroundColor = [UIColor darkGrayColor];
    testView.userInteractionEnabled = YES;
    [self.view addSubview:testView];
    
    UIButton *btn2 = [Btn2 new];
    btn2.backgroundColor = [UIColor blueColor];
    btn2.frame = CGRectMake(150, 150, 50, 50);
    [btn2 addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"2" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [Btn3 new];
    btn3.backgroundColor = [UIColor cyanColor];
    btn3.frame = CGRectMake(-50, -50, 50, 50);
    [btn3 addTarget:self action:@selector(btn3) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"3" forState:UIControlStateNormal];
    btn1.clipsToBounds = NO;
    [btn1 addSubview:btn3];

    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNow)];
    [self.view addGestureRecognizer:self.tap];
    
}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    NSLog(@"self.view.frame is %@", self.view.debugDescription);
//}
//
//- (void)btn1:(Btn1 *)btn1
//{
//    NSLog(@"btn1");
//    [btn1 playNow];
//}
//
//- (void)btn2
//{
//    NSLog(@"btn2");
//}
//
//- (void)btn3
//{
//    NSLog(@"btn3");
//}
//
//
//- (void)tapNow
//{
//    NSLog(@"tap");
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"");
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"");
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"");
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"");
//}

@end


