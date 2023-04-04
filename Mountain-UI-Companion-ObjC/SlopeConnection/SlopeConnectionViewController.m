//
//  SlopeConnectionViewController.m
//  Mountain-UI-Companion-ObjC
//
//  Created by Matthew Ernst on 4/2/23.
//

#import "SlopeConnectionViewController.h"

@import UniformTypeIdentifiers;

@interface SlopeConnectionViewController ()
@property (strong, nonatomic) IBOutlet UILabel *explanationTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *explanationTextView;
@property (strong, nonatomic) IBOutlet UIImageView *slopesFolderImageView;
@property (strong, nonatomic) IBOutlet UIButton *connectSlopesButton;
@property (strong, nonatomic) IBOutlet UIProgressView *slopeFilesUploadProgressView;

@property (strong, nonatomic) UIImageView *thumbsUpImageView;

@property (strong, nonatomic) UIDocumentPickerViewController *documentPicker;
@end

@implementation SlopeConnectionViewController

- (UIImageView *)thumbsUpImageView
{
    if (!_thumbsUpImageView) {
        _thumbsUpImageView = [[UIImageView alloc] init];
        _thumbsUpImageView.image = [UIImage systemImageNamed:@"hand.thumbsup.fill"];
        _thumbsUpImageView.tintColor = UIColor.systemBlueColor;
    }
    return _thumbsUpImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self anchorSlopeFilesUploadProgressView];
    [self setupThumbsUpImageViewAndManualSlopeFilesButton];
    
    [self showConnectToSlopesView];
}

- (void)anchorSlopeFilesUploadProgressView
{
    [self.slopeFilesUploadProgressView setHidden:YES];
    
    self.slopeFilesUploadProgressView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.slopeFilesUploadProgressView.centerXAnchor constraintEqualToAnchor:self.slopesFolderImageView.centerXAnchor],
        [self.slopeFilesUploadProgressView.centerYAnchor constraintEqualToAnchor:self.slopesFolderImageView.centerYAnchor],
        [self.slopeFilesUploadProgressView.widthAnchor constraintEqualToConstant:250]
    ]];
}

- (void)showConnectToSlopesView
{
    [self.thumbsUpImageView setHidden:YES];
    
    self.documentPicker = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:@[UTTypeFolder] asCopy:NO];
    self.documentPicker.delegate = self;
    self.documentPicker.shouldShowFileExtensions = YES;
    self.documentPicker.allowsMultipleSelection = YES;
    
    [self.connectSlopesButton addTarget:self action:@selector(selectSlopeFiles) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupThumbsUpImageViewAndManualSlopeFilesButton
{
    [self.view addSubview:self.thumbsUpImageView];
    [self.thumbsUpImageView setHidden:YES];
    
    self.thumbsUpImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.thumbsUpImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.thumbsUpImageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.thumbsUpImageView.widthAnchor constraintEqualToConstant:150],
        [self.thumbsUpImageView.heightAnchor constraintEqualToConstant:150]
    ]];
}

- (void)selectSlopeFiles
{
    [self presentViewController:self.documentPicker animated:YES completion:NULL];
}


// MARK: - Document Picker

- (BOOL)isSlopesFiles:(NSURL *)fileURL
{
    return !fileURL.hasDirectoryPath && [fileURL.pathExtension  isEqual: @"slopes"];
}


- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = urls[0];
        
        if (![url startAccessingSecurityScopedResource]) {
            // Handle the failure here.
//            [self showFileAccessNotAllowed];
            return;
        }
        
        @try {
            NSArray<NSURLResourceKey> *keys = @[NSURLNameKey, NSURLIsDirectoryKey];
            NSUInteger totalNumberOfFiles = [NSFileManager.defaultManager enumeratorAtURL:url includingPropertiesForKeys:keys options:0 errorHandler:nil].allObjects.count;
            
            NSDirectoryEnumerator<NSURL *> *fileList = [NSFileManager.defaultManager enumeratorAtURL:url includingPropertiesForKeys:keys options:0 errorHandler:nil];
            
//            [self setupSlopeFilesUploadingView];
            NSUInteger currentFileNumberBeingUploaded = 0;
            
            for (NSURL *fileURL in fileList) {
                if ([self isSlopesFiles:fileURL]) {
                    NSLog(@"chosen file: %@", fileURL.lastPathComponent);
                    
                    @try {
//                        [S3Utils uploadSlopesDataToS3WithID:self.profile.id file:fileURL];
                        currentFileNumberBeingUploaded += 1;
//                        [self updateSlopeFilesProgressViewWithFileBeingUploaded:[fileURL.lastPathComponent stringByReplacingOccurrencesOfString:@"%" withString:@" "]
//                                                                       progress:(float)currentFileNumberBeingUploaded / (float)totalNumberOfFiles];
                    } @catch (NSException *exception) {
                        NSLog(@"%@", exception.reason);
//                        [self showErrorUploadingToS3Alert];
                    }
                    
                    [url stopAccessingSecurityScopedResource];
                } else if ([fileURL.lastPathComponent isEqualToString:@".DS_Store"]) {
                    totalNumberOfFiles -= 1;
                } else {
//                    [self showFileExtensionNotSupportedWithFile:fileURL];
                    NSLog(@"Only slope file extensions are supported, but recieved %@ extension.", fileURL.pathExtension);
                }
            }
            
//            [self saveBookmarkForURL:url];
            
//            [self cleanUpSlopeFilesUploadView];
        } @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
//            [self showFileAccessNotAllowed];
        }
    });
}



@end
