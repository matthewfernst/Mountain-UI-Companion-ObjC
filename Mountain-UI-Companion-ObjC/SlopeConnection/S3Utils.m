//
//  S3Utils.m
//  Mountain-UI-Companion-ObjC
//
//  Created by Matthew Ernst on 4/3/23.
//

#import <Foundation/Foundation.h>
#import "S3Utils.h"
//#import <AWSS3/AWSS3.h>

@implementation S3Utils

static NSString *const kZippedSlopesBucketName = @"mountain-ui-app-slopes-zipped";
static NSString *const kProfilePictureBucketName = @"mountain-ui-users-profile-pictures";
static NSString *const kS3BucketURL = @"https://mountain-ui-users-profile-pictures.s3.amazonaws.com";
static NSString *const kProfilePictureFileKey = @"profilePicture";


+ (void)uploadSlopesDataToS3WithId:(NSString *)id file:(NSURL *)file completionHandler:(nullable void (^)(NSError * _Nullable))completionHandler
{
    NSString *fileKey = [NSString stringWithFormat:@"%@/%@", id, [file lastPathComponent]];
    NSData *fileData = [NSData dataWithContentsOfURL:file];
    
    [self uploadDataWithFileKey:fileKey fileData:fileData bucketName:kZippedSlopesBucketName completionHandler:^(NSError * _Nullable error){
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completionHandler(error);
        } else {
            completionHandler(nil);
        }
    }];
}

+ (void)uploadProfilePictureToS3WithId:(NSString *)id picture:(UIImage *)picture completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    NSString *fileKey = [NSString stringWithFormat:@"%@/profilePicture", id];
    NSData *fileData = UIImageJPEGRepresentation(picture, 0.8);
    
    if (fileData) {
        [self uploadDataWithFileKey:fileKey fileData:fileData bucketName:kProfilePictureFileKey completionHandler:^(NSError * _Nullable error){
            // TODO: Do something??
        }];
    } else {
        completionHandler(nil);
    }
}

+ (void)uploadDataWithFileKey:(NSString *)fileKey fileData:(NSData *)fileData bucketName:(NSString *)bucketName completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    [self createFileWithKey:fileKey data:fileData bucketName:bucketName];
}

+ (void)createFileWithKey:(NSString *)key data:(NSData *)data bucketName:(NSString *)bucketName
{
//    AWSS3 *s3 = [AWSS3 defaultS3];
//    AWSS3PutObjectRequest *putObjectRequest = [AWSS3PutObjectRequest new];
//    putObjectRequest.bucket = bucketName;
//    putObjectRequest.key = key;
//    putObjectRequest.body = data;
//    AWSTask *task = [s3 putObject:putObjectRequest];
//    [task continueWithBlock:^id _Nullable(AWSTask * _Nonnull t) {
//        if (t.error) {
//            NSLog(@"Error uploading to S3: %@", t.error);
//        } else {
//            NSLog(@"Upload to S3 succeeded.");
//        }
//        return nil;
//    }];
}


@end
