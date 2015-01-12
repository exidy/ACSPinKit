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

@property (nonatomic, strong) ACSPinController *pinController;
@end

@implementation ACSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" andPinUserName:@"testuser" delegate:self];
    self.pinController.retriesMax = 5;

    // Uncomment following lines for testing customization
//    ACSPinCustomizer *customizer = self.pinController.pinCustomizer;
//    customizer.displayBackgroundColor = [UIColor redColor];
    
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

#pragma mark - Pin controller delegate

- (void)pinChangeController:(UIViewController *)pinChangeController didChangePin:(NSString *)pin
{
    NSLog(@"Did change pin: %@", pin);
}

- (void)pinCreateController:(UIViewController *)pinCreateController didCreatePin:(NSString *)pin
{
    NSLog(@"Did create pin: %@", pin);
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
