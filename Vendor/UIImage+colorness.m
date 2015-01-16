//
//  UIImage+colorness.m
//  PhotoCleaner
//
//  Created by xiekw on 12/16/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "UIImage+colorness.h"

@implementation PCRGBReprestation

- (id)copyWithZone:(NSZone *)zone
{
    PCRGBReprestation *rgbRep = [[[self class] allocWithZone:zone] init];
    rgbRep.rgbObjs = self.rgbObjs;
    return rgbRep;
}

- (BOOL)isSatisfy:(PCRGBReprestation *)another
{
    static CGFloat offset = 50.0;
    
    if (self.rgbObjs.count != another.rgbObjs.count || another.rgbObjs.count != 4) {
        return NO;
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i ++) {
        PCImageRGBObject *fRGB = self.rgbObjs[i];
        PCImageRGBObject *aRGB = another.rgbObjs[i];
        if (abs(fRGB.R - aRGB.R) <= offset && abs(fRGB.G - aRGB.G) <= offset && abs(fRGB.B - aRGB.B) <= offset ) {
            [result addObject:[NSNull null]];
        }
    }
    return result.count >= 3;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.rgbObjs];
}

@end


@implementation PCImageRGBObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"R:%f G:%f B:%f", self.R, self.G, self.B];
}

@end

@implementation UIImage (colorness)

- (PCRGBReprestation *)colorness
{    
    CGImageRef imageRef = [self CGImage];
    CGSize imageSize = self.size;
    CGSize cropSize = CGSizeMake(imageSize.width*0.5, imageSize.height*0.5);
    CGImageRef leftUp = CGImageCreateWithImageInRect(imageRef, (CGRect){CGPointZero, cropSize});
    CGImageRef rightUp = CGImageCreateWithImageInRect(imageRef, (CGRect){CGPointMake(imageSize.width*0.5, 0), cropSize});
    CGImageRef leftDown = CGImageCreateWithImageInRect(imageRef, (CGRect){CGPointMake(0, imageSize.height*0.5), cropSize});
    CGImageRef rightDown = CGImageCreateWithImageInRect(imageRef, (CGRect){CGPointMake(imageSize.width*0.5, imageSize.height*0.5), cropSize});
    
    CGImageRef ref = imageRef;
    NSMutableArray *resultRGB = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        switch (i) {
            case 0:
                ref = leftUp;
                break;
            case 1:
                ref = rightUp;
                break;
            case 2:
                ref = leftDown;
                break;
            case 3:
                ref = rightDown;
                break;
            default:
                break;
        }
        
        CGDataProviderRef dataProviderRef = CGImageGetDataProvider(ref);
        NSData *pixelData = (__bridge_transfer NSData *)CGDataProviderCopyData(dataProviderRef);
        PCImageRGBObject *rgb = [PCImageRGBObject new];
        if ([pixelData length] > 0) {
            const UInt8 *pixelBytes = [pixelData bytes];
            
            // Whether or not the image format is opaque, the first byte is always the alpha component, followed by RGB.
            UInt8 pixelR = pixelBytes[1];
            UInt8 pixelG = pixelBytes[2];
            UInt8 pixelB = pixelBytes[3];
            
            rgb.R = pixelR;
            rgb.G = pixelG;
            rgb.B = pixelB;
        }
        [resultRGB addObject:rgb];
    }
//    NSLog(@"RGB is %@", resultRGB);
    PCRGBReprestation *rep = [PCRGBReprestation new];
    rep.rgbObjs = resultRGB;
    return rep;
}


@end
