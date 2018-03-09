//
//  UIImage+SFBuilder.m
//  DDG
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UIImage+SFBuilder.h"
#import "SFUtils.h"

@implementation UIImage (SFBuilder)

- (UIColor *(^)(CGPoint point))imgGetColorAtPoint {
    return ^(CGPoint p){
        return [SFUtils image:self colorAtPixel:p];
    };
}

- (SFPropertyUIImageEmptyBlock)imgToCircleImage {
    return ^(){
        UIGraphicsBeginImageContext(self.size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextAddEllipseInRect(ctx, rect);
        CGContextClip(ctx);
        [self drawInRect:rect];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    };
}

- (SFPropertyUIImageObjectBlock)imgChangImgColor
{
    return ^(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, 0, self.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextSetBlendMode(context, kCGBlendModeNormal);
            CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
            CGContextClipToMask(context, rect, self.CGImage);
            [color setFill];
            CGContextFillRect(context, rect);
            UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return newImage;
        }
        return self;
    };
}

- (SFPropertyUIImageCSizeBlock)imgScanWithSize
{
    return ^(CGSize newSize){
        UIGraphicsBeginImageContext(newSize);
        [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        return newImage;
    };
}

@end
