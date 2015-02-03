//
//  DXPhoto.m
//  UICategories
//
//  Created by xiekw on 10/22/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "DXPhoto.h"

static NSString * const FastImagesDirectory = @"FastDemoImages";
static NSString * const InstagramImageDirectory = @"instagramImages";

@implementation DXPhoto


+ (NSArray *)photos {
    static NSMutableArray *images = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        images = [NSMutableArray array];
        NSMutableArray *allImageURLS = [NSMutableArray array];
        NSArray *texts = @[@"In a storyboard-based application, you will often want jkdlajfl;jk;adjfl;",
                           @"override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section",
                           @"let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell",
                           @"override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject",
                           @"override func numberOfSectionsInCollectionView"];
        
        NSArray *imageURLs = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"jpg" subdirectory:FastImagesDirectory];
        NSArray *imageURLs1 = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"JPG" subdirectory:InstagramImageDirectory];
        NSArray *imageURLs2 = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"PNG" subdirectory:InstagramImageDirectory];
        
        [allImageURLS addObjectsFromArray:imageURLs];
        [allImageURLS addObjectsFromArray:imageURLs1];
        [allImageURLS addObjectsFromArray:imageURLs2];

        
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        NSLog(@"** Generating thumbnails...");
        if (allImageURLS.count) {
            for (NSURL *imageURL  in allImageURLS) {
                UIImage *originImage = [UIImage imageWithContentsOfFile:[imageURL path]];
                DXPhoto *photo = [DXPhoto new];
                photo.thumbnail = [originImage thumbnailForSize:CGSizeMake(100, 100)];
                photo.display = [originImage thumbnailForScale:0.2];
                photo.photoDes = texts[arc4random()%texts.count];
                [images addObject:photo];
            }
        }
        
        NSLog(@"** Generated thumbnails in %g seconds", CFAbsoluteTimeGetCurrent() - startTime);
    });
    return images;
}

+ (DXPhoto *)onlyPhoto
{
    static DXPhoto *p = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        p = [DXPhoto new];
    });
    return p;
}

+ (UIImage *)anyImage
{
    NSArray *imageURLs = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"jpg" subdirectory:FastImagesDirectory];

    NSURL *imageURL = imageURLs[arc4random()%imageURLs.count];
    return [UIImage imageWithContentsOfFile:[imageURL path]];
}


@end
