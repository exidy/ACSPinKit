//
//  ACSPinChangeController.m
//  PinTest
//
//  Created by Orlando Schäfer on 26/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinChangeController.h"
#import "ACSI18NHelper.h"


@implementation ACSPinChangeController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:ACSI18NString(kACSButtonCancelTitle)
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(didSelectCancelButtonItem:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;

    [self addChildControllers];

    self.view.backgroundColor = self.pinVerifyController.view.backgroundColor;
    self.pinCreateController.view.hidden = YES;
}

- (void)didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem
{
    [self.pinChangeDelegate pinChangeController:self didSelectCancelButtonItem:cancelButtonItem];
}

- (void)addChildControllers
{
    [self addChildViewController:self.pinVerifyController];
    [self.view addSubview:self.pinVerifyController.view];
    [self.pinVerifyController didMoveToParentViewController:self];

    [self addChildViewController:self.pinCreateController];
    [self.view addSubview:self.pinCreateController.view];
    [self.pinCreateController didMoveToParentViewController:self];

    self.pinVerifyController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.pinCreateController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[verify]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"verify":self.pinVerifyController.view}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[create]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"create":self.pinCreateController.view}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][create]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"top":self.topLayoutGuide, @"create":self.pinCreateController.view}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][verify]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"top":self.topLayoutGuide, @"verify":self.pinVerifyController.view}]];
    
}

- (NSString *)pinStringForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.pinChangeDelegate pinStringForPinChangeController:self];
}

- (BOOL)alreadyHasRetriesForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.pinChangeDelegate alreadyHasRetriesForPinChangeController:self];
}

- (NSUInteger)retriesMaxForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.pinChangeDelegate retriesMaxForPinChangeController:self];
}

- (void)pinVerifyControllerDidVerifyPIN:(ACSPinVerifyController *)pinController
{
    self.pinCreateController.view.hidden = NO;
    self.pinVerifyController.view.hidden = YES;

    [self.pinChangeDelegate pinChangeControllerDidVerifyOldPIN:self];
}

- (void)pinVerifyControllerDidEnterWrongPIN:(ACSPinVerifyController *)pinController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft
{
    [self.pinChangeDelegate pinChangeControllerDidEnterWrongOldPIN:self onlyOneRetryLeft:onlyOneRetryLeft];
}

- (void)pinVerifyControllerCouldNotVerifyPIN:(ACSPinVerifyController *)pinController
{
    [self.pinChangeDelegate pinChangeControllerCouldNotVerifyOldPIN:self];
}

- (void)pinCreateController:(ACSPinCreateController *)pinCreateController didCreatePIN:(NSString *)pin
{
    [self.pinChangeDelegate pinChangeController:self didChangePIN:pin];
}

@end
