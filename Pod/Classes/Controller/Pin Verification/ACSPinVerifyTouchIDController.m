//
// Created by Orlando Schäfer on 09/02/15.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinVerifyTouchIDController.h"
#import "ACSLocalAuthentication.h"
#import "ACSPinDisplay.h"


@implementation ACSPinVerifyTouchIDController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.localAuthentication) {
        [self.localAuthentication authenticate];
    }
}

- (void)localAuthenticationAuthenticatedSuccessfully:(ACSLocalAuthentication *)localAuthentication
{
    // User authenticated: Get passcode and fill the dots...disable user interaction because we
    // trigger a little delay for dismissing the verify controller.
    NSString *storedPin = [self.pinVerifyDelegate pinStringForPinVerifyController:self];
    [self.displayController updatePasscodeLabelWithString:storedPin];
    self.view.userInteractionEnabled = NO;
    
    // After 0.3 seconds we send the success notification...
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.view.userInteractionEnabled = YES;
        [self.pinVerifyDelegate pinVerifyControllerDidVerifyPIN:self];
    });
    
}

- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication failedWithError:(NSError *)error
{
    
}

@end