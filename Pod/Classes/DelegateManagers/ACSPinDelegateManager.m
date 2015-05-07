//
// Created by Orlando Schäfer on 18/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinDelegateManager.h"
#import "ACSPinVerifyDelegateManager.h"
#import "ACSPinCreateDelegateManager.h"
#import "ACSPinChangeDelegateManager.h"


@implementation ACSPinDelegateManager

#pragma mark - Keychain access

- (NSString *)storedPin
{
    return [self.keychainHelper savedPin];
}

- (BOOL)storePIN:(NSString *)pin
{
    return [self.keychainHelper savePin:pin];
}

- (BOOL)resetPIN
{
    return [self.keychainHelper resetPin];
}

- (void)setRetriesMax:(NSUInteger)retriesMax
{
    _retriesMax = retriesMax;
    [self.keychainHelper saveRetriesMax:_retriesMax];
}

- (void)setValidationBlock:(BOOL (^)(NSString *))validationBlock
{
    _validationBlock = validationBlock;
    _pinVerifyDelegateManager.validationBlock = _validationBlock;
    _pinChangeDelegateManager.validationBlock = _validationBlock;
    _pinCreateDelegateManager.validationBlock = _validationBlock;
}

- (void)setPinChangeDelegateManager:(ACSPinChangeDelegateManager *)pinChangeDelegateManager
{
    _pinChangeDelegateManager = pinChangeDelegateManager;

    self.pinChangeDelegateManager.keychainHelper = self.keychainHelper;
    self.pinChangeDelegateManager.pinControllerDelegate = self.pinControllerDelegate;
}

- (void)setPinCreateDelegateManager:(ACSPinCreateDelegateManager *)pinCreateDelegateManager
{
    _pinCreateDelegateManager = pinCreateDelegateManager;

    self.pinCreateDelegateManager.keychainHelper = self.keychainHelper;
    self.pinCreateDelegateManager.pinControllerDelegate = self.pinControllerDelegate;
}

- (void)setPinVerifyDelegateManager:(ACSPinVerifyDelegateManager *)pinVerifyDelegateManager
{
    _pinVerifyDelegateManager = pinVerifyDelegateManager;

    self.pinVerifyDelegateManager.keychainHelper = self.keychainHelper;
    self.pinVerifyDelegateManager.pinControllerDelegate = self.pinControllerDelegate;
}

@end