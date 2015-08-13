//
//  ACSViewController.m
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

#import "ACSViewController.h"
#import "ACSDefaultsUtil.h"
#import <ACSPinKit/ACSPinController.h>

@interface ACSViewController () <ACSPinControllerDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *touchIDSwitch;
@property (nonatomic, strong) ACSPinController *pinController;
@property (nonatomic) ACSDefaultsUtil *defaultsUtil;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;

@end

@implementation ACSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.defaultsUtil = [[ACSDefaultsUtil alloc] init];
    self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" pinUserName:@"testuser" accessGroup:@"accesstest" delegate:self];
    self.pinController.retriesMax = 5;

    // Validation block for pin controller to check if entered pin is valid.
    __weak ACSViewController *weakSelf = self;
    self.pinController.validationBlock = ^(NSString *pin) {
        return [pin isEqualToString:weakSelf.defaultsUtil.savedPin];
    };
    
    [self.touchIDSwitch setOn:[self.defaultsUtil touchIDActive] animated:NO];
    [self updateTouchIDState];
    [self updateVerifyAndChangeState];
}

#pragma mark - Helper (Just for this app for updating UI State)

- (void)updateTouchIDState
{
    if (![self.pinController touchIDAvailable:NULL] || self.defaultsUtil.savedPin == nil) {
        [self.touchIDSwitch setOn:NO animated:YES];
        [self.defaultsUtil setTouchIDActive:NO];
        self.touchIDSwitch.enabled = NO;
    } else {
        self.touchIDSwitch.enabled = YES;
    }
}

- (void)updateVerifyAndChangeState {
    if (self.defaultsUtil.savedPin) {
        self.createButton.enabled = NO;
        self.changeButton.enabled = YES;
        self.verifyButton.enabled = YES;
    }
    else {
        self.createButton.enabled = YES;
        self.changeButton.enabled = NO;
        self.verifyButton.enabled = NO;
    }
}

- (void)updatePin:(NSString *)pin {
    [self.defaultsUtil savePin:pin];
    [self updateTouchIDState];
    [self updateVerifyAndChangeState];
    if (self.touchIDSwitch.on) {
        [self.pinController storePin:pin];
    }
}


- (void)resetPin {
    [self.pinController resetPIN];
    [self.defaultsUtil removePin];
    [self updateTouchIDState];
    [self updateVerifyAndChangeState];
}
#pragma mark - Button actions

- (IBAction)didSelectVerify:(id)sender {
    
    [self.pinController presentVerifyControllerFromViewController:self];
}

- (IBAction)didSelectCreate:(id)sender {
    
    [self.pinController presentCreateControllerFromViewController:self];
}

- (IBAction)didSelectChange:(id)sender {
    
    [self.pinController presentChangeControllerFromViewController:self];
}

- (IBAction)didSelectRemovePIN:(id)sender {
    [self resetPin];
}

- (IBAction)didSelectTouchIDSwitch:(UISwitch *)sender {
    
    [self.defaultsUtil setTouchIDActive:sender.on];
    if (sender.on) {
        [self.pinController storePin:self.defaultsUtil.savedPin];
    }
    else {
        [self.pinController resetPIN];
    }
}

- (IBAction)didSelectShowPinString:(id)sender {
    
    NSLog(@"In pin controller keychain: %@", [self.pinController storedPin]);
    NSLog(@"In user defaults (custom): %@", self.defaultsUtil.savedPin);
}

#pragma mark - Pin controller delegate

- (void)pinChangeController:(UIViewController *)pinChangeController didChangePin:(NSString *)pin
{
    NSLog(@"Did change pin: %@", pin);
    [self updatePin:pin];
}

- (void)pinCreateController:(UIViewController *)pinCreateController didCreatePin:(NSString *)pin
{
    NSLog(@"Did create pin: %@", pin);
    [self updatePin:pin];
}

- (void)pinController:(UIViewController *)pinController didVerifyPin:(NSString *)pin
{
    NSLog(@"Did verify pin: %@", pin);
}

- (void)pinControllerDidEnterWrongPin:(UIViewController *)pinController lastRetry:(BOOL)lastRetry
{
    NSLog(@"Did enter wrong pin - last retry? -> %@", lastRetry ? @"YES" : @"NO");
    if (lastRetry) {
        // Maybe show an alert view controller that indicates that the user has just one retry left?
    }
}

- (void)pinControllerCouldNotVerifyPin:(UIViewController *)pinController
{
    NSLog(@"Could not verify pin - no more retries!");
    [self resetPin];
}

- (void)pinControllerDidSelectCancel:(UIViewController *)pinController
{
    NSLog(@"Did select cancel!");
    [pinController dismissViewControllerAnimated:YES completion:nil];
}


@end
