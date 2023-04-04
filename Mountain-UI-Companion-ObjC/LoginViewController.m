//
//  LoginViewController.m
//  Mountain-UI-Companion-ObjC
//
//  Created by Matthew Ernst on 4/3/23.
//

#import "LoginViewController.h"
#import "UIColor+Extensions.h"
#import "Constants.h"

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

@end
