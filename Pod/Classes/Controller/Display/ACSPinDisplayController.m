//
//  ACSPinDisplayController.m
//  PinTest
//
//  Created by Orlando Schäfer on 26/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinDisplayController.h"
#import "ACSPinFormatterHelper.h"
#import "ACSPinAnimationHelper.h"
#import "ACSPinDisplayView.h"

@interface ACSPinDisplayController ()

@property (nonatomic) NSInteger completionCallsCount;

@end

@implementation ACSPinDisplayController

- (void)loadView
{
    self.view = self.displayView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.displayView.alertLabel.alpha = 0.0;

    self.completionCallsCount = 0;

    [self updatePasscodeLabelWithString:nil];
}

- (void)updatePasscodeLabelWithString:(NSString *)string
{
    self.displayView.passcodeLabel.text = [ACSPinFormatterHelper secure4DigitsPasscodeStringForString:string];
}

- (void)updateHeaderLabelWithString:(NSString *)string
{
    self.displayView.headerLabel.text = string;
}

- (void)updateAlertLabelWithString:(NSString *)string
{
    self.displayView.alertLabel.text = string;
    self.displayView.alertLabel.alpha = 1.0;
}

- (void)animateForErrorWithAlertString:(NSString *)alertString completion:(void (^)(void))completion
{
    [ACSPinAnimationHelper animateBouncingWithPasscodeLabel:self.displayView.passcodeLabel updateBlock:^{

        [self updatePasscodeLabelWithString:nil];
        self.displayView.alertLabel.text = alertString;
        self.displayView.alertLabel.alpha = 1.0;

    } completion:^{

        if (completion) {
            completion();
        }
    }];
}

- (void)animateForRepetitionWithHeaderString:(NSString *)string withCompletion:(void (^)(void))completion
{
    [ACSPinAnimationHelper animateLeftOutRightInWithLabel:self.displayView.passcodeLabel updateBlock:^{

        [self updatePasscodeLabelWithString:nil];
        
    } completion:^{
        [self checkForCompletionWithBlock:completion];
    }];

    [ACSPinAnimationHelper animateFadeInTextForLabel:self.displayView.headerLabel withString:string updateBlock:^{

    } completion:^{
        [self checkForCompletionWithBlock:completion];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.displayView.alertLabel.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self checkForCompletionWithBlock:completion];
    }];
}



- (void)checkForCompletionWithBlock:(void (^)(void))completion
{
    self.completionCallsCount++;

    if (_completionCallsCount == 3) {
        self.completionCallsCount = 0;
        if (completion) {
            completion();
        }
    }
}

@end
