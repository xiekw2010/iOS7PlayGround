//
//  ThumbnailCollectionViewCell.m
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "ThumbnailCollectionViewCell.h"

@implementation ThumbnailCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.imageView];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    
}

@end
