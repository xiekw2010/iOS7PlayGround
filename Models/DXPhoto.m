//
//  DXPhoto.m
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "DXPhoto.h"

@implementation DXPhoto

+ (NSArray *)photos {
    static NSArray *images = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *imageURLs = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"jpg" subdirectory:@"instagramImages"];
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        NSLog(@"** Generating thumbnails...");

        if (imageURLs.count) {
            NSMutableArray *photos = [NSMutableArray array];
            for (NSURL *imageURL  in imageURLs) {
                UIImage *originImage = [UIImage imageWithContentsOfFile:[imageURL path]];
                DXPhoto *photo = [DXPhoto new];
                photo.thumbnail = [originImage thumbnailForSize:CGSizeMake(100, 100)];
                photo.display = [originImage thumbnailForScale:0.5];
                [photos addObject:photo];
            }
            images = [NSArray arrayWithArray:photos];
        }
        NSLog(@"** Generated thumbnails in %g seconds", CFAbsoluteTimeGetCurrent() - startTime);

    });
    return images;
}



@end
