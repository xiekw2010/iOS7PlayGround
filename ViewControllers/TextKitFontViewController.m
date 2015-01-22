//
//  TextKitFontViewController.m
//  UICategories
//
//  Created by xiekw on 1/16/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

#import "TextKitFontViewController.h"
#import "TKPreferredFontCategory.h"

@interface TextKitFontViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextKitFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateText) name:UIContentSizeCategoryDidChangeNotification object:nil];
    [self updateText];
}

- (void)updateText
{
    [self.label usePreferredFontWithScale:0.9];
    [self.textView usePreferredFontWithScale:0.9];
    [self.button usePreferredFontWithScale:0.9];
    [self.textField usePreferredFontWithScale:0.9];
    [self.label sizeToFit];
    [self.textView sizeToFit];
    [self.button sizeToFit];
    [self.textField sizeToFit];

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
