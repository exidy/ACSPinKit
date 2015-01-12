//
// Created by Orlando Schäfer on 18/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinCreateDelegateManager.h"


@implementation ACSPinCreateDelegateManager

#pragma mark - Create Delegates

- (void)pinCreateController:(ACSPinCreateController *)pinCreateController didCreatePIN:(NSString *)pin
{
    [self.keychainHelper savePin:pin];
    [self.keychainHelper resetRetriesToGoCount];

    if ([self.pinControllerDelegate respondsToSelector:@selector(pinCreateController:didCreatePin:)]) {
        [self.pinControllerDelegate pinCreateController:pinCreateController didCreatePin:pin];
    }
    [pinCreateController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pinCreateController:(ACSPinCreateController *)pinCreateController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem
{
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerDidSelectCancel:)]) {
        [self.pinControllerDelegate pinControllerDidSelectCancel:pinCreateController];
    }
}

@end