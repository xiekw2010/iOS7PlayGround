//
//  PopoverDisplayViewController.m
//  UICategories
//
//  Created by xiekw on 11/14/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "PopoverDisplayViewController.h"
#import "DXPopover.h"
#import "CGPlayView.h"
#import "DXPhoto.h"

@interface PopoverDisplayViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGFloat _popoverWidth;
    CGSize _popoverArrowSize;
    CGFloat _popoverCornerRadius;
    CGFloat _animationIn;
    CGFloat _animationOut;
    BOOL _animationSpring;
}

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) NSArray *configs;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DXPopover *popover;

@end

@implementation PopoverDisplayViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *titleLb = [[UIButton alloc] initWithFrame:(CGRect){CGPointZero, CGSizeMake(100, 40)}];
    [titleLb setTitle:@"DXPopover" forState:UIControlStateNormal];
    [titleLb addTarget:self action:@selector(titleShowPopover) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLb;
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitle:@"Hello" forState:UIControlStateNormal];
    self.btn.frame = CGRectMake(200, 100, 100, 100);
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(showPopover) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setBackgroundColor:[UIColor cyanColor]];
    
    self.downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downBtn setTitle:@"world" forState:UIControlStateNormal];
    self.downBtn.frame = CGRectMake(10, 400, 100, 100);
    [self.view addSubview:self.downBtn];
    [self.downBtn addTarget:self action:@selector(showPopover1) forControlEvents:UIControlEventTouchUpInside];
    [self.downBtn setBackgroundColor:[UIColor purpleColor]];

    _popoverWidth = CGRectGetWidth(self.view.bounds);
    _popoverWidth = 120.0;
    UITableView *blueView = [[UITableView alloc] init];
    blueView.frame = CGRectMake(0, 0, _popoverWidth, 350);
    blueView.dataSource = self;
    blueView.delegate = self;
    self.tableView = blueView;
    
    self.popover = [DXPopover new];
    self.popover.sideEdge = 20.0;
    
    self.configs = @[@"changeWidth", @"arrowSize", @"cornerRadius", @"animationIn", @"animationOut", @"animationSpring"];
}

- (void)titleShowPopover
{
    [self updateTableViewFrame];
    UIView *titleView = self.navigationItem.titleView;
    CGPoint startPoint = CGPointMake(CGRectGetMidX(titleView.frame), CGRectGetMaxY(titleView.frame) + 20);

    [self.popover showAtPoint:startPoint arrowDirection:DXPopoverPositionDown withContentView:self.tableView inView:self.navigationController.view];
    __weak typeof(self)weakSelf = self;
    self.popover.didDimissHandler = ^{
        [weakSelf bounceTargetView:titleView];
    };
}

- (void)showPopover
{
    [self updateTableViewFrame];

    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.btn.frame), CGRectGetMaxY(self.btn.frame) + 5);
    [self.popover showAtPoint:startPoint arrowDirection:DXPopoverPositionDown withContentView:self.tableView inView:self.navigationController.view];
    
    __weak typeof(self)weakSelf = self;
    self.popover.didDimissHandler = ^{
        [weakSelf bounceTargetView:weakSelf.btn];
    };
}

- (void)showPopover1
{
    [self updateTableViewFrame];

    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.downBtn.frame)+ 30, CGRectGetMinY(self.downBtn.frame) - 5);
    [self.popover showAtPoint:startPoint arrowDirection:DXPopoverPositionUp withContentView:self.tableView inView:self.navigationController.view];
    
    __weak typeof(self)weakSelf = self;
    self.popover.didDimissHandler = ^{
        [weakSelf bounceTargetView:weakSelf.downBtn];
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.configs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.configs[indexPath.row];
    
    return cell;
}

static int i =1;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        int c = i % 3;
        if (c==0) {
            _popoverWidth = 120.0;
        }else if (c==1) {
            _popoverWidth = CGRectGetWidth(self.view.bounds);
        }else if (c==2){
            _popoverWidth = 200;
        }
        i++;
    }else if (indexPath.row ==1) {
        CGSize arrowSize= self.popover.arrowSize;
        arrowSize.width += randomFloatBetweenLowAndHigh(0.0, 5.0);
        arrowSize.height += randomFloatBetweenLowAndHigh(0.0, 5.0);
        self.popover.arrowSize = arrowSize;
    }else if (indexPath.row == 2) {
        self.popover.cornerRadius += randomFloatBetweenLowAndHigh(0.0, 1.0);
    }else if (indexPath.row == 3) {
        self.popover.animationIn = randomFloatBetweenLowAndHigh(0.4, 2.0);
    }else if (indexPath.row == 4) {
        self.popover.animationOut = randomFloatBetweenLowAndHigh(0.4, 2.0);
    }else if (indexPath.row == 5) {
        self.popover.animationSpring = !self.popover.animationSpring;
    }
    [self.popover dismiss];

}

- (void)updateTableViewFrame
{
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.width = _popoverWidth;
    self.tableView.frame = tableViewFrame;
}

- (void)bounceTargetView:(UIView *)targetView
{
    
    [UIView animateWithDuration:0.1 animations:^{
        targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            targetView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                targetView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
