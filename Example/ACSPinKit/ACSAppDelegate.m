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
    // Override point for customization after application launch.
    
    self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" andPinUserName:@"testuser" delegate:self];
    
    self.pinController.pinCustomizer.titleImage = [UIImage imageNamed:@"arconsis_logo"];
    self.pinController.pinCustomizer.actionButtonImage = [UIImage imageNamed:@"icon_burger"];
    UIColor *blueColor = [UIColor colorWithRed:0.3 green:0.49 blue:0.67 alpha:1];
    self.pinController.pinCustomizer.keyboardTitleColor = blueColor;
    self.pinController.pinCustomizer.headerTitleColor = blueColor;
    self.pinController.pinCustomizer.passcodeDotsColor = blueColor;
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    self.window.rootViewController = [self pincodeController];
}

- (UIViewController *)mainController
{
    
    UIViewController *mainController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateInitialViewController];
    return mainController;
}

- (UIViewController *)pincodeController
{
    
    UIViewController *pinController = [self.pinController verifyControllerFullscreenForCustomPresentation];
    
    
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

- (void)pinControllerDidSelectCustomActionButton:(UIViewController *)pinController
{
    NSLog(@"Custom action!");
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

@end
