//
//  S3Utils.h
//  Mountain-UI-Companion-ObjC
//
//  Created by Matthew Ernst on 4/3/23.
//

#ifndef S3Utils_h
#define S3Utils_h
#import <Foundation/Foundation.h>
#import <AWSCore/AWSCore.h>
#import <AWSS3/AWSS3.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface S3Utils : NSObject

+ (void)uploadSlopesDataToS3WithId:(NSString *)id file:(NSURL *)file completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

+ (void)uploadProfilePictureToS3WithId:(NSString *)id picture:(UIImage *)picture completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

+ (NSString *)getProfilePictureObjectURLWithId:(NSString *)id;

+ (NSArray<NSString *> *)getSlopesDataFilesWithId:(NSString *)id;

+ (BOOL)isFileUploadedToS3WithId:(NSString *)id file:(NSURL *)file;

@end

NS_ASSUME_NONNULL_END


#endif /* S3Utils_h */
