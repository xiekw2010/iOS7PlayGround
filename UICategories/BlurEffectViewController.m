//
//  BlurEffectViewController.m
//  UICategories
//
//  Created by xiekw on 10/21/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "BlurEffectViewController.h"
#import "DXPhoto.h"

@interface BlurEffectViewController ()
{
    UIImage *_blurImage;
}

@property (nonatomic, strong) NSArray *images;

@end

@implementation BlurEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.ChoosImageBtn.layer.borderColor = [UIColor cyanColor].CGColor;
    self.ChoosImageBtn.layer.borderWidth = 1.0;
    self.backGroundView.contentMode = UIViewContentModeScaleAspectFill;
    self.backGroundView.layer.masksToBounds = YES;
    
    self.images = [NSArray arrayWithArray:[DXPhoto photos]];
    
    [self choosImage:nil];
    
    NSLog(@"self.navigationViewController is %@ and delegate is %@", self.navigationController, self.navigationController.delegate);

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];

    if (self.imageHandler) {
        self.imageHandler(_blurImage);
    }
}

- (IBAction)choosImage:(id)sender {
    
    DXPhoto *photo = self.images[arc4random()%self.images.count];

    UIImage *originImage = photo.display;
    self.backGroundView.image = originImage;
    
    _blurImage = [[self.backGroundView screenShotImage] applyLightEffect];

    
    CGRect btnBGBounds = [self.backGroundView convertRect:self.ChoosImageBtn.frame toView:nil];
    UIImage *scImage = [self.backGroundView screenShotImageWithBounds:btnBGBounds];
    [self.ChoosImageBtn setBackgroundImage:[scImage applyLightEffect] forState:UIControlStateNormal];
    
    CGRect darkLightBounds = [self.backGroundView convertRect:self.darkLight.frame toView:nil];
    [self.darkLight setBackgroundImage:[[self.backGroundView screenShotImageWithBounds:darkLightBounds] applyDarkEffect] forState:UIControlStateNormal];
    
    CGRect extraLightBounds = [self.backGroundView convertRect:self.extraDarkLight.frame toView:nil];
    [self.extraDarkLight setBackgroundImage:[[self.backGroundView screenShotImageWithBounds:extraLightBounds] applyExtraLightEffect] forState:UIControlStateNormal];
    
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
