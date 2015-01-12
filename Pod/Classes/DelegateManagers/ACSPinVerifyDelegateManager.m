//
// Created by Orlando Schäfer on 18/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinVerifyDelegateManager.h"


@implementation ACSPinVerifyDelegateManager

#pragma mark - Verify Delegates

- (NSString *)pinStringForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self storedPin];
}

- (BOOL)alreadyHasRetriesForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.keychainHelper retriesToGoCount] < [self.keychainHelper retriesMax];
}

- (NSUInteger)retriesMaxForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.keychainHelper retriesToGoCount];
}

- (void)pinVerifyControllerDidVerifyPIN:(ACSPinVerifyController *)pinVerifyController
{
    [self.keychainHelper resetRetriesToGoCount];
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinController:didVerifyPin:)]) {
        [self.pinControllerDelegate pinController:pinVerifyController didVerifyPin:[self storedPin]];
    }
    [pinVerifyController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pinVerifyControllerDidEnterWrongPIN:(ACSPinVerifyController *)pinVerifyController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft
{

    [self.keychainHelper incrementRetryCount];
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerDidEnterWrongPin:lastRetry:)]) {
        [self.pinControllerDelegate pinControllerDidEnterWrongPin:pinVerifyController lastRetry:onlyOneRetryLeft];
    }
}

- (void)pinVerifyControllerCouldNotVerifyPIN:(ACSPinVerifyController *)pinVerifyController
{
    [self.keychainHelper resetRetriesToGoCount];
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerCouldNotVerifyPin:)]) {
        [self.pinControllerDelegate pinControllerCouldNotVerifyPin:pinVerifyController];
    }
    [pinVerifyController dismissViewControllerAnimated:YES completion:nil];

}

- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem
{
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerDidSelectCancel:)]) {
        [self.pinControllerDelegate pinControllerDidSelectCancel:pinVerifyController];
    }
}

- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didSelectActionButton:(UIButton *)actionButton
{
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinController:didSelectCustomActionButton:)]) {
        [self.pinControllerDelegate pinController:pinVerifyController didSelectCustomActionButton:actionButton];
    }
}

@end