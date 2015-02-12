//
//  ACSAppDelegate.m
//  ACSPinKit
//
//  Created by CocoaPods on 01/09/2015.
//  Copyright (c) 2014 Orlando Schäfer. All rights reserved.
//

#import "ACSAppDelegate.h"
#import <ACSPinController.h>

@interface ACSAppDelegate () <ACSPinControllerDelegate>

@property (nonatomic) ACSPinController *pinController;
@property (nonatomic, strong) UINavigationController *navController;

@end

@implementation ACSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" andPinUserName:@"testuser" delegate:self];
    
    // Customization
    self.pinController.pinCustomizer.titleImage = [UIImage imageNamed:@"arconsis_logo"];
    self.pinController.pinCustomizer.actionButtonImage = [UIImage imageNamed:@"icon_burger"];
    UIColor *blueColor = [UIColor colorWithRed:0.3 green:0.49 blue:0.67 alpha:1];
    self.pinController.pinCustomizer.keyboardTitleColor = blueColor;
    self.pinController.pinCustomizer.headerTitleColor = blueColor;
    self.pinController.pinCustomizer.passcodeDotsColor = blueColor;
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    self.window.rootViewController = [self pincodeController];
}

- (UIViewController *)mainController
{
    UIViewController *mainController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateInitialViewController];
    return mainController;
}

- (UIViewController *)pincodeController
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UIViewController *pinController = [self.pinController verifyControllerFullscreenForCustomPresentationUsingTouchID:[userDefaults boolForKey:@"touchIDActive"]];
    return pinController;
}


- (void)pinController:(UIViewController *)pinController didVerifyPin:(NSString *)pin
{
    [self showMainController];
}

- (void)pinControllerDidEnterWrongPin:(UIViewController *)pinController lastRetry:(BOOL)lastRetry
{
    
}

- (void)pinControllerCouldNotVerifyPin:(UIViewController *)pinController
{
    [self showMainController];
}

- (void)pinController:(UIViewController *)pinController didSelectCustomActionButton:(UIButton *)actionButton
{
    NSLog(@"Custom action! Do something cool!");
}

- (void)showMainController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            self.window.rootViewController = [self mainController];
            
        } completion:^(BOOL finished) {
            
        }];
    });
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    UIViewController *rootController = window.rootViewController;
    
    if ([rootController isKindOfClass:[UINavigationController class]]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }

}

@end
