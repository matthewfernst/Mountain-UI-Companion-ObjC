//
//  LoginViewController.m
//  Mountain-UI-Companion-ObjC
//
//  Created by Matthew Ernst on 4/3/23.
//

#import "LoginViewController.h"


@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIView *invisibleViewForCenteringSignInButtons;
@property (strong, nonatomic) IBOutlet UIButton *learnMoreUIButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.signBackgroundLavendar;
    
    [self setupLearnMoreUIButton];
    [self setupSignInWithAppleUIButton];
    [self setupSignInWithGoogleUIButton];
}

- (void)setupLearnMoreUIButton
{
    NSMutableAttributedString *learnMoreButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"What is Mountain-UI? Learn More"];
    [learnMoreButtonTitle addAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:11]} range:NSMakeRange(0, 20)];
    [learnMoreButtonTitle addAttributes:@{NSForegroundColorAttributeName: [UIColor linkColor], NSFontAttributeName: [UIFont systemFontOfSize:11]} range:NSMakeRange(21, 10)];
    
    [self.learnMoreUIButton setAttributedTitle:learnMoreButtonTitle forState:UIControlStateNormal];
    [self.learnMoreUIButton addTarget:self action:@selector(showMountainUIDisplayPage) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showMountainUIDisplayPage
{
    NSURL *url = [[NSURL alloc] initWithString:kMountainUIDisplayGitHub];
    
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

// MARK: - Sign in Buttons
- (void)setupSignInWithAppleUIButton
{
    ASAuthorizationAppleIDButton *signInWithAppleButton = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhite];
    
    [signInWithAppleButton addTarget:self action:@selector(goToMainApp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signInWithAppleButton];
    
    signInWithAppleButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [signInWithAppleButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [signInWithAppleButton.bottomAnchor constraintEqualToAnchor:self.invisibleViewForCenteringSignInButtons.centerYAnchor constant:-5.0f],
        [signInWithAppleButton.widthAnchor constraintEqualToConstant:self.invisibleViewForCenteringSignInButtons.frame.size.width / 1.25f],
        [signInWithAppleButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

- (UIButton *)getSignInWithGoogleUIButton
{
    UIButtonConfiguration *configuration = UIButtonConfiguration.filledButtonConfiguration;
    
    configuration.cornerStyle = UIButtonConfigurationCornerStyleMedium;
    configuration.baseBackgroundColor = [UIColor whiteColor];
    
    UIImage *googleLogo = [[UIImage imageNamed:@"googleLogo.png"] scalePreservingAspectRatio:CGSizeMake(12.0f, 12.0f)];
    configuration.image = googleLogo;
    configuration.imagePadding = 4;
    configuration.imagePlacement = NSDirectionalRectEdgeLeading;
    
    configuration.attributedTitle = [[NSAttributedString alloc] initWithString:@"Sign in with Google" attributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:17.0 weight:UIFontWeightMedium],
        NSForegroundColorAttributeName: [UIColor blackColor]
    }];
    
    configuration.contentInsets = NSDirectionalEdgeInsetsMake(0, 11, 0, 0);
    
    UIButton *button = [[UIButton alloc] init];
    button.configuration = configuration;
    
    return button;
}

- (void)setupSignInWithGoogleUIButton
{
    UIButton *signInWithGoogleButton = [self getSignInWithGoogleUIButton];
    
    [signInWithGoogleButton addTarget:self action:@selector(goToMainApp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signInWithGoogleButton];
    
    signInWithGoogleButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
       [signInWithGoogleButton.centerXAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerXAnchor],
       [signInWithGoogleButton.topAnchor constraintEqualToAnchor:self.invisibleViewForCenteringSignInButtons.centerYAnchor constant:5],
       [signInWithGoogleButton.widthAnchor constraintEqualToConstant:self.invisibleViewForCenteringSignInButtons.frame.size.width / 1.25f],
       [signInWithGoogleButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

- (void)goToMainApp
{
    TabBarViewController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:TabBarViewController.identifier];
    
    tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:tabBarController animated:YES completion:nil];
}

@end
