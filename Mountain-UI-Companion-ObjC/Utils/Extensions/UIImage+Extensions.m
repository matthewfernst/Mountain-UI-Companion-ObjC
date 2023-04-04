//
//  UIImage+Extensions.m
//  Mountain-UI-Companion-ObjC
//
//  Created by Matthew Ernst on 4/3/23.
//

#import <Foundation/Foundation.h>
#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)

- (UIImage *)scalePreservingAspectRatio:(CGSize)targetSize
{
    // Determine the scale factor that preserves aspect ratio
    CGFloat widthRatio = targetSize.width / self.size.width;
    CGFloat heightRatio = targetSize.height / self.size.height;
    CGFloat scaleFactor = fmin(widthRatio, heightRatio);
    
    // Compute the new image size that preserves aspect ratio
    CGSize scaledImageSize = CGSizeMake(
        self.size.width * scaleFactor,
        self.size.height * scaleFactor
    );
    
    // Draw and return the resized UIImage
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:scaledImageSize];
    UIImage *scaledImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [self drawInRect:CGRectMake(CGPointZero.x, CGPointZero.y, scaledImageSize.width, scaledImageSize.height)];
    }];
    
    return scaledImage;
}

@end
