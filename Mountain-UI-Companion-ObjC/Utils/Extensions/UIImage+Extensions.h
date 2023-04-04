//
//  UIImage+Extensions.h
//  Mountain-UI-Companion-ObjC
//
//  Created by Matthew Ernst on 4/3/23.
//
#import <UIKit/UIKit.h>

#ifndef UIImage_Extensions_h
#define UIImage_Extensions_h

@interface UIImage (Extensions)

- (UIImage *)scalePreservingAspectRatio:(CGSize)targetSize;

@end

#endif /* UIImage_Extensions_h */
