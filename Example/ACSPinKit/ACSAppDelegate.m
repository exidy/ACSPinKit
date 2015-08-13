//
//  ACSAppDelegate.m
//  Created by Orlando Schäfer
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 arconsis IT-Solutions GmbH <contact@arconsis.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "ACSAppDelegate.h"
#import "ACSDefaultsUtil.h"
#import <ACSPinController.h>

@interface ACSAppDelegate () <ACSPinControllerDelegate>

@property (nonatomic) ACSPinController *pinController;
@property (nonatomic) ACSDefaultsUtil *defaultsUtil;

@end

@implementation ACSAppDelegate

#pragma mark - Application Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.defaultsUtil = [[ACSDefaultsUtil alloc] init];

    self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" pinUserName:@"testuser" accessGroup:@"accesstest" delegate:self];
    self.pinController.retriesMax = 5;

    // Validation block for pin controller to check if entered pin is valid. Only when not using touch id.
    __weak ACSAppDelegate *weakSelf = self;
    self.pinController.validationBlock = ^(NSString *pin) {
        return [pin isEqualToString:weakSelf.defaultsUtil.savedPin];
    };

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
    
    if (self.defaultsUtil.savedPin) {
        self.window.rootViewController = [self pincodeController];
    }
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

#pragma mark - Pin controller delegate

- (void)pinController:(UIViewController *)pinController didVerifyPin:(NSString *)pin
{
    NSLog(@"PIN verified!");
    [self showMainController];
}

- (void)pinControllerDidEnterWrongPin:(UIViewController *)pinController lastRetry:(BOOL)lastRetry
{
    NSLog(@"You entered a wrong PIN");
    
    if (lastRetry) {
        NSLog(@"This is your last retry!");
    }
}

- (void)pinControllerCouldNotVerifyPin:(UIViewController *)pinController
{
    NSLog(@"Could not verify PIN. Now you should delete all data and logout an existent user...");
    [self.pinController resetPIN];
    [self.defaultsUtil removePin];
    [self showMainController];
}

- (void)pinControllerCouldNotVerifyTouchID:(UIViewController *)pinController withError:(NSError *)error
{
    NSLog(@"Touch ID failed");
}

- (void)pinController:(UIViewController *)pinController didSelectCustomActionButton:(UIButton *)actionButton
{
    NSLog(@"Custom action! Do something cool!");
}

#pragma mark - Pin controller appearance at startup

- (void)showMainController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            self.window.rootViewController = [self mainController];
            
        } completion:^(BOOL finished) {
            
        }];
    });
}

- (UIViewController *)mainController
{
    UIViewController *mainController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateInitialViewController];
    return mainController;
}

- (UIViewController *)pincodeController
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL useTouchID = [userDefaults boolForKey:@"touchIDActive"] && [self.pinController storedPin] != nil;
    UIViewController *pinController = [self.pinController verifyControllerFullscreenForCustomPresentationUsingTouchID:useTouchID];
    return pinController;
}


@end
