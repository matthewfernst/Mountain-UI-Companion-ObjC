//
//  S3Utils.m
//  Mountain-UI-Companion-ObjC
//
//  Created by Matthew Ernst on 4/3/23.
//

#import <Foundation/Foundation.h>
#import "S3Utils.h"
@import AWSS3;

@implementation S3Utils

static NSString *const kZippedSlopesBucketName = @"mountain-ui-app-slopes-zipped";
static NSString *const kProfilePictureBucketName = @"mountain-ui-users-profile-pictures";
static NSString *const kS3BucketURL = @"https://mountain-ui-users-profile-pictures.s3.amazonaws.com";
static NSString *const kProfilePictureFileKey = @"profilePicture";


+ (void)uploadSlopesDataToS3WithId:(NSString *)id file:(NSURL *)file completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    
}


@end
