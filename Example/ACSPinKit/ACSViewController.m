//
//  ACSViewController.m
//  ACSPinKit
//
//  Created by Orlando Schäfer on 01/09/2015.
//  Copyright (c) 2014 Orlando Schäfer. All rights reserved.
//

#import "ACSViewController.h"
#import <ACSPinKit/ACSPinController.h>

@interface ACSViewController () <ACSPinControllerDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *touchIDSwitch;
@property (nonatomic, strong) ACSPinController *pinController;
@end

@implementation ACSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" pinUserName:@"testuser" accessGroup:@"accesstest" delegate:self];
    self.pinController.retriesMax = 5;
    
    [self.touchIDSwitch setOn:[self touchIDActive] animated:NO];
    if (![self.pinController touchIDAvailable:NULL]) {
        [self.touchIDSwitch setOn:NO animated:NO];
        [self setTouchIDActive:NO];
        self.touchIDSwitch.enabled = NO;
    }
    
}

#pragma mark - User defaults

- (BOOL)touchIDActive
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"touchIDActive"];
}

- (void)setTouchIDActive:(BOOL)active
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:active forKey:@"touchIDActive"];
    [userDefaults synchronize];
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

- (IBAction)didSelectShowPinString:(id)sender {
    
    NSLog(@"%@", [self.pinController storedPin]);
}

- (IBAction)didSelectRemovePIN:(id)sender {
    
    [self.pinController resetPIN];
}
- (IBAction)didSelectTouchIDSwitch:(UISwitch *)sender {
    
    [self setTouchIDActive:sender.on];
}

#pragma mark - Pin controller delegate

- (void)pinChangeController:(UIViewController *)pinChangeController didChangePin:(NSString *)pin
{
    NSLog(@"Did change pin: %@", pin);
    [[NSUserDefaults standardUserDefaults] setObject:pin forKey:@"PIN"];
}

- (void)pinCreateController:(UIViewController *)pinCreateController didCreatePin:(NSString *)pin
{
    NSLog(@"Did create pin: %@", pin);
    [[NSUserDefaults standardUserDefaults] setObject:pin forKey:@"PIN"];
}

- (void)pinController:(UIViewController *)pinController didVerifyPin:(NSString *)pin
{
    NSLog(@"Did verify pin: %@", pin);
}

- (void)pinControllerDidEnterWrongPin:(UIViewController *)pinController lastRetry:(BOOL)lastRetry
{
    NSLog(@"Did enter wrong pin - last retry? -> %@", lastRetry ? @"YES" : @"NO");
}

- (void)pinControllerCouldNotVerifyPin:(UIViewController *)pinController
{
    NSLog(@"Could not verify pin - no more retries!");
}

- (void)pinControllerDidSelectCancel:(UIViewController *)pinController
{
    NSLog(@"Did select cancel!");
    [pinController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pinController:(UIViewController *)pinController didSelectCustomActionButton:(UIButton *)actionButton
{
    NSLog(@"Custom action! Do something cool!");
}

@end
